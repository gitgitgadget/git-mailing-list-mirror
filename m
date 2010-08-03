From: Michael Dippery <mdippery@gmail.com>
Subject: git instaweb + webrick does not work
Date: Tue, 3 Aug 2010 17:37:39 -0400
Message-ID: <1272BF62-A0C8-4940-9472-E46C05BF1723@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--230934690"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 23:37:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgPBI-0005QN-K8
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 23:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938Ab0HCVho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 17:37:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51469 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997Ab0HCVhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 17:37:43 -0400
Received: by vws3 with SMTP id 3so3474077vws.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-pgp-agent:x-mailer;
        bh=R4MYtQcaN7f6mcmXnryx+Z9qdoQS+OkcRJQx1g7fc2A=;
        b=i8jWQrKallokiVHQFvX8JjCNYYU3f7i5ol0nXfs+eq0hduhhN3NUAI+XRZk8FZfUS1
         358E1nosg3SoJhIaeaF6wu8lsfa2rZdq9bbhwgamt4+GXKf9mMWFRBqib+5iFzirN4JM
         FTXogZQNsqCCYkgxnrjJO2i+kbxTX7ZjiEWT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-pgp-agent:x-mailer;
        b=lxnmGjtn6O3yyU7K/teSHZ+7ogPd/ywgP0hH5HgBdi33cSHqeIftrX2xSwPekLlGTz
         23Rf0cmjX+d5ZQerjLnmqCCTHy49DVk/zcr2LQP/af41dJvCYPqC50ZPfT5QNVyndxhk
         TTkNwrsl87UhQ3AJIUbtNT8ZmdOn4anJJKMBw=
Received: by 10.220.59.202 with SMTP id m10mr5588982vch.199.1280871462101;
        Tue, 03 Aug 2010 14:37:42 -0700 (PDT)
Received: from [192.168.0.10] (h-69-3-197-90.nycmny83.static.covad.net [69.3.197.90])
        by mx.google.com with ESMTPS id v11sm7128904vbb.3.2010.08.03.14.37.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 14:37:41 -0700 (PDT)
X-Pgp-Agent: GPGMail 1.2.3
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152542>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--230934690
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii

I'm trying to use `git instaweb` with Ruby's webrick (which I have =
installed) on Mac OS X, but every time I fire up it up via `git instaweb =
--httpd=3Dwebrick`, I get the following error:

"webrick not found. Install webrick or use --httpd to specify another =
httpd daemon."

I _do_ have webrick. Asking around a bit, I was told the the problem may =
have been introduced in commit be5347b. Is this so? If not, any other =
ideas on what may be causing the problem?

I'm using Git v1.7.2.1 on Mac OS X 10.6.


Thanks,


----
Michael Dippery
mdippery@gmail.com | www.monkey-robot.com


--Apple-Mail-5--230934690
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (Darwin)

iEYEARECAAYFAkxYjCMACgkQEH+OdyrkzmlRSwCgii1vNQNB+ZF8BixR/QNcmmfC
154AoNh0lw8As84zUv3kyZsPaFVHhsie
=he9N
-----END PGP SIGNATURE-----

--Apple-Mail-5--230934690--
