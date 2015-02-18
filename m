From: Fairuzan Roslan <fairuzan.roslan@gmail.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 21:47:17 +0800
Message-ID: <E28114B6-86FA-4F4A-9D5F-BFC03B9D79B8@gmail.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr> <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> <vpqiof14qu8.fsf@anie.imag.fr> <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com> <vpqr3tozzs5.fsf@anie.imag.fr> <CA0F915F-74B1-4292-AFB8-D1A4C76C0137@gmail.com> <54E3804D.6020301@web.de> <vpq61azab52.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_88A9CDF8-4884-4B42-895B-066D9C313159"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:47:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO4yU-00008U-OH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 14:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbbBRNrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 08:47:25 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39105 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbBRNrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 08:47:23 -0500
Received: by pablf10 with SMTP id lf10so1329533pab.6
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=rcjhZ9sym1EkBqleUOawaFy4CqJIyfvVhg7B/V88s2U=;
        b=WSlciGmLWKsfMwoEduSvg7eOfktgSNo4scokipAMqFrH+XPng1Z466cSzZQsHgSCAP
         nMN/qEWdZMoB63L/py2+Lv7AO3rHpD2KCh0YVRFB3yF3p+9hyA5Vlqbku9RxfirIhxSZ
         bfUSbLxtmQcZHtULlh+uV38FOFxbG5/Xfk4OVBgwtxK7CCEUvZQVsrwfvtwpIW2UVsRy
         vLXZ2iMGX99PZ+lNzM+UyFL1sJvfDOmYfTlaTD9cSP3x7rZ+7FPvLm4dVbUY2JvDaDUv
         v6hoXAXzbI7EfuvzxFf3Yl9HQK1vACkMPTvIOxZr/zWxWjZm/XMBkhk4sTzS4CoKgYnV
         NyVA==
X-Received: by 10.68.239.102 with SMTP id vr6mr59096382pbc.35.1424267243011;
        Wed, 18 Feb 2015 05:47:23 -0800 (PST)
Received: from [192.168.88.200] (brk-24-241.tm.net.my. [202.188.24.241])
        by mx.google.com with ESMTPSA id a10sm20807286pdl.61.2015.02.18.05.47.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Feb 2015 05:47:21 -0800 (PST)
X-Pgp-Agent: GPGMail 2.5b5
In-Reply-To: <vpq61azab52.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264016>


--Apple-Mail=_88A9CDF8-4884-4B42-895B-066D9C313159
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 18, 2015, at 4:15 PM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>=20
> And now I'm starting to wonder whether other people do have the same
> issue. Sure, googling "Git AFP" shows a lot of people having problems
> with Git and AFP, but are they really the same problem?
>=20
> I googled 'git afp "unable to unlink"', and all results except one =
point
> to this thread:
>=20
> =
https://www.google.com/search?q=3Dgit+afp+%22warning%3A+unable+to+unlink%2=
2
>=20
> The only one which doesn't actually does not mention afp.
>=20
> Fairuzan: are you sure you're not the only one having the issue? Can =
you
> give more info on your system (OS version client and server side, =
=E2=80=A6)?

No I don=E2=80=99t think I=E2=80=99m the only one with the permission =
issue here but I=E2=80=99m sure many people prefer using smb over afp


Client: OS X 10.9 - 10.10.2
git client: git version 1.9.3 (Apple Git-50) and git version 2.2.1

Server : Linux 3.2.40 (Synology DSM 5.1)
AFP : Netatalk afpd 3.1.1

=46rom what I have tested whenever a file=E2=80=99s permission set to =
read-only on the AFP shares a user immutable flag were set as well hence =
why any action such as unlink or rename failed.

$ ls -laO
total 0
drwxr-xr-x  1 user  staff  - 264 Feb 18 21:31 .
drwx------  1 user  staff  - 264 Feb 18 21:31 ..
-rw-r--r--  1 user  staff  -   0 Feb 18 21:31 testfile
$ chmod 0444 testfile; ls -laO
total 0
drwxr-xr-x  1 user  staff  -    264 Feb 18 21:31 .
drwx------  1 user  staff  -    264 Feb 18 21:32 ..
-r--r--r--  1 user  staff  uchg   0 Feb 18 21:31 testfile

I believe this to stop a read-only file to be modified by the user in  =
Netatalk AFPD.

$ chmod 0644 testfile; ls -laO
total 0
drwxr-xr-x  1 user  staff  - 264 Feb 18 21:32 .
drwx------  1 user  staff  - 264 Feb 18 21:43 ..
-rw-r--r--  1 user  staff  -   0 Feb 18 21:31 testfile

Changing the permission to read-write will remove the user immutable =
flag.

Regards,
Fairuzan


--Apple-Mail=_88A9CDF8-4884-4B42-895B-066D9C313159
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJU5JflAAoJEKrU1IvC77KVkccH/0dfCFzCzCbhsZ9bk1M1fho9
9e4EPlaDp/size4BoksjTrnKnhrn3S+F9bLAjD9WMHawhaD4Poe3VBNdwcHQz8CX
Rpp4A2kwY5ZLQ7HXPvoSD0eCWRuK8Yt06rFBO0N3/4v7WInn6wOAiJmWS2+DpaYx
day12INFhKTI+UR26gXS6sRbyonxeDtAzf1WnGIfIipYrMYNV82Gq8NEYcDiJn5B
BaX3OWFaGlmWQ8pWEwBQWpRfstgW57cYLB3p5PYs+/H0EuJxEDbgNfY2+eTL/t5X
/Vo3cCqHVBD5NoHTvQ1ygdSjbdHiTqbmfOxThLN15D1kJgZzj4hmKGTKhtUCjoo=
=vVzP
-----END PGP SIGNATURE-----

--Apple-Mail=_88A9CDF8-4884-4B42-895B-066D9C313159--
