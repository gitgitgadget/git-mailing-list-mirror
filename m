Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5DE1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGAX1Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 19:27:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39530 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGAX1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 19:27:16 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so32755718iod.6
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5J/jApywo57AJgkXgiYRA3/vk45uUXJMjdkrBsDWtHo=;
        b=CzcqObKziGn4Mf+862WL2kUTDBBIp3xQwVfZFrVoLW8GprrvzezdJgFmE6zuCK46dl
         iz6v0Grx4nKtWv23jw75nbskOYuoz7xbq8TS9DsUNBmCeBxektW1/WLADNnF1MOggPYk
         LcCrEeoAULkBsnH9+jXkPCzNUOjPp9z++b2x6HfuTA1smENRMbdRCGhNhvXRpVxuRHaa
         aK/sBHnerdVR+9UdV+jc3xba2px7ipdWtBCKdUl6/+lf/MIUOZ5khRxVJcS91F003ZGf
         yYcgDzDlXxw6osBggE1O0qC84PuVwyN1yW7DtQEI512AD22R8M2Cd1Ka4ZQxKBX2ukHx
         zB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5J/jApywo57AJgkXgiYRA3/vk45uUXJMjdkrBsDWtHo=;
        b=c12qqKg5Fao9crIXG4yOjBeMc+ipgpoNyu60fuL8nx1Y1Vvpz6CTg2Tmzt/t6+eBLR
         uTU2ocD23TtYmIfeW4x7ptxAFvZ1JmtnaS3Kxdnc++unf0RguzZ9WGJbcvTsW7/YA84+
         4DQpChFyzFqyCKOikBpKxMLqm5zHVrNihv14zS93GP0qFhtSR6uDOdoWU7IjcD30lpJY
         4I86nf3OyB0oeDpxfGU9+JN261S24n79irl4b7zFj8UUWYsJYaWkf/sdT11CZcK39CyO
         I/l7EOBnz9JkjCgcPCO860ThdCpCCwlDaDv8tFj87ysbvg3ESHefHCZKWOeBaIC/u57y
         BfXA==
X-Gm-Message-State: APjAAAUtb4caUwZx3vLAtw0lao9DE+Pz6IxmPtwEcYK7o2K5lkQtvqKN
        /OxEsoy4ez22ka9QV72jtlNZzf9nY3YC0HRjCGYo+Q==
X-Google-Smtp-Source: APXvYqx4UaoiR3rTV0ChNTXzKl6YNAj4Ddy5F9qu6QkriFqbIeDh9SmcSa8nxqme2eEZXaL+zv1WmPTxJgKITUPN7OI=
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr883176ioh.70.1562023635297;
 Mon, 01 Jul 2019 16:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.254.v2.git.gitgitgadget@gmail.com> <pull.254.v3.git.gitgitgadget@gmail.com>
 <13b9e71b383485885c4823baa466c32511fd20bc.1561991348.git.gitgitgadget@gmail.com>
In-Reply-To: <13b9e71b383485885c4823baa466c32511fd20bc.1561991348.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 1 Jul 2019 16:27:01 -0700
Message-ID: <CAPUEspi_c9P=1LNEu2Oej3d5wcpYVVxys=aOT6Ow47vDY+0M8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] repo-settings: create core.featureAdoptionRate setting
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 1, 2019 at 8:32 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> To centralize these config options and properly set the defaults,
> create a repo_settings that contains chars for each config variable.
> Use -1 as "unset", with 0 for false and 1 for true.

minor nitpick that hopefully Junio can fix: s/chars/ints

> +* `gc.writeCommitGraph=true` eneables writing commit-graph files during

typo: s/eneables/enable

Carlo
