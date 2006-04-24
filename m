From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: weird pull behavior as of late
Date: Mon, 24 Apr 2006 13:29:22 +0400
Message-ID: <20060424132922.6e634188.vsu@altlinux.ru>
References: <20060423.175953.52710961.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_Apr_2006_13_29_22_+0400_anQ9ln.HdBB7HFOV"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 11:29:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXxNu-0005Gc-2q
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 11:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDXJ3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 05:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDXJ3b
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 05:29:31 -0400
Received: from mivlgu.ru ([81.18.140.87]:42456 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S932095AbWDXJ3a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 05:29:30 -0400
Received: from master.mivlgu.local (master.mivlgu.local [192.168.1.230])
	by mail.mivlgu.ru (Postfix) with SMTP
	id 4C6FC8053; Mon, 24 Apr 2006 13:29:25 +0400 (MSD)
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060423.175953.52710961.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19093>

--Signature=_Mon__24_Apr_2006_13_29_22_+0400_anQ9ln.HdBB7HFOV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 23 Apr 2006 17:59:53 -0700 (PDT) David S. Miller wrote:

> Fast forward
>  MAINTAINERS |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> I got 446 objects and this amounted to just a 4 line change to the
> MAINTAINERS file? :-)

I got the same problem recently and tracked it down to a stale diff.o
object file inside libgit.a - apparently "ar rcs" does not recreate the
archive from scratch.  After "make clean" the problem has vanished.

--Signature=_Mon__24_Apr_2006_13_29_22_+0400_anQ9ln.HdBB7HFOV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFETJp1W82GfkQfsqIRApEjAJ4u17SqIVeIWErsh7K5HAPuTRi00gCeM/m+
lKGSg/GCVvjXt3OU0LpCubA=
=Y1Qo
-----END PGP SIGNATURE-----

--Signature=_Mon__24_Apr_2006_13_29_22_+0400_anQ9ln.HdBB7HFOV--
