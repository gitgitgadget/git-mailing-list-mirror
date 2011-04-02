From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Better big file support & GSoC
Date: Sat, 2 Apr 2011 17:30:15 +0200
Message-ID: <20110402153008.GA5921@centaur.lab.cmartin.tk>
References: <20110402164051.1f263aa0@RunningPinguin.chalmion.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Michalon <johndescs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 17:38:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q62ue-0006zS-PJ
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 17:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1DBPiv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 11:38:51 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56012 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431Ab1DBPiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 11:38:50 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Apr 2011 11:38:50 EDT
Received: from centaur.lab.cmartin.tk (brln-4db9fb82.pool.mediaWays.net [77.185.251.130])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id AF36D4610F;
	Sat,  2 Apr 2011 17:30:04 +0200 (CEST)
Received: (nullmailer pid 5968 invoked by uid 1000);
	Sat, 02 Apr 2011 15:30:15 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jonathan Michalon <johndescs@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110402164051.1f263aa0@RunningPinguin.chalmion.homelinux.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170652>

On Sat, Apr 02, 2011 at 04:40:51PM +0200, Jonathan Michalon wrote:
> [...]
> Eric Montellese says: "Don't track binaries in git. Track their hashe=
s." I agree
> here too. We should not treat computer data like source code (or what=
ever text).
> He claims that he needs to handle repos containing source code + zipp=
ed tarballs
> + large and/or many binaries. Users seem to really need binary tracki=
ng and
> therefore git should do it. I personally needed to a couple of times.
>=20
> He also says that we could want to do download-as-needed and remove-u=
nnecessary
> operations, and I think that it may be clean enough to add a git comm=
and like
> 'git blob' to handle special operations for binaries. Perhaps in a se=
cond step.
>=20
> Another idea was to create "sparse" repos, considered leafs as they m=
ay not be
> cloned from because they lack full data. But it may or may not be in =
the
> spirit of Git...
>=20
>=20
> What I personally would like as a feature is the ability to store the=
 main
> repo with sources etc. into a conventional repo but put the data else=
where
> on a storage location. This would allow to develop programs which nee=
d data
> to run (like textures in games etc.) without making the repo slow, bi=
g or
> just messy.

 This sounds a lot like like what git-annex [0] does. Maybe
 integrating its functionality with mainline git could be a good
 start.

[0] http://git-annex.branchable.com/

   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk
