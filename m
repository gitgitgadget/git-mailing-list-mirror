From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sun, 17 Apr 2005 00:32:06 +0200
Message-ID: <20050416223206.GU9461@lug-owl.de>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:28:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvmA-0007QK-Vy
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVDPWcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 16 Apr 2005 18:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVDPWcJ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:32:09 -0400
Received: from lug-owl.de ([195.71.106.12]:57283 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261161AbVDPWcH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:32:07 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 52694190273; Sun, 17 Apr 2005 00:32:06 +0200 (CEST)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 18:03:51 -0400, Daniel Barkalow <barkalow@iabervon.o=
rg>
wrote in message <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org=
>:
> --- /dev/null  (tree:ed4f6e454b40650b904ab72048b2f93a068dccc3)
> +++ a65375b46154c90e7499b7e76998d430cd9cd29d/http-get.c  (mode:100644=
 sha1:6a36cfa079519a7a3ad5b1618be8711c5127b531)

> +	local =3D open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);

0666 is a bit too lazy. I'd suggest 0664 or 0644.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481         =
    _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Kri=
eg  _ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im=
 Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | T=
CPA));
