From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv3 0/5] Add git-credential support to git-send-email
Date: Mon, 11 Feb 2013 18:18:04 +0100
Organization: http://mina86.com/
Message-ID: <xa1tk3qeg46r.fsf@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com> <20130211165136.GC16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4x1Z-0002tC-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136Ab3BKRSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:18:14 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:41971 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838Ab3BKRSN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:18:13 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so2756111eaa.39
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=pNDMEqqZZVuYqCCixdiHBkY73KabaMSv5SZE4+pmvWw=;
        b=AhqyzjI6vsVl9PVmniV5jh+xrFqIY0QBC99CI9cC17HNRw8bBD8djTDDr0cYP/RauU
         byDAXKPcaqQPnywo1sVlXhKgmIAyA4AYoWmKtV4Z31KxGuZhuT5tCiiMO8Dt3Q1OngVz
         2/XXG1TpfG0rQ+G/9WIiKlVUwWCYK3SK/+Tg8F1FUGrj1m9m3xoPlYSvF5amdhhAVfwa
         Z3hM2ZEbNkViSSWzkXQufLHNkyYFEL3FOsQSEv4Pz81aKIMkhZcsTqJRnO4iluKg+qKV
         uOOOOKkacjwH0zW1pMM2PI7VzgStuKj/KM28AUqNO3I+JE0DEnQZ1PDwFm2AbympKwip
         qcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=pNDMEqqZZVuYqCCixdiHBkY73KabaMSv5SZE4+pmvWw=;
        b=nbeZ0bt1NuL7WMb0Fdgw6zcD9HuVaaW6pQh7jDvDIgyprzlfnJpHb84n5wzp9tUQ2v
         7n4chK4kh5jueQnRdOZ85aIf0XqamNtdmEZyOTKIqcEvVgoTcDVBt5hZYU5Zhh4ahlXQ
         aPEKjguXL29A9Xg55gVwBxP8c5GM7Oadut0T1oO9ovki0uxuSptDaH3MXYiUdIBapEar
         2YM0+GSfSgFK0fNN5fEqR+u9OWHXjev0GNu8UmCM6y1j6RXDraS8WNAo9xWqRJmb2gBJ
         lDuVBTy46VvHVpJzu9xDqG52vv9J/zuenchCvfIFTMnuPxb1EAza1BNKcWOSaN9Ot3L5
         vyng==
X-Received: by 10.14.175.70 with SMTP id y46mr51896578eel.6.1360603091365;
        Mon, 11 Feb 2013 09:18:11 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id 3sm63600133eej.6.2013.02.11.09.18.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 09:18:10 -0800 (PST)
In-Reply-To: <20130211165136.GC16402@sigill.intra.peff.net>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQmHbKuFbROIS9AjaiKtEa328nZjT7nfX6VfhJdu+D+hOG8ctnPdm4+NK0hmlSW1L9+lHa34Yc4xOf2ezH3hhyxrV9Xe9vaZnsTU2Ukg0744mKzJcAqM/0a0JajTglWhE3eK9IyEpBpmtGU/Wc+loqIVTEZw1moUCS7nOTv45Sh1HNbrqBJQgNjjnvAWiZ55QsR+yBFMZxV3BsmUB96+QiB+SK8LIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216060>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11 2013, Jeff King wrote:
> I have two minor comments, which I'll reply inline with. But even with
> those comments, I think this would be OK to merge.

I'll send a new patchset tomorrow with.

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

iQIcBAEBAgAGBQJRGSfMAAoJECBgQBJQdR/0V6AP/0pQFqOlgnNtYRyDxjBsFxu4
26Za4rGFHDqC3TfM0oYNywmFUO1GwG7nn1PgAwX0ahJZWeNQefS6BBv0IFEt++i/
KZCDpg9rViHQ9PdknHf/Ih84HkWnemPwSiJ2B0z830cK6uHrB7m82wx/QuHbvDfi
G/l30c//b2Jtd3gelgdLo9+xuiv35jUBermsKw7miHys0WbsxJKWM7VXhdBfdqxj
zhIG9hEI5Ilc1X64+EwWWzymh872ejrz+MqiiiGuqNbNpfU8KzqvaeFpQDn7esb+
RfO0JWqBsjOPmnFr7EKajOrU36BxDDiM202alttxqUxHHYc5uduoAGQHGOJfW9Ax
crdUx8vMCRGm65SIMNA8ZJubpX1f28f+NQFddYifdVqd2aKjxFrDvYouKTqnhXHD
SSjmNbr2qVCR+Xq4DdOb9c/5fHBo1dBTX3qiAAX8kFqe446jEG6uFqQhU04yZPbM
EIbTksh3F5OP/TVXPjePXUxxEx0zIqwDxXfQZpl5UO48cIT/7TuN2/2w5dLops7c
pse8JiOR0PwVHHGZr3xVA2ZQ+hx7OuqcB+f2HGNz1E7zKJZznBB61RzdsDa6MWCL
D6XyL2JBwIFajJI0CUdcEwkgkOigNO81qTQiNwm/dCRDCJyP5Pd0czygS32Usefs
VGqvTra1+T+s/VAuPfcJ
=HVto
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
