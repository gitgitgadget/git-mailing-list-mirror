Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0D220248
	for <e@80x24.org>; Mon, 25 Feb 2019 06:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBYGuk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 01:50:40 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43459 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBYGuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 01:50:40 -0500
Received: by mail-ed1-f41.google.com with SMTP id m35so6571422ede.10
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 22:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvZPSKE0cDU+ly/Mk8tBCUKF6Tr8uC2Kt2Ib3hhhROw=;
        b=E5uZIPU8B9WeHwiUqkGHQg6cvM0sYgrml2yL5QxWMMnHmBQR3ONuy4jPlGfts7e0oW
         qOm3Zuo7gw8yyCw7+yu5G778D8+lmy9uPX7nJp7qm2Gka34jFObxrZCJO6OR3S7fX4c+
         gq99DMjTr+t/UOwdRqiMqAOHwDmdgu63w8OOy0/OLqkKEs3WjqoqcSI0HcWlDZ28wlDF
         VK2DBMLtF1jBLOLWvhzJSOJBPlqcPtDr0YuKCt0BOvEYVGbS4RR9IU65s6udUiX6h/TE
         6VNWTGHhx2vT4MNIQkhzG7kcbBopcnckqLuG88W/+m0W3jUgmxWtTe+C6pPF64+c/v1F
         i1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvZPSKE0cDU+ly/Mk8tBCUKF6Tr8uC2Kt2Ib3hhhROw=;
        b=KrK+GtGPQbL/PZOkMY66TiOdvMgRJmF5PJCaYkA6h0Oie8pRUeMQltQhidSreQe56R
         BwLucxZ9vZ9bnXi2NjVAmgq1v6eMdlMdmvpjpuOWuskrdmNStBqlzCp7UCkY+1avTOYs
         bUmh60ZWHFG8z91sq16WEmx+g8GRONy+TM9OlW+JgCtg5NQ0RI6w6Sjb71LW2Knq+GEs
         tr+Y1orIiUyyNrK//WUursKd+axqJ823lXfVXZgHNSzzlMFWGuUoBFuiG9L7+yJIn1aa
         zDDpscGu0Xrmx6EYicnbsPc6Usm16j48smmW0PUjJrrbBzVr9lGDdfSCcBnytpuExMXV
         RdZQ==
X-Gm-Message-State: AHQUAuaCSsNRL5dY/5NQsWrbgCIaOZ+/Dsp/bCi9o3MyMnKtOwY8gTZX
        WLOudRR5ZcFAMNfy25OkKUdXLPqhmn23dtsTbBy8hmuZqmA=
X-Google-Smtp-Source: AHgI3IaTOIeafdWLxgq3AooXjN+BbfPQsnc15jnEOxj1sfGFJwpKJdnkFnru1z7kmKDU6G+IKHSAA2ODl5hohivBibw=
X-Received: by 2002:a17:906:52d5:: with SMTP id w21mr11836775ejn.172.1551077437874;
 Sun, 24 Feb 2019 22:50:37 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
In-Reply-To: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Feb 2019 07:50:26 +0100
Message-ID: <CAP8UFD1U+4ww8rC=TSjjH+Rt77P9w4YWA9s5yspVZ7GgPpx0pw@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Sun, Feb 24, 2019 at 11:08 AM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:

> If you disregard that contribution, here is my approach to solving
> this microproject: search for `test -f` in `t/**` and replace all
> occurrences with `test_path_is_file` and similarly for other mentioned
> commands. Is it correct?

In addition to what Dscho (alias Johannes Schindelin) wrote, please
just send one patch that replaces `test -d`, `test -d` and similar
code in only one t/tXXXX-*.sh file. No need to do more than that.

Thanks,
Christian.
