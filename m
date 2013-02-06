From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH 0/4] Make git-send-email git-credential
Date: Wed, 06 Feb 2013 21:38:56 +0100
Organization: http://mina86.com/
Message-ID: <xa1thalpp47z.fsf@mina86.com>
References: <cover.1360172967.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:39:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BmL-0007BK-O2
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417Ab3BFUjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:39:12 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:64181 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758328Ab3BFUjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:39:07 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so1058509eek.9
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=l9legPPOr1kJ1dSu8rmZgyHJaTcs7akQ32nSA0NFLHs=;
        b=nwKshAW4ziG6M+yRbRY8azkoy40bVhwgoMbjSc3lihxyi3jgNwJukx9LMMjHKLswsF
         GmIWrGoQ3wmOLUuh3f7cj8nYAofzQReW5aMsrvDJGayIsRo0ZpjOp6uzSTx4IlNG5vyn
         1PHWfESi2cAhwulKFUp9pgz7EJjlsGT87GD6yB+Vb/iWUFI8jB+0fJeBqYJwhosZqxeh
         KGySvTw91KjQ+Q83vRYbLBQgZQN1nt18LxuNnlCLkI1lhDfSgrxM4IRMm7B1mFVDRRoA
         cfqAuS1HQWOo5/CeiFw5eT/4JUL++jD8uJ1vERNS68Cmi6lTPdSsxpSsvtCOTMOV3gG4
         /zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=l9legPPOr1kJ1dSu8rmZgyHJaTcs7akQ32nSA0NFLHs=;
        b=D4YAxyCehRdXke3Ziwy5Ss5UoATrEIGHyJj+6RuzErsxsLxzdOadqSAGtDXQVqSrjX
         2CQzSCeF6goo469zikpgRvyJlsrHZNgeHV0OMFDRdNuRZTSPPWca8mgXlHUEzwfd5To+
         QWFGYS+IZYUMO6rhFqAdhZSe2qH7qdOkH3XEOMGk4jHYS9IcE/TIYJoa9I5yXy0MegLi
         hKDKmjFchYpd4eZ+3k58iHrtU0tcXhpybe5JKCNZkKGhml3vGEjzvqQwXxvaIBNrPW9k
         JkZrdTsl5vvVZ6QBuUfrGIkdCYniyR8+qCUzJdU8eX9EtFIV89zxeBKbEDoem6lSuV5S
         iCew==
X-Received: by 10.14.5.12 with SMTP id 12mr43546746eek.36.1360183143677;
        Wed, 06 Feb 2013 12:39:03 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id d3sm38680157eeo.13.2013.02.06.12.39.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 12:39:02 -0800 (PST)
In-Reply-To: <cover.1360172967.git.mina86@mina86.com>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQlI7NHjB9QTtGFaQ7Y0IpTsKwIk+F0Xw+CTTSjNj6HQguwL884a8LuXKx4kmn97LFTLYee0UDT6Ng1qjGAGZkDFVS6bJ0gwpIpKe56e30kLlmCdVW99VzYfLoMANsOn5WZe23lxFN3a24/CnghW9Qy2BgWIbVWnGebSn9xoS45vRiZwAJh1eAOU5XOggjoA4flishlzLC4HkmQ4Ufm1Hrb0jhLQYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215633>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06 2013, Michal Nazarewicz wrote:
> As discussed on the list, adding git-credential interface to Git.pm
> (sort of copied from git-remote-mediawiki) and making git-send-email
> use it.
>
> I see git-remote-mediawiki does not have =E2=80=9Cuse Git=E2=80=9D so I d=
id not touch
> it.  On top of that I'd have no way to tests the changes anyway.
>
> Michal Nazarewicz (4):
>   Git.pm: Allow command_close_bidi_pipe() to be called as method
>   Git.pm: Allow pipes to be closed prior to calling
>     command_close_bidi_pipe
>   Git.pm: Add interface for git credential command.
>   git-send-email: Use git credential to obtain password.
>
>  Documentation/git-send-email.txt |   4 +-
>  git-send-email.perl              |  60 +++++++++++---------
>  perl/Git.pm                      | 116 +++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 149 insertions(+), 31 deletions(-)

On second thought, give me a moment, ;) I've just discovered a bug
preventing git-send-email from mailing a patchset.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJREr9gAAoJECBgQBJQdR/0i/gP/R0OyrQ/acnvb5l9VQ0+3Bmo
TMwkdLDFmjQYPDCR7OYuauI4ZpIDuzYLE/H7H5DcQjTXPoRnOnTgQU6BVZ4QOGPV
Dft+ovDT2WeISAyCAxO0iJmvP+YW5XoA5uL8NqlLSgdJHHSORUPztvnMET0kdvvQ
w+YPz3yCdVcll6GNYTLOyqkozj+vi3imq5scL3KOUJKHtyHAA6ZoqnPvWS4QuE7v
NiQlTh1QiLJUPJ0IUrkbjlyQhfnBzY40C2RPIBCfOpIzOTrq8lguYmoXeefwIp/7
9eA+52EbWOIIfEKHSZ1JWZFKKOHPXs5XOA2+VBWMYjIIFesMqWHO/RbWVWEyme+T
jdI4PF2DPEwnmFKg2NN6T4x5q+57YC8LrUG/umlj8DZHWw95qRzj1vSGgZd9/yoe
64IqlKrqclXrOJREKrCRepUCUhjTQG0e3dI5WvfLOZgAq+CwymrfVSG6pmKbfv5u
UKbSEvtBRtQGltoOu5al7tRVjuX1iDmcQBGPI2neVzspaVy+IT9W7TGJglscNFJR
1By8DIMepwbgaRu6cs7Qr4k0RJrcb9sm9o4uxfX8sAl6BkDv96DOkvpsMXXclAjJ
lTUwCEVZ1Qg3YfhBD7Dru+G9Gp+Gc53ReE53bNjlv1jObMlq/tPKXfxuqbTdreoe
xmm1A7Nu9J+whY10qTAc
=Rtw7
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
