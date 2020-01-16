Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBD4C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EC52072B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WOp7jdHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgAPVmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:42:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:56811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgAPVmO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579210926;
        bh=LEckoX+WCZOpYAgs4VeqMKUWATTVfoaTOKYHbyeY6+U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WOp7jdHt1wOjWRw7ajPO2CsPXw1UYU9/jgDYUHWaW2RTnhh80V7ylksIE3IQDScJl
         GbpwDosu5JWqipNpPMBxt+jm4pqtYpN+m05gm02asd4cZGbVXsupCxVQW0DeTlhnzr
         B08aLfnrmKGDUUpU5BPqgOlxDcW+pNPOcrpOj4y4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1iufsF0FFh-002aTF; Thu, 16
 Jan 2020 22:42:06 +0100
Date:   Thu, 16 Jan 2020 22:42:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] t6025: modernize style
In-Reply-To: <20200116203622.4694-2-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001162239400.46@tvgsbejvaqbjf.bet>
References: <20200116203622.4694-1-shouryashukla.oo@gmail.com> <20200116203622.4694-2-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jDDn47bzN6LL+y28l3i+xsM0jTgZKExUYLEUg1L6U2E7IvrGBGB
 DKdi3vwVIDQ668a+pR5SuqBBvJ/v1B/MUNLxh2O2Qzi3QS+PruMqcUMyftkxYoPdzj9SK/H
 3DjI/2mIa7pc8/epWS2Pd2vCyHDYSLZQ1A6MYvZ6SENqu1PbJYVm7GYlQzsoORrI4nuvXSu
 dTHYgXZMd0drM6kBK62Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rD+iE5cGZ9U=:8PvSE0KYugNiJUjiNISKXo
 xx9DLc+1AnY6uTzQj/0MLQqYfbwSBMP/VLjGZr0RGEmmzjIf9yZbuGu34v8WuUrUzWjzNBzlM
 /wtFS4i2/4QMZwPl+2nRb3a1XLre9EUgRlx5oYictdLf8L5zpwh0W+7lbPOVG/A1TMhGH0zZZ
 jC4vijSc2ieIfkA8q8UYFDYI+wCAnmRC85YqXYGqICpYGxZGDyLk/sid0VEmV8nYWz4HmNflJ
 R7bgZg1PUdeuJVde3N7RkhQQ2uE+/QHJRqdcp2kBJH3m0E4FskZZXrEbqmTH/d2ha94cb1TQ2
 IDh/4GERaFLZiFpJzI/MZgdaLqhnGMWl4/yEBplOFAKItX3tGxyytHV0rBkzeIoiKTTQGvBMt
 +NP3NB02UOT9hizI6Z3rDqZ+/amO+/Tl6uhS//1YeWdJJzwJSgngVOd7J4fbtB0tsGqvf2/cg
 zt4aJe/6zcKA6RPmJtmycaG5Zd9gW6Ta659sn1lvwvZ+EyWGSr5r0DyPSMWbmtC1x4pSkpzMk
 EWIEfrlGyHPA+JEThNPbUy5e7VoI1yGh+rk134+C0nksINNtkBLYK4B1Md35C2n5ZfL/Xaf2G
 tDgAURRk8UJW8jdMhAbLL9vetbIEut/whNQPlKIHrCi7qlg4sTSV+70fgmW85TM6CNXpZonSm
 suep11aFvwGfGEf4xyCacR3EPXXC2agQovYSOVcVtmH9zig3WK4PCAUwVfoUNSQ4E9Pd5yrr3
 b4O1c84FSbq7BnBHyiuw5TEaXWp0lmQaOFkZ4d4d0G5bYAoM5ZS0465/oqca+6+rcekh/BMii
 38IOFZ37Bc96gotz/yU2HqaYEaRiOhnXXfam2nl80v/5ZbD56qKgf3+AVUhU7f8KyE77azSxg
 TwqDjRYNAE1rrk2BEnhcCqgnEy4tI2L+hUFcynpMRxhZU+Q3KWxfV9LZmce41KazZst6Ezpo3
 I3mwsSXx0lJOlrvgpAQZHmFfhicpcOkF+I056DL2313ZroMfsfVyz2Y1LYv6vrUkR8i6butEI
 Yn4mxMKKVlpi7zk/CI3rNMmsmXTi6dV6zZJ9eF5yY+2yQ8GGTc9Vyai7wzx2QUsMM62xlmBcL
 wbpg3cvZIAhZSWXZAtosJkJWb3F8cI5fJBz1HubsUaeXApVzOz3irpBhJASMqcl35Yd2Q2en6
 J8eF7GFsqq6RWJbvohHdtn0j2cJ3d8C3P2UXT7HmHFFrptuMfHOYsguY1QA4cIBudj0JK21X+
 2S9KGPKMH0+A5yYBRpVh0e9TXpmne6GpXnscYUyjSInUF9g2HHO+R2RQf7PI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 17 Jan 2020, Shourya Shukla wrote:

