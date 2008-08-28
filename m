From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] git-commit: '--no-status' Allow suppression of status
 summary in commit msg
Date: Thu, 28 Aug 2008 15:24:07 -0400
Message-ID: <48B6FB57.5030406@griep.us>
References: <1219949215-10189-1-git-send-email-marcus@griep.us> <20080828191302.GA2704@blimp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig89C4DD64C66FF8FF790B4108"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYn7Z-0004fi-S1
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbYH1TYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYH1TYZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:24:25 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:49461 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYH1TYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:24:24 -0400
Received: by yx-out-2324.google.com with SMTP id 8so290061yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=A7MVEasnjDkdcTONaUj8xrv/5fKFA7Xkk1Y14Tw9nh8=;
        b=GLSSwkLakr9lN2RL/RCt18ynR8Tddzb72SVleRgXUhvPq61kMmBWvKQNRjY2dlHQJc
         Oasf6cCYvua1+Ulvx/5dC3wTQQpmy+gXIk7z9qhl7LI/OUqe2QKE+PhxowBAe1anIbUm
         d4VNwN7whAM/feYpShZHWI2p8TY6WcZXqT8L4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender;
        b=STcZuRylb67JuJiMWqbCkKJjgKuFFYZDdu86l6HyIn27gsnW2F62c1ufz+/PGlb1zr
         ZnM0XsXWEOpWL+dim8Qq6A2SGRDAwNL5el1e+7XyAnYRATlWcVMN4Lhi55VeFhujHpHG
         kSpzzDIX9lYwnl28SuVW3PLUp/ni+08HRCz/Y=
Received: by 10.142.77.11 with SMTP id z11mr606360wfa.337.1219951462785;
        Thu, 28 Aug 2008 12:24:22 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 30sm2585474wfd.1.2008.08.28.12.24.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 12:24:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080828191302.GA2704@blimp.local>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94119>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig89C4DD64C66FF8FF790B4108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Using --untracked-files=3Dno cuts the time to display the editor from dow=
n to 12 seconds,
so that is perfectly fine.  The patch can be ignored.  However, would con=
fig option to
change the default --untracked-files value be entertained?  Allowing:

[commit]
	untrackedfiles=3Dno

which defaults (as stated in the documentation for --untracked-files) to =
all?

Alex Riesen wrote:
> Marcus Griep, Thu, Aug 28, 2008 20:46:55 +0200:
>> Currently, using any editor to edit a commit message for 'git commit'
>> kicks of a 'git status' which is then included as comments to give
>> the commit author some context. However, in some situations, such as
>> having a working tree of many hundred thousand files or on an ineffici=
ent
>> filesystem, a 'git status' can take a long time to process before
>> displaying the commit for editing.
>>
>> This patch provides an option to disable the status summary, documents=
 it
>> and provides test cases for its operation.
>=20
> There is prior art:
>=20
>     http://thread.gmane.org/gmane.comp.version-control.git/66183/focus=3D=
66251
>=20
> and resolution (in the thread, somewhat unclear).
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig89C4DD64C66FF8FF790B4108
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSLb7YwPFruyc22R/AQI5KA/+MWGtaOlaI9so5DKpfa3Yn+jR1GfQDXX8
2Ju7sY7DmrDkHYSNsLPQBJh6f/HRE/kbEkBUbKjJl677WuSJFD8T6mV+YyJB9g+t
C1EUj75MzAQL2Ncj6CB7vVVBN/XLJvyMKhLfbmCJdFN3V32RfWFjO3jmEnXjb1AQ
vEF8NjHfocgASe6oICeCLJLsZzaNfTN8wg6ZL4CZThc6guDrQaDmR/4TCwyOKCoF
5GUiXLwn4hv84f3OSnw4nxpIxuSYaxybeb5a2BgVp+aIpnIza3yt6f5dSyiNm+Xm
0zyefDitbguYAiKRmsiMOQA8Yh2vu42i6O9IYu2RrYSkUplgHj3fZKxMZBXyBdsl
XpJsY9Khje3qW4dsTkiQhu+4gDu9wViinU+HhHXLxwlKJHfTh0e8amVs6Xq7g2p7
YVF7PKamRkapEekroWxGzx8Mk1OrpaxkdGZdUID1sGJIz8Xx0/twbLlFx1BtCn2y
PgxhkqSxbbStJuf1wS1BQsWzutBumE19mh2T35OmVSmi8xj/zj9ZBixeHZmOkDZh
PazNJK7FBQnFYkY1tol3R0f8ECXSwaN0gMbDF5wniSCFw+sNmzetijjzmoAJYfOh
/xylumuXc82oD805bchXx7EfwB1B/d+hB0uc81/w8Bx4WEF1WC36xyHTk2vKiAUd
/b1uL1fEwjs=
=FBQ+
-----END PGP SIGNATURE-----

--------------enig89C4DD64C66FF8FF790B4108--
