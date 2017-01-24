Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C671F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdAXOoK (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 09:44:10 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34341 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdAXOoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 09:44:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so35066743wmi.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mqIJSn123JySl9RjAxov95jDyPVmxs4Q2/SsUDAfNmM=;
        b=oEU+/yzaVS48w3B/tEkQuXr6YD0gsgLS2yXjoIC5g8U6/cM5Vv0cLfMPXHiVfqCSZS
         H8bxQIn/FkxwkIl98yGmsyvDkUOFzc2D67aL2tTO4kqcDMbMHOwvCz1lw+qutGYEJq+I
         YXKntW7tMg/zZF8kO5LkhOFdgxBTNzYCR+vHuVmOfYUEIwbytkg7fXb16+FP9XNiGBd8
         Ib7QsPvMfFEN80QJoBqR4W0v48mZZlkwvF07Vpuqas78OeU9AFA445tqX5QSg17AdGj6
         BLQ4IKsI85Dg8pASeC4y5g2UoTi9ONYskgXSO7M+i/nQjB2y3Aeg4G70jptvjpIpTHqq
         FpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mqIJSn123JySl9RjAxov95jDyPVmxs4Q2/SsUDAfNmM=;
        b=OFLIcOi+uiKFdfoxFRqpc/U6CGJd2acuZGnyAOYUcL2nN+muJadOCBqt22u+6VOzSN
         1hNLw2lfFELmhe/H1QlLx7Wq0pmT+6CyMRc4+Px0LBAFTYcYjDvgeH6yLzEMhEU4C/sS
         3BnHsTwe5k9Nv6VtlgxpvsRK8eV8Qjp5FmWQJ2xLR8pTXQ7GzC5enDH5idlx3x1OURLx
         //UxNIHwHpTDGUxbW6nrRSXw+I0Ge6TMM5VF5Z9wos//Z6wK91e0DVRQYJjXo1ZGRKGu
         OnX9wCUEKWuwnm4RtykOiQz9lqijgIJOXnoyNR2MeJPN48F3c0yhJ52QlSF0okpmfBRx
         P05Q==
X-Gm-Message-State: AIkVDXLlxof7zOmnS8eOCLTEgU06Ih9/Etd1i49wzL6cFHmRPbcbarZz2a/KanIZnec5Xw==
X-Received: by 10.223.177.195 with SMTP id r3mr29772316wra.147.1485269038558;
        Tue, 24 Jan 2017 06:43:58 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id c202sm26622354wmd.10.2017.01.24.06.43.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 06:43:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
Date:   Tue, 24 Jan 2017 15:43:55 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E88FA516-5EA6-491F-932E-2CE83F7C635C@gmail.com>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com> <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com> <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Jan 2017, at 14:27, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Jan 24, 2017 at 11:04:21AM +0100, Lars Schneider wrote:
>=20
>> "fsck: prepare dummy objects for --connectivity-check" seems to
>> make t1450-fsck.sh fail on macOS with TravisCI:
>>=20
>> Initialized empty Git repository in =
/Users/travis/build/git/git/t/trash =
directory.t1450-fsck/connectivity-only/.git/
>> [master (root-commit) 86520b7] empty
>> Author: A U Thor <author@example.com>
>> 2 files changed, 1 insertion(+)
>> create mode 100644 empty
>> create mode 100644 empty.t
>> override r--r--r--  travis/staff for =
.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391? (y/n [n]) not =
overwritten
>> dangling blob c21c9352f7526e9576892a6631e0e8cf1fccd34d
>=20
> Looks like "mv" prompts and then fails to move the file (so we get the
> dangling blob for the source blob, and fsck doesn't report failure =
because
> we didn't actually corrupt the destination blob).
>=20
> If I'm understanding the behavior correctly, this violates POSIX, =
which
> says:
>=20
>  1. If the destination path exists, the =E2=88=92f option is not =
specified, and
>     either of the following conditions is true:
>=20
>     a. The permissions of the destination path do not permit writing
>     and the standard input is a terminal.
>=20
>     b. The =E2=88=92i option is specified.
>=20
>     the mv utility shall write a prompt to standard error and read a
>     line from standard input. If the response is not affirmative,
>     mv shall do nothing more with the current source_file and go on
>     to any remaining source_files.
>=20
> Our stdin isn't a terminal, and we do not specify "-i", so I think it
> shouldn't prompt.  It also exits with code 0 after failing to move,
> which is another surprise.
>=20
> Here's a patch (tested by me that it works on Linux, but I don't know
> for sure that it fixes the Travis problem).
>=20
> -- >8 --
> Subject: [PATCH] t1450: use "mv -f" within loose object directory
>=20
> The loose objects are created with mode 0444. That doesn't
> prevent them being overwritten by rename(), but some
> versions of "mv" will be extra careful and prompt the user,
> even without "-i".
>=20
> Reportedly macOS does this, at least in the Travis builds.
> The prompt reads from /dev/null, defaulting to "no", and the
> object isn't moved. Then to make matters even more
> interesting, it still returns "0" and the rest of the test
> proceeds, but with a broken setup.
>=20
> We can work around it by using "mv -f" to override the
> prompt. This should work as it's already used in t5504 for
> the same purpose.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> t/t1450-fsck.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index efaf41b68..33a51c9a6 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -536,7 +536,7 @@ test_expect_success 'fsck --connectivity-only' '
> 		# free to examine the type if it chooses.
> 		=
empty=3D.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
> 		blob=3D$(echo unrelated | git hash-object -w --stdin) &&
> -		mv $(sha1_file $blob) $empty &&
> +		mv -f $(sha1_file $blob) $empty &&
>=20
> 		test_must_fail git fsck --strict &&
> 		git fsck --strict --connectivity-only &&
> --=20
> 2.11.0.840.gd37c5973a

Ack. This patch fixes the issue:
https://travis-ci.org/larsxschneider/git/builds/194819605

Thanks,
Lars=
