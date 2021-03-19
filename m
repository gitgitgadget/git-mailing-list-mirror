Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C983C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 03:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0012E64F18
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 03:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhCSDRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 23:17:18 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:45009 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhCSDQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 23:16:44 -0400
Received: by mail-ej1-f50.google.com with SMTP id b9so7316096ejc.11
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 20:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6qcbUs8hWRlME3nQlPd3D425015ECMv8Njo63R1IUY=;
        b=QiTj7b7Da2alJgke3wuNZnxl6hojWukVfjZpuCZoqrzRQp3Tp3RW25u+krcjfWfDDy
         K5UF3H67AJINoldsuX3LfBC9RxwsGJdOkl1DCqGztYbKdnNd9ZZJCedamRSGevQsFuFt
         R2Pe7/oF3cCZZAkH3JqevOteaPp60MT5IIJ14a1jgzALri5Wr5atX9DbRZRF+7KAQC0Y
         F90i14sl8Atd2PLgPAl3b3nZN3Hj+FJQujzl0M5DYqv6/MPcrfwn/WJaq3hUPnw8gzO4
         Hr6SJMlMmGNBBV+CfjU/Pcv/HotOINWg8GAFXZHjuz8MK2srg0udFV3yQH1PqLDHQHcd
         92tA==
X-Gm-Message-State: AOAM533j6xpp9Dex1EdIEW2A7Gl3wCoRJIC8vwm7WdhvkBG9RJqHrABr
        8UfRhjHYoqcGXl0Xvfbp5m6ocBy+OC/oOtMD4s8=
X-Google-Smtp-Source: ABdhPJwYkBC5uixETtiwzVxLIQTBp0clbR5gZDnSJ4zKZtYA/olE52ukvHP1rURHhBU5F9eRG7C24uMtTm1F6kf6a5c=
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr1981326ejc.231.1616123803567;
 Thu, 18 Mar 2021 20:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210310194306.32565-1-charvi077@gmail.com> <20210315075435.18229-1-charvi077@gmail.com>
 <xmqqft0sotg4.fsf@gitster.g>
In-Reply-To: <xmqqft0sotg4.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Mar 2021 23:16:32 -0400
Message-ID: <CAPig+cSNgpw3LTbqj-_eBMM5SpKcOJUxM0Oszkuy4ju1zqH5Uw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6][Outreachy] commit: Implementation of "amend!" commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 8:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> Charvi Mendiratta <charvi077@gmail.com> writes:
> > Example usuage:
> > git commit --fixup=amend:<commit>
>
> Are people happy with this round?  I gave an extra round of
> eyeballing and didn't see anything suspicious, so I am planning to
> merge it to 'next' soonish once the dust settles post release.

I gave the series a final read-through when v6 was posted and didn't
find anything about which to comment. I think all my review comments
on earlier versions have been addressed, so I have no objection to
seeing it merged to 'next'.
