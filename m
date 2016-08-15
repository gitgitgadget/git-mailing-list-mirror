Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F73B1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 19:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbcHOTHb (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 15:07:31 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38321 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbcHOTHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 15:07:30 -0400
Received: by mail-it0-f47.google.com with SMTP id n128so15329219ith.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 12:07:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sp87e84hH7zTz4Yg3BCTB8Vf3VHOC3wxIttbG5WXfJA=;
        b=ph5tZHi8/MnmZJM9mGqI7olyAEZwjup3Sa5fTp6QghqbumYw5xTlWadPupPjfi6WPy
         izodqbeyf+ilJT4Fk0k/7ctxb7xhzalh/xJcSyv14eoxotfq8cSB+djJd1aCkNiULIbS
         o28igGh+TjGDUPaPg9+Dxh7FNZz//A5Zon8cEHY7P47mNJwUCJ1m9fNn2Vu0hqJjm/tq
         1B66tePkuwHQw6vP38eNBsgywQvuiSvr/60Q0TWLX0rRMNtEicLzYRP3B0nTFCKNB0hi
         DqsDDNssTg1KB84Zh81mLI57CMoiq6housluA9fKnIv5yrlqiGGRcT7/V4GXSdBFX2Dw
         JLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sp87e84hH7zTz4Yg3BCTB8Vf3VHOC3wxIttbG5WXfJA=;
        b=ZVZhdscbPwBIhhEuPo8eBBmZ1hW12DNbB1NyWlalq1cUp3u7XM367wyiootx6PzdVi
         l66Bfh6WAxJfUHCEW7LIs1MNsoOo+7cUBeggILQ1sC4leayddSuEWayrW3uAe9SueklX
         arrUiFPc2M5q0asKolmk7yB0+TU6gGrRuzprygn0oxZ6M8SGTpWJaYIdSHBUM4AHMjXM
         vR3uK0VJ/so5PJNQzlHRbePBbTQW6eHxs1CA9i7ntizbmkCR+oaVGchBwUMpCxyU+iF8
         kPQ3WwHLnmgHp7/KGD61J+O1hIiRORifvPgTxMVlgm60FExMB/ibBpZN5eCrWlt42mFN
         3mjA==
X-Gm-Message-State: AEkoousfetjiYXvOFbobQ8yMWn4AV/CLQhV6J6xt5xUlOa1B/KwKluO0HDckLHVixucagxwsslPUwvwX+2pweYUO
X-Received: by 10.36.227.130 with SMTP id d124mr15237185ith.97.1471288049649;
 Mon, 15 Aug 2016 12:07:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 15 Aug 2016 12:07:29 -0700 (PDT)
In-Reply-To: <a44793c6-6510-9b62-d5f4-60324a062164@ramsayjones.plus.com>
References: <a44793c6-6510-9b62-d5f4-60324a062164@ramsayjones.plus.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 15 Aug 2016 12:07:29 -0700
Message-ID: <CAGZ79kbsyjgPnZuCBrivYUN-tYoDNkT9VKrwXC8=C9UoorCtLw@mail.gmail.com>
Subject: Re: [PATCH] submodule: mark a file-local symbol as static
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:	Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 7:31 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> If you need to re-roll your 'sb/submodule-clone-rr' branch, could
> you please squash this into the relevant patch (commit 7bcd1d17,
> "clone: recursive and reference option triggers submodule alternates",
> 11-08-2016).
>
> Thanks!

Thanks,

will be fixed in a reroll.
