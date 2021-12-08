Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A73DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 04:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbhLHEGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 23:06:21 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:44895 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbhLHEGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 23:06:16 -0500
Received: by mail-pj1-f44.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso1078097pjl.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 20:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8T8W9q8gLB1uN9kP0EIPO0bO7yeJcbtWmmJF6kXaGHg=;
        b=u6CM9x/fW6VlUMkoqTXcunLGnMsLvFmLIVFK62o3OHsy/0AKX3sDGRks/TEbpjxw+X
         X9eVl8si8Y2jQzKJzSGbzLfh8jiJjPNhSutYwcedtuW5FF1WZM5Sm2+Sv3xKrTBWNrTO
         CDQDAphMQLeeIf+P3RSzr6f5nwomwba1YxEiSAQ0o4tOplcjZqLehb6zwTN4XBHsQuQr
         K1A6m0OjNl1o758KNeAe9v+L0z68sAqf8fiHjMar5xxnDd14HMZT0oWJwuAyyR443lV8
         UdNpnqSRQg4x9iwqsmljhvxiLttQnPK385KXCLgGU2oCacOSG4vXmPqfUvd76nGnBb/4
         8uPA==
X-Gm-Message-State: AOAM531kG9QxfdTmZ+SP8KSp/BboQ21knBYY4Z6ojmEwyTMpn3h9/db+
        WcorKVTi2W+EedncLFNGGfWhvWsJmgAaJJG4LN8=
X-Google-Smtp-Source: ABdhPJyJUow0hEJ9ZKuBWY/cK5qJqYIwZMR41NhiaHpFJj2vL3yPcFLmXA7RgB31e6nnsBhyG05F4Zx2s5uXWpZx9y8=
X-Received: by 2002:a17:90b:4f44:: with SMTP id pj4mr4287547pjb.150.1638936164662;
 Tue, 07 Dec 2021 20:02:44 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8rwv6e0a.fsf@gitster.g>
In-Reply-To: <xmqq8rwv6e0a.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Dec 2021 23:02:33 -0500
Message-ID: <CAPig+cQDpq6NPTiTdeTxEtMwQrvdfswjgXR28BFQX7WQju2LZg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2021, #02; Tue, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 9:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/doc-stdout-vs-stderr (2021-12-04) 1 commit
>  - CodingGuidelines: document which output goes to stdout vs. stderr
>
>  Coding guideline document has been updated to clarify what goes to
>  standard error i nour system.

s/i nour/in our/
