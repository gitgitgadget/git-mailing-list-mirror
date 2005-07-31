From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails
 from git-format-patch-script
Date: Sun, 31 Jul 2005 14:50:55 +0400
Message-ID: <20050731145055.2b5e6161.vsu@altlinux.ru>
References: <11227978451100@foobar.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__31_Jul_2005_14_50_55_+0400_V7pdTeP_7=5OOXff"
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 12:51:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzBPy-0001aF-5O
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 12:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVGaKvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 06:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVGaKvg
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 06:51:36 -0400
Received: from mail.murom.net ([213.177.124.17]:3487 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261672AbVGaKvc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 06:51:32 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1DzBPa-0008WV-ID; Sun, 31 Jul 2005 14:51:18 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 814C6E510A9; Sun, 31 Jul 2005 14:50:58 +0400 (MSD)
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11227978451100@foobar.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Signature=_Sun__31_Jul_2005_14_50_55_+0400_V7pdTeP_7=5OOXff
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 31 Jul 2005 04:17:25 -0400 Ryan Anderson wrote:

> This is based off of GregKH's script, send-lots-of-email.pl, and
> strives to do all the nice things a good subsystem maintainer does
> when forwarding a patch or 50 upstream:
> 
> 	All the prior handlers of the patch, as determined by the
> 	Signed-off-by: lines, and/or the author of the commit, are cc:ed
> 	on the email.

> 	All emails are sent as a reply to the previous email, making it
> 	easy to skip a collection of emails that are uninteresting.

Actually, this is the part of GregKH's script which I hate ;)

50 patches sent this way produce an enormous email thread; if someone
then tries to comment on a 40th patch, this part of the thread ends up
far behind the right edge of the message list window in almost any mail
client (and if someone comments on the first patch, the comments are far
from that patch).

Sending a [PATCH 0/N] message with the overall description of the
patchset and then all patches as replies to that message looks much
better in that respect.  However, missing messages in this form are less
obvious.

--Signature=_Sun__31_Jul_2005_14_50_55_+0400_V7pdTeP_7=5OOXff
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC7K0SW82GfkQfsqIRAn57AKCTXTitlV2H2tTWBoFY0uhA8SDFGgCgkLIh
m4QXu7AVkwmrXyrGO5wr8wc=
=XEv+
-----END PGP SIGNATURE-----

--Signature=_Sun__31_Jul_2005_14_50_55_+0400_V7pdTeP_7=5OOXff--
