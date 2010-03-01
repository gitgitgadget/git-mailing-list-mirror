From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: [BUG?] fail to svn clone debian's kernel repository
Date: Mon, 01 Mar 2010 03:08:40 +0100
Message-ID: <4B8B21A8.6000603@hartwork.org>
References: <20090610160524.GA24435@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Mar 01 03:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlv9U-0001bq-HF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 03:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab0CACO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 21:14:27 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:59273 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0CACO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 21:14:26 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Feb 2010 21:14:26 EST
Received: from [78.52.97.162] (helo=[192.168.0.3])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Nlv3t-0003R8-Qv; Mon, 01 Mar 2010 03:08:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100228 Thunderbird/3.0.1
In-Reply-To: <20090610160524.GA24435@pengutronix.de>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141294>

On 06/10/09 18:05, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> using git v1.6.3.1 from Debian I fail to successfully run
>=20
> 	git svn clone svn://svn.debian.org/kernel/dists/trunk/linux-2.6
>=20
> It runs for some time and then ends in:
>=20
> 	...
> 	r4695 =3D f552d98386b301cbeaa3b5a20f9e9d5d3c9c4886 (git-svn)
> 		M	debian/arch/alpha/defines
> 	r4696 =3D 18c0a37de057d24955b66e8f49db0791f6018288 (git-svn)
> 	Found possible branch point: svn://svn.debian.org/kernel/dists/sid/l=
inux-2.6 =3D> svn://svn.debian.org/kernel/dists/trunk/linux-2.6, 4731
> 	Initializing parent: git-svn@4731
> 	W: Ignoring error from SVN, path probably does not exist: (160013): =
=46ilesystem has no item: File not found: revision 101, path '/dists/si=
d/linux-2.6'
> 	W: Do not be alarmed at the above message git-svn is just searching =
aggressively for old history.
> 	This may take a while on large repositories
> 	Found possible branch point: svn://svn.debian.org/kernel/dists/sid/k=
ernel/linux-2.6 =3D> svn://svn.debian.org/kernel/dists/sid/linux-2.6, 4=
094
> 	Initializing parent: git-svn@4094
> 	Found branch parent: (git-svn@4731) e71da640593b63647fb23f915acee03f=
02fbaa98
> 	Following parent with do_switch
> 	Invalid filesystem path syntax: Cannot replace a directory from with=
in at /usr/lib/git-core/git-svn line 4388

I have run into a similar problem, both with Git 1.7.0 as well as with
Git via Git.

Has anybody been able to work around this?
Is anybody working on a fix?

Thanks,



Sebastian
