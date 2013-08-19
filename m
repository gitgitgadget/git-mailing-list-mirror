From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Mon, 19 Aug 2013 23:36:55 +0200
Message-ID: <52128FF7.1040909@googlemail.com>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE36B1CAE8970407D565A4749"
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: "Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 23:36:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBX89-00029G-De
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 23:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab3HSVgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 17:36:49 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:63104 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab3HSVgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 17:36:48 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so2540302eak.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=+WbT8aVC8qzXqQ87WvHWuLKpJlVJBvx6A6l7NeU88Os=;
        b=XmDovZjIBpPi0UKluEL8+jSV+OXecyGMnaKeGLwWNywBPNkmCWHHMMHVsdeKs6iIp5
         3Ov+LRgSRXATa1zrVigpgW9Htbxk1BsMsG8wyH4wN7OzOlSAQxkvf4g3BQan9QU0j5L0
         o8G4rJCfMHgtprqQ0X2AclwozZGYURRfE9tFo6UoNl0HiQ3BhjXjIdq+0vx4923P8902
         W/Ubqacoq9mWGoD4Ar2+hR7L0Il+Lsu8oXJwtbPhDf3VghCd49FMbgz/oxvilK0UZpYr
         zpkRTCPyDjaMD2qBJOco2gslcwwNr39+YfsH5+8xxBSr1Atz2HDUO452HYHDuFPKsaHK
         aTfw==
X-Received: by 10.14.219.198 with SMTP id m46mr25582787eep.41.1376948206830;
        Mon, 19 Aug 2013 14:36:46 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id l47sm20122903eex.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 14:36:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232571>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE36B1CAE8970407D565A4749
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/19/2013 07:09 PM, Koch, Rick (Subcontractor) wrote:
> I'm directing to this e-mail, as it seems to be the approved forum for =
posting Git bugs. We ran CPPCheck against Git v.1.8.3.4 and found 24 high=
 risk bugs.  Please see the attachment xlsx.=20
>=20
> Is there a method to post to the Git community to allow the community t=
o review and debunk as faults positive or develop patches to fix lists co=
de files?
>=20

Hi,

if you're using cppcheck as found at https://github.com/danmar/cppcheck=20
or http://sourceforge.net/apps/trac/cppcheck/ you really need to review=20
the results, as there are many false positives.

I used that tool for my contributions so far (bug fixes as reported by cp=
pcheck).
However you *really* need to manually review any message cppcheck generat=
es.
This is because git is using a C, asm-like coding style for many routines=
,
whereas that cppcheck is rather optimized to find typical C++ errors.
And the styles vary wildy! (cppcheck tries to become no false positives, =

but it's hard I guess)

I am running that cppcheck tool on git regulary (cppcheck master branch o=
n
git master branch), and review for real findings, you're welcome to do so=

as well. :)=20

There are other static code analyzers, which have slightly different=20
goals, such as http://css.csail.mit.edu/stack/ which has an incredibly=20
low false positive rate (I found none as of now).
However I think having different tools is a great thing, but you'd need
to know your tools. ;)

Stefan


--------------enigE36B1CAE8970407D565A4749
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSEo/3AAoJEJQCPTzLflhqr0sQALqxcJ3WXscqIpkTQoqYcAP/
SCk488G2LLit/AaxM9kFvremzr7A8SaYy6MVXi+KfDBem0vW+aXoZSO8ZeQ2eB/w
MFPEqdHXR6Xi1aziNkb/bdbg9kjPyv0TFNJZnQExIn3FeqxcSvuqDPfcq/JdeKJB
+smziYuk1lL8qv04luzblcON4cfc9+O5ZvUO+TOFjhcG2bophCIcakYtJ+EET+RN
4+ZvoOEtRSkTekDnHAHscTW1gfnbtA4jMt18p3/IEhErv425eyhIZqvthAUKX7VY
qe8O8ZlXt4wwSICvUSOAUngwmpXZcNOImB+2kewqoPyfP07OEfFpv3+XM9pcf6hH
Ml4QS9/YYw6Av7jfdji9pTrTIahnRrychParZAa+L6/1gUgpQTmT7StibWnNHFKq
lX+74hBT81Cs42ZwuQpDMM/zQCc/8+WuBQHZFtubcOmG1IaDqIftd0uKWr7W9dW1
XXbl8PZQY3wm5Ximei8eawLSt3AcJ6IUYNMZXCZvCAzLzTgJG9Jg7GiQIvESPrGL
z2IfDiAo/D1R+RA63IgWVFzKFTkv4AWdYLcablctE7BcyM5QLZuz5NpsnVfCRCb6
PWd40fj48vb92tlMcD8YD7myPXWtMootkd/oFQtWXdIX7ltgaudSLpB3GjL5w7PU
tvYGKcuVMwrSxxFX6UsJ
=p3ZM
-----END PGP SIGNATURE-----

--------------enigE36B1CAE8970407D565A4749--
