Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486F51F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 13:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbdAUNcs (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 08:32:48 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34164 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAUNcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 08:32:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so13578377wmi.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 05:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v86XoD9KWL1Loxy/Y3Kpov41txdXOW7njXXBsRensfU=;
        b=CjxJoRibwo9lBgzW/j/VELJM4lxPg9KTUSNt0O2E5GUvJ5vRzG5pvoJUijR6qj7CXb
         XRPoGel6M/kGV5pGuCnYMgZf0l3rT41KydgGl9MA4F7lmoixkUPv8eynZubTfh/94R7u
         L6nbO9N0ZbmFiU0Hrc2CDr09jKqSFYKQoWN+AEz+WYKv1nAqsIq36UNImTP1L8zxYGBz
         XIMzGNdKVGYfukvKCbjL/mt+H3iu8FfZyUYxlhkGANrPyCYe44CPx/8VC3Ii05NmWDK0
         txx0PtsPazbyGbj3HTNiwoviA2nSvZrOcF+WwB5HCZuH55IaT6PzB+Rmd2e/JMElyEbP
         0s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v86XoD9KWL1Loxy/Y3Kpov41txdXOW7njXXBsRensfU=;
        b=CdDonR/JZVIV5UVeif/Wf/5ORNJvwRozCYPoxKpIFEnTboIrvw/dUDoxVztrxbagUX
         DsHFDR64mP/DtGwO5v3BHbfJySHNBU93tO3KVyZx+Oy4OexVvNdQoYixMJRgHTcqVViM
         0k2oWHm66BRmaWhmli9Cn6jZicDbXD+rAneKAPeLNMU4H7VwlEkrozMoLoTBj3SBEBx5
         4v1b3RvUeeF/YSM5YRcDA1Fx+bP5ILcnNDghFfmYhGb7+ofYmVpW7FQkD6Je8TAYpk/O
         1jQ+ZVTtRWeCA1VJxFlhkMqtaMOpdOlICf/RLotcbMpoKi5T9nVo+6zCXKxolhhJIZpO
         7GpQ==
X-Gm-Message-State: AIkVDXIWoHZ05a3XFzR3je/jdaYqA/kzDEyDUhg0D98PUkcV1wrayBM0wsu1i2CI4jcYRQ==
X-Received: by 10.28.30.12 with SMTP id e12mr7762125wme.125.1485005565839;
        Sat, 21 Jan 2017 05:32:45 -0800 (PST)
Received: from farjyzgg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id y1sm10711207wme.15.2017.01.21.05.32.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Jan 2017 05:32:45 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] git-p4: Fix git-p4.mapUser on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
Date:   Sat, 21 Jan 2017 14:32:43 +0100
Cc:     Git mailing list <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7425283-9C32-4AE8-A442-11B7CFEAB4E8@gmail.com>
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
To:     George Vanburgh <george@vanburgh.me>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Jan 2017, at 13:02, George Vanburgh <george@vanburgh.me> wrote:
>=20
> From: George Vanburgh <gvanburgh@bloomberg.net>
>=20
> When running git-p4 on Windows, with multiple git-p4.mapUser entries =
in
> git config - no user mappings are applied to the generated repository.
>=20
> Reproduction Steps:
>=20
> 1. Add multiple git-p4.mapUser entries to git config on a Windows
>   machine
> 2. Attempt to clone a p4 repository
>=20
> None of the user mappings will be applied.
>=20
> This issue is caused by the fact that gitConfigList,
> uses split(os.linesep) to convert the output of
> git config --get-all into a list.
>=20
> On Windows, os.linesep is equal to '\r\n' - however git.exe
> returns configuration with a line seperator of '\n'. This leads to
> the list returned by gitConfigList containing only one element - which
> contains the full output of git config --get-all in string form. This
> causes problems for the code introduced to =
getUserMapFromPerforceServer
> in 10d08a1.
>=20
> This issue should be caught by the test introduced in 10d08a1, and
> would require running on Windows to reproduce. When running inside
> MinGW/Cygwin, however, os.linesep correctly returns '\n', and =
everything
> works as expected.

This surprises me. I would expect `\r\n` in a MinGW env...
Nevertheless, I wouldn't have caught that as I don't run the git-p4 =
tests
on Windows...


> The simplest fix for this issue would be to convert the line split =
logic
> inside gitConfigList to use splitlines(), which splits on any standard
> line delimiter. However, this function was only introduced in Python
> 2.7, and would mean a bump in the minimum required version of Python
> required to run git-p4. The alternative fix, implemented here, is to =
use
> '\n' as a delimiter, which git.exe appears to output consistently on
> Windows anyway.

Well, that also means if we ever use splitlines() then your fix below
would brake the code, right?

Python 2.7 was released 7 years ago in 2010. Therefore, I would vote to
bump the minimum version. But that's just my opinion :-)


> Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
> ---
> git-p4.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index f427bf6..c134a58 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -656,7 +656,7 @@ def gitConfigInt(key):
> def gitConfigList(key):
>     if not _gitConfig.has_key(key):
>         s =3D read_pipe(["git", "config", "--get-all", key], =
ignore_error=3DTrue)
> -        _gitConfig[key] =3D s.strip().split(os.linesep)
> +        _gitConfig[key] =3D s.strip().split("\n")

I can't easily reproduce this as I don't have a running git-p4 setup on =
Windows.
However, your explanation and your fix make sense to me. If we don't =
want to bump
the version then this looks good to me.

Cheers,
Lars=
