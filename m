Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C40C46467
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 00:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjALApW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 19:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjALApO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 19:45:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85011DDF2
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 16:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673484301; bh=TftWP4ndW5yg57/gx9g4U/yYJunNUInhVZOsElKSQ+0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Kq7b4ysNzMXLlzdtToTi75jsxffAwfSjpM4NCA1tA20oDevvMTLZ4Prlo6baj/xuO
         QkW8zCZZIlbYZQNHTKt5CSiULiOfeI8QLRozh/veydUtJ0xhAKzGabGBRzRgs475Re
         1WeePoRFGPCYS0rdiL89V1uomQsfpkB83MzDK5bhnmCJbI1PGuBNEBDSTwlGcqirsE
         w/oOg5OzM68duiSQYFUx3Njr+Rt7Fo4+DrjVBSPBb5XOWMvSMDd/3gcxQdwfL3eYNl
         7NbFu2h+Pu5T72F7YyuAfMoVHkOPJP6nGHx+Z/6fzkFDpUHNzRRR14Azz4ZHKEX4P1
         Q+FfbekUd58ZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([79.195.233.224]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1pSKn03HsI-00MgX5; Thu, 12
 Jan 2023 01:45:00 +0100
Message-ID: <df736b4c-3773-9f14-f66b-1325688634ab@gmx.de>
Date:   Thu, 12 Jan 2023 01:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 0/3] fixes for commented out code in tests (was "Re:
 [PATCH] *: fix typos which duplicate a word")
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Robin Rosenberg <robin.rosenberg@dewire.com>
References: <20230111233242.16870-1-rybak.a.v@gmail.com>
Content-Language: en-US
From:   Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <20230111233242.16870-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GsWVVEq25DQpO75bLjIC5CGkmMAu1bcTE/5bprGawBS2I/jD6YV
 xFR0VMqnHyOu1Ft/xdkny3jK0SJiu0XW4kWlK1E84Q11HZU4HooTkkqHKoc4/mQy56tX/J+
 xh2OUatUvk/+4Kz4OyN3KxNDTiPy6/jOYi9H3ZMnAXgc4sfkC/6agIzunApWmZsSpIV8Viv
 vN+wNOTIma5zykmwkwivw==
UI-OutboundReport: notjunk:1;M01:P0:6R2Tbt6bEcE=;+kzTfEZYtomRSo35qlIelq0FMHl
 SdQzxP2e/XzcgKdMCgB1Qe+9Z6aitAaV4wgRMZjPPDyn5JafM2QJHRqdMyKBe8Fl70gX+28Zs
 ye3vw+W7nDQ7q0RcOMMV2jTcvAn+DMNaIzWekrhZTVbPFPHxs59UZTg+PQvPxBDF6KqwelA9c
 aVSEmBzE/GTkrEnd1PLI2i/+j5jb+U8vyz5VRZfw/JbTni1aNN27IPdJzftS9kHWQcf6Nqw8N
 ucIKMatVe16ahGbeR2gVwsBCh+piiuHtwEr1Gyt2pKpY1TvV6O/PXPju4jLH95bXQLKH5zxKP
 WYd9DpSJ21tyoMt1zLqxZJGj1LFSl1Eh1z94SvrGZGHJiVg/6YLn6YlvtTuCbLkSI1TpX4X2O
 dY2sEav4oZICHhdXPYe7btOiR831iWiTsZiPeFG8Z/lG6uEbueuqvSCFa2JSSUTr6xU4qBgCh
 uEUOIJEfKMtDi/R4GbNz5Q9GON6pMVWjyRpI3YPfMUo8urz1FGf32LhXSjhgMs2bDAYI/ZDn3
 BapRvS4PxuPW7OX8L48jW3YNMCvA4iU0dMbbamw/GWMP1MEbOHLwT3sHc/9AAxtan2G+9f7tL
 TN6wnWpCKJzqYPmHZZAkluyyB856667RjI3Ok7NcydGMRXqdpaM5sOCFkBaLs4CYjSFZv54O+
 6qckJjJqnQBWdURZX83arbROrCAPy+hCtPVnqxi8j5fGquwriPu9EBRWvwMxcjjLM9HOtz5qB
 PqTlIHMEd7T0DVtjm7IuQmh29mi8MwcAfxlWa/A09Bn5NQPwH4nyESggxgniDqWBsRD0TPIQY
 KGbhIA510wNuIozsnFTmYK5wM+C4zMhF1yGzMRkJR5KCo0YFFWWwGZHCIPCCTZzDKE8tSYUcR
 ZFQayNAwfDbTq+B3g+bswNZH1zOxTEfRknzp8+8fSb+zJQ60zIdA2Z8QsD7YfRKG+j7yjmCFU
 OG/wTLU4kFpvmqI/6R9BJtyNFms=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.01.23 00:32, Andrei Rybak wrote:
> [...]
>
> Here's a patch series that fixes some of the commented out test code.
>
> I skipped changing the following:
>
> 1. a minute-long test_expect_failure is commented out in t0014-alias.sh =
.
>     Technically, this could be uncommented and marked with `EXPENSIVE`
>     prerequisite, but it doesn't seem worth it for a `test_expect_failur=
e`.
>     [ cc Tim Schumacher, who added this test in fef5f7fc43 (t0014: intro=
duce an
>     alias testing suite, 2018-09-16) ]

The reason why this particular test is commented out (and why it
mentions a run time of one minute) is because support for detecting
external alias loops isn't yet implemented. This means that running that
test would spin the test runner until the test times out due to an
intentional infinite loop.

As soon as that is implemented properly, git would ideally detect the
loop after a few iterations at latest, so the test wouldn't require to
be marked as 'EXPENSIVE' in the first place.

For the context of your patches, skipping adjusting this test is most
likely fine, as it references currently unimplemented behavior and it
presumably would require more adjustments anyways before finally being
enabled.

>
> [...]
>

Tim
