From: Steven Huang <steven@accsc.im>
Subject: [Feature REQ]Add CURLOPT_SSL_CIPHER_LIST to git for allowing custom
 cipher usages
Date: Mon, 6 Apr 2015 09:27:53 -0300
Message-ID: <20150406122753.GA29626@desktop.luxing.im>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 14:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf6A4-0000SU-5l
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 14:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbbDFM15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 08:27:57 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34886 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbbDFM15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 08:27:57 -0400
Received: by ierf6 with SMTP id f6so19474670ier.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 05:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=lWzd5mAwrvV2BSOGPVjvvdBUmFlvO1y9oZKFEbWM16c=;
        b=AfbE20TmIW/FcFoniZ69y8CFbmAxLvh62xxiBSvBmvRn6h2qcO6wgOJSN8B7bRI6lQ
         3bCXVQ1tgi6CaAs9Q/kpDBELExtG3qtfJ2em1mOyw5YgqAuvmGYfCbFe2CRyoVdSAxP2
         SvoP82b5YGKG2JPE4TbIui0WIweD9nsyKY6Iv65S5Ytm8VH+AVSCTp/NG9TjWS5vh8tZ
         Ky/U/P154CkhntNb+Jm9JN4s61KvYGFKYZni5HpepU4QzkEcQoEPPXPeQAYtwK+3JKrx
         Zo6uNcaM8PovJWhUf5OJbijqwqc3ORZXBWgID9DvkpzLN1yJgk5fUGxzEVwDhm4wOb9Q
         s74Q==
X-Gm-Message-State: ALoCoQna0hC207OUmog/SF8LU8BL4CAY+povQ4To0QuWShyJpeuKwAMV1dE9QYSPwLLX75Os9sWO
X-Received: by 10.107.128.149 with SMTP id k21mr21649947ioi.7.1428323276170;
        Mon, 06 Apr 2015 05:27:56 -0700 (PDT)
Received: from desktop.luxing.im (blk-212-99-142.eastlink.ca. [173.212.99.142])
        by mx.google.com with ESMTPSA id g187sm2645015ioe.30.2015.04.06.05.27.55
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 05:27:55 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266844>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

    We know git uses cURL to grab https repositories from the Internet. Now=
adays
    the SSL-enabled git repos are getting more and more, especially self-ho=
sted
    ones.

    Some of the websites including those enabled by CloudFlare, however, do=
es
    not support common encryption ciphers provided by cURL. For example,
    TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 will not be support by default =
in
    both cURL or git, and it is not a common cipher, Debian/RHEL does not e=
ven
    support it by default (but Fedora does, maybe others, didn't test).

    Is it possible to add this feature (this opt is set by calling by curl
    --cipher cipher_name) to git, allowing custom cipher usage?

    Thank you very much.

--=20
Luxing Huang

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVInvJAAoJEEcuGJaVOILnwPIP/04KJ5ISun9wgnTu50XmYmX1
HYt4Ozu7Sm1Xnj3uSQ8sYPdbNYFEYJD4adiafKzmnabUUSTCzg0zH/x0qGW9OERO
VYgsatUorlwSTk6nUWDI8X2ulNeN2ZBxX6iJBIPGps60NCZWuaHOO9p7g8QXO3Sd
Ik4GuGBvlFg0Uc9deF2P4Y4big4jbnWsUZ3TYHeplr3jX3QTortC0qaALz0OKrtt
bCqSMzgSCNNd+oAxFP7VS9L15NN3OJatcyX+kuErhLk0bSd8pB+yHv8CeGXs9e+F
5aIWuTsTxUdZDuCf0ZRRwOhpVLx031eziJTvzW5hFI6WfJFCMQBlY2D/mUWfVpx3
Tq+y6CCbsChGt9uz+VlteZwUip5KZzeTjcaZWq2fNdZfdheDJlWbYCuF7wU/sRSA
lZ+UgmIKckcRLm5iBUlTU94ob6ZOPztf3SMdDlVlHNU4YrWHGXbBD3ve3o3npZFa
Oqf1QOt3mTIAlfCq6OVqCJx8fFucVuElTmfyGFK8oYJOclrDznoqXcMzHfmftIfW
CtbOsRaut2gJxwFVS4atuzHB+1SnesQdSHxxRYKoNZPNQY09I3Z1HAVWRhWsM0gb
GNBIJ0B3zftUYoNdjQyFeksOl9SyD6hTmbW9BYtDGaDOp+AYckMsDMAl4ZFzGmHu
UpZL0mEqMjGkdrWHaOBE
=FjDJ
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
