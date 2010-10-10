From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Useful tracking branches and auto merging
Date: Sun, 10 Oct 2010 19:45:21 +0200
Message-ID: <20101010174521.GC15495@localhost>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
 <20101004204625.GH6466@burratino>
 <AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
 <20101010171505.GA15495@localhost>
 <AANLkTimFYExqr_OcYMJ0kTv5K-wtu3pzsAu=rhq+19W-@mail.gmail.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 19:45:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4zxZ-0008HD-Oa
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 19:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab0JJRpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 13:45:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47816 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab0JJRpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 13:45:12 -0400
Received: by fxm4 with SMTP id 4so129045fxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=AXVq6kl8YQI6Qkky2uW8HTwsh4eAn6+utcodNfUxGXs=;
        b=fM3zywx8FPfyLwO6wV7igKQoinnjf74vWV1kbegKE8JswOM9uGFjbvyX1hBfOSHLBH
         oHrIESLHk7TNScejfL+J0doAVR1+sNNzw3XpA4bIKr2w/h+xz+o2GOrYAQvgRfOc5bav
         An6JsS4vzhn/BLs2XlgNk9pHMy6N2tn8VCDjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=I360TBskYx2tM38pQToBqwUoI9U+4VcOZhE2GqqGwD9ApZ2zXIjq/YfzQfw2/MosKF
         pSFbLlgYNBAqkRoa4VK+3dn9mN9pslwFD9eT2i8JqL0uOgzkLGHB//iP8NeAsWeRpZ7x
         fWLsAcZP9JrvGMDKuxgy+F+9Ddw4dRqe9L90g=
Received: by 10.223.119.82 with SMTP id y18mr1320131faq.65.1286732711224;
        Sun, 10 Oct 2010 10:45:11 -0700 (PDT)
Received: from darc.lan (p549A35A6.dip.t-dialin.net [84.154.53.166])
        by mx.google.com with ESMTPS id m8sm2542664faj.35.2010.10.10.10.45.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 10:45:10 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4zxZ-00049Y-9w; Sun, 10 Oct 2010 19:45:21 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTimFYExqr_OcYMJ0kTv5K-wtu3pzsAu=rhq+19W-@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158681>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 10, 2010 at 08:30:22PM +0300, Felipe Contreras wrote:
>=20
> There's no magic involved, it's just what you would expect, what else
> should 'git merge' (without arguments) do?

I would expect it to do nothing, or just output a usage. The
proposed behavior is also unexpected because git-pull already does
(almost) the same thing.

Clemens

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMsfuxAAoJELKdZexG8uqMHHIH+wQXS3cnMMhLDv5QnGEJFqmM
Cb8O+T7AgvhPJRn0dNXmEYjRrZxnJFTzsPwEwu5tLvF+4onoWTIYMr/6YvG7ato/
QmXVLsPTGvjdMrMGUPv48P2QT0VkhomKis0VpF/eMkBRToYXTwbavoKwnUylr0jQ
leYit8uJmQS+nA/gbt4MYO+3l+RuNAqXbkSaKBLfDShh6zuYuKFpE+LmHZonpp1C
L9F08w6nOADpIYaYBjRstvtwzq6aJXYT07/HsX5kBJtpedbRwqgWNoLspY2o8K3O
/FZjaeCXD/9ynN8RZO0vLPBA1fsKD4KkUzZpDQOUDuWMVhO3uRtBlJf4VZpN+J4=
=Hm2L
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
