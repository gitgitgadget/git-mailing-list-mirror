From: Giedrius Slavinskas <giedrius.slavinskas@gmail.com>
Subject: git fast-import crashes importing commits with more than one author
Date: Sat, 01 May 2010 18:43:56 +0300
Message-ID: <1272728636.27562.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-IFec5MjjbPTMf3IO9LMz"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 17:43:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Eqj-00016Q-Ly
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 17:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab0EAPnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 11:43:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:57010 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab0EAPnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 11:43:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so300946fgg.1
        for <git@vger.kernel.org>; Sat, 01 May 2010 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer;
        bh=JqQWD47ODCe8XsjaMM5HExH2SG0vgy0SvG5A/yPSFR8=;
        b=JSil4shMvRL0r86yE5Nz+CB5ZEF5Pgpc6hV2Q6vZneSEkeAkFeSK6LJhkuS/gaR1X+
         rQm4EWpajBf6LM3boy+HZ5xqLOODQKpAY2gZJLTp6Lt96RekP8elUvDqUUcdLRUJo6eg
         YfzpajiMhun/rcH60e/s4Ex2+CmxBRHQSINQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer;
        b=C7RC1Brpzq9nwJ/9UTa9TIl/hDZZhyvyNPLFG9u6tQ0/KIyUHnTiGcYTyQr1AKI6cY
         wkYGax/6zAxHN7kUuKnPEeyZGrUhBqbWPeCgU3v5ibhm0G+4y5Lbc8h5qmns/TD07v86
         BfiRPojnEEYLsIVAJq3/TA466rWoTqLRb640o=
Received: by 10.87.74.17 with SMTP id b17mr6413916fgl.59.1272728593672;
        Sat, 01 May 2010 08:43:13 -0700 (PDT)
Received: from [10.3.5.114] (gw-world-s1.bt.ktu.lt [83.171.11.34])
        by mx.google.com with ESMTPS id 21sm5198171fkx.40.2010.05.01.08.43.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 08:43:13 -0700 (PDT)
X-Mailer: Evolution 2.30.1.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146086>


--=-IFec5MjjbPTMf3IO9LMz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

git fast-import does not support commits with more than one author. I
try to import bzr repository and it crashes.

Here is info how to make bzr commit that couldn't be imported to git
http://doc.bazaar.canonical.com/latest/en/user-guide/recording_changes.html=
#giving-credit-for-a-change



--=-IFec5MjjbPTMf3IO9LMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJL3Ew2AAoJEGo4VRrTandCzMoP/jQMzOpwHs0W2kFP9IItJXjD
7e75MLVfwejcxLryjQYTosHmTYY8psaRHGfZ5VJubBMD0SLYjRn45AzPYlirSsL8
Zcr/h497/jcJWJnNryaKxVNu3oh9ZPRB/8rRwLkJqJeBrnEjzBv93wfyC4ByXKp9
nzA7PXU/pvoXVqmTLr7CBLokZBYO7PqHIjAWCPq8MOIIFyIc/IV8SkUggO/lIWI2
w5j+hfs0Te8r8CXkS1VE2wJ8fOe4JI8u2dczcN4/VjGoNcFCb2W1znsQLxMgrPq9
oPUyep1AkwUlsTia4Z38QFVidP8hJFRFFR0tB0vGI93NLBNbvNQWACXOtBxfqhi3
WMAoTFzcQ1ttLuIcz48qs58PShWjgGVCajIToRc1yH7IkV71USeEHloycqR34nMj
FmoI9NWBg3z6tHoe/3vnCkcPvzEu1L/3sd73qE9v3wg1E2FhfeZ5lB0cpvc6oQUI
CpP8gMLhvTBPrfqrlbLifyohyXcnAQvWsMW8gZw/wPdyW9R7PAUEK8BDqgIe6Lri
vKj+KZgKnqSKNmYROdUH6rUwEsE+cHl5oYz132pukPk66Gd/y6gkvZ5WgT8/A4fS
a1tN0OxisuLbUJ4Qn4vO0HKCDuVA8mKtk4rLZIWEXrwFnXK7ha0d+q3SL0s7KfJi
o1AOFo9W/zCDlMvUctW/
=1czf
-----END PGP SIGNATURE-----

--=-IFec5MjjbPTMf3IO9LMz--