> The tests in `t6025-merge-symlinks.sh` were written a long time ago, and
> has a lot of style violations, including the mixed-use of tabs and space=
s,
> missing indentations, and other shell script style violations. Update it=
 to
> match the CodingGuidelines.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---

Sounds good. Just one nit:

>  t/t6025-merge-symlinks.sh | 97 ++++++++++++++++++++-------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)
>
> diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
> index 433c4de08f..b9219af659 100755
> --- a/t/t6025-merge-symlinks.sh
> +++ b/t/t6025-merge-symlinks.sh
> @@ -10,52 +10,55 @@ if core.symlinks is false.'
>
>  . ./test-lib.sh
>
> -test_expect_success \
> -'setup' '
> -git config core.symlinks false &&
> -> file &&

Here, `file` is written as a 0-byte file, and...

> -git add file &&
> -git commit -m initial &&
> -git branch b-symlink &&
> -git branch b-file &&
> -l=3D$(printf file | git hash-object -t blob -w --stdin) &&
> -echo "120000 $l	symlink" | git update-index --index-info &&
> -git commit -m master &&
> -git checkout b-symlink &&
> -l=3D$(printf file-different | git hash-object -t blob -w --stdin) &&
> -echo "120000 $l	symlink" | git update-index --index-info &&
> -git commit -m b-symlink &&
> -git checkout b-file &&
> -echo plain-file > symlink &&
> -git add symlink &&
> -git commit -m b-file'
> -
> -test_expect_success \
> -'merge master into b-symlink, which has a different symbolic link' '
> -git checkout b-symlink &&
> -test_must_fail git merge master'
> -
> -test_expect_success \
> -'the merge result must be a file' '
> -test -f symlink'
> -
> -test_expect_success \
> -'merge master into b-file, which has a file instead of a symbolic link'=
 '
> -git reset --hard && git checkout b-file &&
> -test_must_fail git merge master'
> -
> -test_expect_success \
> -'the merge result must be a file' '
> -test -f symlink'
> -
> -test_expect_success \
> -'merge b-file, which has a file instead of a symbolic link, into master=
' '
> -git reset --hard &&
> -git checkout master &&
> -test_must_fail git merge b-file'
> -
> -test_expect_success \
> -'the merge result must be a file' '
> -test -f symlink'
> +test_expect_success 'setup' '
> +	git config core.symlinks false &&
> +	touch file &&

... here we now use `touch` instead. We do prefer `>file` in this
instance, though, I think. At least we do not prohibit it.

Otherwise it looks very good!
Johannes

> +	git add file &&
> +	git commit -m initial &&
> +	git branch b-symlink &&
> +	git branch b-file &&
> +	l=3D$(printf file | git hash-object -t blob -w --stdin) &&
> +	echo "120000 $l	symlink" |
> +	git update-index --index-info &&
> +	git commit -m master &&
> +	git checkout b-symlink &&
> +	l=3D$(printf file-different | git hash-object -t blob -w --stdin) &&
> +	echo "120000 $l	symlink" |
> +	git update-index --index-info &&
> +	git commit -m b-symlink &&
> +	git checkout b-file &&
> +	echo plain-file >symlink &&
> +	git add symlink &&
> +	git commit -m b-file
> +'
> +
> +test_expect_success 'merge master into b-symlink, which has a different=
 symbolic link' '
> +	git checkout b-symlink &&
> +	test_must_fail git merge master
> +'
> +
> +test_expect_success 'the merge result must be a file' '
> +	test -f symlink
> +'
> +
> +test_expect_success 'merge master into b-file, which has a file instead=
 of a symbolic link' '
> +	git reset --hard &&
> +	git checkout b-file &&
> +	test_must_fail git merge master
> +'
> +
> +test_expect_success 'the merge result must be a file' '
> +	test -f symlink
> +'
> +
> +test_expect_success 'merge b-file, which has a file instead of a symbol=
ic link, into master' '
> +	git reset --hard &&
> +	git checkout master &&
> +	test_must_fail git merge b-file
> +'
> +
> +test_expect_success 'the merge result must be a file' '
> +	test -f symlink
> +'
>
>  test_done
> --
> 2.20.1
>
>
