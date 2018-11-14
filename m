Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420591F97E
	for <e@80x24.org>; Wed, 14 Nov 2018 22:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeKOIl5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 03:41:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41052 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732588AbeKOIl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 03:41:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id 14so5903538eds.8
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YN0dVlABwat5QKqPQdXrhPHv4vR7bjuLjwqtaaPnlCw=;
        b=GZmVFsRZtVTR1HUlmWoWFewCaEzz8hwM/fekrqUsXVF1aajccc/W0Y41ROU6EFb+Q0
         btftyHfsC27K4zbZTRoy+zLGgQ8qYws2LITumiBdemFKUVwVwKAmnh9tquyoqBZYawzq
         SH80Axv4qEpEnEGb5kuiSu4oX7urmphLSGa7RD9fRe0kk9bVhIh5ItrARezEXRs4aR3W
         wA+S1e0JT7UBaFwWXybU0UdS+WHqxXMmy75IVV9wXb2gzb56/wzHWHm9yH/tCAohhHGt
         VoLrg1wDgsWvRfR52BnzMDH9jJdb1aL51lAJgeEnvfsrO+PD3gAjeb60maBFnjxDi3OX
         aTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YN0dVlABwat5QKqPQdXrhPHv4vR7bjuLjwqtaaPnlCw=;
        b=h77uwTsKmXu+UgvT88HwOnk9wDUOzR4Icvi4GHOjMAfQc0R2ebDnwL8acHw018wF8l
         epgELgRTsKnKwIVuirkHcH2M++OPEZzg9WxR9+VHCmxXQHW2rc8daOBW9Xk4rVMxk9qs
         66XY+xH69DJAnoT6dfgMaPrV7DmBUGfOkutDGU4FpiHVoUNoBvdmLcMieNrTKq7jJ7FY
         hZ6Df6iAC17U625oxXe5fFZ6G87XRJVxb1Mo3Okk5UkSMgvfxHLEocHHfYhXH3n5qTYE
         ehkiyeYldczom/YaG2IBfwQE6g6+lcgh3Nzj7TvNgxmHREwpEkjZlw3m7pkMF0Z9kplF
         XdzA==
X-Gm-Message-State: AGRZ1gJw7wdRhq/J1GU+BgrQ8WJh03pxxTqNBaiLUgckiBSVroQx4hR1
        dSlN0w2EOAcDGHwSjvMKWhoqYRgiBf6SUUKyAM3qsw==
X-Google-Smtp-Source: AJdET5fonCeM8e9OOqi99/LgZuI4C6DTe+idTpWtoNXM2KrzeX/9Mk2D7QqedkTrEpI+uoHYe6+3lwo8ElhlZhgrXME=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr3491739edc.76.1542233339748;
 Wed, 14 Nov 2018 14:08:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.79.git.gitgitgadget@gmail.com> <pull.79.v2.git.gitgitgadget@gmail.com>
 <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
 <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
In-Reply-To: <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Nov 2018 14:08:48 -0800
Message-ID: <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ga=C3=ABl_Lhez?= <gael.lhez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 1:43 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> On Wed, 14 Nov 2018 at 16:26, Ga=C3=ABl Lhez via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > However, the `.lock` file was still open and on Windows that means
> > that it could not be deleted properly. This patch fixes that issue.
>
> Hmmm, doesn't the tempfile machinery remove the lock file when we die?

On Windows this seems not to be the case. (Open files cannot be deleted
as the open file is not kept by inode or similar but by the file path there=
?)

Rewording your concern: Could the tempfile machinery be taught to
work properly on Windows, e.g. by first closing all files and then deleting
them afterwards?

There was a refactoring of tempfiles merged in 89563ec379
(Merge branch 'jk/incore-lockfile-removal', 2017-09-19), which sounded
promising at first, as it is dated after the original patch[1] date
(June 2016), but it has no references for Windows being different,
so we might still have the original issue; most of the lockfile
infrastructure was done in 2015 via db86e61cbb (Merge branch
'mh/tempfile', 2015-08-25)

[1] https://github.com/git-for-windows/git/pull/797
