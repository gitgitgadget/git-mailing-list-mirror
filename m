From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 62 new messages
Date: Sun, 09 Nov 2014 21:00:07 +0100
Message-ID: <545FC7C7.1040109@gmail.com>
References: <1415394326-28696-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hvL1gob6jrQgQGqbap5lAw8VQXG8AI8cb"
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 21:00:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnYer-0000yg-GT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 21:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaKIUAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 15:00:12 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:53198 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaKIUAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 15:00:11 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so7264225wgg.22
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 12:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=6aikYZypU+0EL5Wp7FPAGF1AQ7UjQqDxh03YRQf6CCg=;
        b=Co5/MA4C7w+28aG8CVS9OD/HnVV8Na1U+bgLswd7ejT0VI/3+kMX1IIVmh/Csd21ZD
         GoeMy7ytuYxRl01mlGDvDZHG/rQQiWGU1CMmyAFYVzJmu8JFFgpw1i2PUu5N4W0pKvXH
         Tayb0FpuriepzuugGETW5m8mVoe3AGZJ3eT0ObZW2A1kAO2ce2Oni5Ra5yS6AcsGY/6k
         BRFSkHdMgRNrZHnH2X6Zz6+L1Cc856cGMSJforw56NUV/RKW8Qpwn4gmXcpWKNWpiUVZ
         UcEW7KC9NpcSoayCYXC19FioNT5yyf7EAan8fd1jRUSvGe5UCWXRPAQHt6W3xnU4P24O
         tYxA==
X-Received: by 10.194.2.244 with SMTP id 20mr37206693wjx.4.1415563209869;
        Sun, 09 Nov 2014 12:00:09 -0800 (PST)
Received: from [192.168.178.21] (i577ABE7B.versanet.de. [87.122.190.123])
        by mx.google.com with ESMTPSA id w10sm20397876wje.10.2014.11.09.12.00.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Nov 2014 12:00:08 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1415394326-28696-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hvL1gob6jrQgQGqbap5lAw8VQXG8AI8cb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

>  #: builtin/commit.c:594
>  #, c-format
>  msgid "commit '%s' has malformed author line"
> -msgstr ""
> +msgstr "Commit '%s' hat missgebildete Autor-Zeile"

I would use "fehlerhafte" as "missgebildete" is an old word (1) and I
would not use it. So maybe

+msgstr "Commit '%s' hat eine fehlerhafte Autor-Zeile"

>  #: builtin/merge.c:1129
>  msgid "There is no merge to abort (MERGE_HEAD missing)."
>  msgstr "Es gibt keinen Merge zum Abbrechen (vermisse MERGE_HEAD)"

msgstr "Es gibt keinen Merge zum Abbrechen (MERGE_HEAD fehlt)"
looks better to me.

Phillip

1: http://www.duden.de/rechtschreibung/missgebildet


--hvL1gob6jrQgQGqbap5lAw8VQXG8AI8cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUX8fHAAoJEJIt6Cqh4sVSz8QIAJr40QB3fkZF74It1ECFr3Ro
X2YcZvPGaYCxSb4/2ti43sA3e+BsC5TFJd6DXw3UplbZg9luWS1tHV1jeAcWo7IF
xIg1qg3lrNFOHUQG10pCJZ9Fnmsf6FgSz03ThotTbZ/WTDlRwmwxbmSEc+bA0V5z
ueFfC+gUlsyTxQy7BeMXivCOD880fb8jVKo+yGXsBF+BchEmJLyXWGDUASRC7JNm
yVSzrP+kfazcu51FZQRKTdBMyt5TkvG9nlqwSNn8SMlsbZ20wSqsLwweVLgNDpcz
mdjxSQK3efJhFcKBqSwbDsdpOzWQkClcTVnXSOXq02LG7UnmQ1Rydrh+5uZcu8s=
=MTdr
-----END PGP SIGNATURE-----

--hvL1gob6jrQgQGqbap5lAw8VQXG8AI8cb--
