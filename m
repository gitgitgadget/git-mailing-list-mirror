Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBF72095D
	for <e@80x24.org>; Wed, 22 Mar 2017 18:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965832AbdCVS7L (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:59:11 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33688 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965828AbdCVS7G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:59:06 -0400
Received: by mail-pg0-f53.google.com with SMTP id w20so9237867pgc.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wYMEWPBpRjZ/54gqs0AKXx9ZGFnY/wf3aORQnS8oqz0=;
        b=Iq0ok4sfQseo7ZyHFS+HbFSXAmvX1FF4V+QOmcNgXXopkZrmwG5PNe8IWlxZYEAFSf
         59YmZdSRrVxiFq6VIoomIqN53MV2SHWluq5Rj0bv7/M1Smsi823IVNJAjDvuttOaZPAE
         w5HmY1B1Joh67MS7f+edhSl9F+AUgrRI+ntps2vrlQkc7jgNXW7Rs/qgxpLVIXTiCjWk
         z7mXAkN1M92NQQeWrLLDiN9zeFfBLyqgaK/2ymnXZgQ82DmJIAtJOju5aNCwEgqNm7bO
         0Ld23hLtUA9/K/88ZeHgBOx1QdcNuK5fabsxmy+jdGbI+12xqWjtXSnqQ1T4t+1m25vP
         KpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wYMEWPBpRjZ/54gqs0AKXx9ZGFnY/wf3aORQnS8oqz0=;
        b=txCpDeGY0I+mPrM0EbdZOLzmaopc0QPc627pBPV5z2RdMWnXUKq7yb0kUw+k/WGtak
         adFZAVPcRpCFvEOCn0y9qCZfwyfSZ7zt1pqzqSnSRM2gX8zNKXWLwMPIC4PdbvnBRUTN
         +VhCzAEZAtGyuEw6m+GeBREXjdClirVICuHkfKPmvdQR6Bt+ie6PSKOXLEFMeUB8gfE5
         VNzrkG/sX0GbZeUi1GmZ9AGSktvQszM56bfMNoonh+xvbKFfJo9l5/lxGsEHYUHN/iPE
         /UMuABuoXMr2NTnznchtHxxYIvqp/GjFD/PTx2tW1jdTVVflGZJDta+TTAczGIgroo2q
         Vbqg==
X-Gm-Message-State: AFeK/H3e8MwAqwEgQuE75yb0GdZCQ7nWBgbr3NoAXPpe3ZOlfHYdQKUpDp6+LbhD0PbDA1FWnbLHsSdXo3rswH9M
X-Received: by 10.99.120.5 with SMTP id t5mr14423205pgc.223.1490209144685;
 Wed, 22 Mar 2017 11:59:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 11:59:04 -0700 (PDT)
In-Reply-To: <xmqq1stpkun7.fsf@gitster.mtv.corp.google.com>
References: <20170312200248.3610-1-jn.avila@free.fr> <20170320210225.13046-1-jn.avila@free.fr>
 <20170320210225.13046-3-jn.avila@free.fr> <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
 <5036581a-f989-2db6-06ba-621db05c6de1@free.fr> <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZBq+dL7hEj108DPU5KbVeJX2nYEw88jS0Eq78GxzCabA@mail.gmail.com> <xmqq1stpkun7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 11:59:04 -0700
Message-ID: <CAGZ79kZUAQ1sR0d0=KtkbWprO9VmpHO2SFFW7AYMS=wwaKjLtw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> So we'd want to be able to say:
>>   "get a tarball including all submodules except the superproject"
>>   (This would produce the "optional language pack tarball")
>
> You do not need that.  Just go to the gitman-l10n project and grab a
> tarball out of it.

Oh, I misunderstood your proposal.
You said: We have *one* submodule for all languages, but I understood
we'd have a submodule for *each* language.

Thanks,
Stefan
