From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [BUG?] fail to svn clone debian's kernel repository
Date: Wed, 10 Jun 2009 18:05:24 +0200
Message-ID: <20090610160524.GA24435@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 18:06:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEQJI-0007So-N3
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 18:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759735AbZFJQFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 12:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758904AbZFJQFX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 12:05:23 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58902 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759639AbZFJQFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 12:05:22 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MEQIm-0007Hs-96
	for git@vger.kernel.org; Wed, 10 Jun 2009 18:05:24 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MEQIm-0006RE-6g
	for git@vger.kernel.org; Wed, 10 Jun 2009 18:05:24 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121285>

Hello,

using git v1.6.3.1 from Debian I fail to successfully run

	git svn clone svn://svn.debian.org/kernel/dists/trunk/linux-2.6

It runs for some time and then ends in:

	...
	r4695 =3D f552d98386b301cbeaa3b5a20f9e9d5d3c9c4886 (git-svn)
		M	debian/arch/alpha/defines
	r4696 =3D 18c0a37de057d24955b66e8f49db0791f6018288 (git-svn)
	Found possible branch point: svn://svn.debian.org/kernel/dists/sid/lin=
ux-2.6 =3D> svn://svn.debian.org/kernel/dists/trunk/linux-2.6, 4731
	Initializing parent: git-svn@4731
	W: Ignoring error from SVN, path probably does not exist: (160013): Fi=
lesystem has no item: File not found: revision 101, path '/dists/sid/li=
nux-2.6'
	W: Do not be alarmed at the above message git-svn is just searching ag=
gressively for old history.
	This may take a while on large repositories
	Found possible branch point: svn://svn.debian.org/kernel/dists/sid/ker=
nel/linux-2.6 =3D> svn://svn.debian.org/kernel/dists/sid/linux-2.6, 409=
4
	Initializing parent: git-svn@4094
	Found branch parent: (git-svn@4731) e71da640593b63647fb23f915acee03f02=
fbaa98
	Following parent with do_switch
	Invalid filesystem path syntax: Cannot replace a directory from within=
 at /usr/lib/git-core/git-svn line 4388

Is someone wants to take a look, the repo is browsable at

	http://svn.debian.org/wsvn/kernel/dists/trunk/#_dists_trunk_

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
