Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FFC211B4
	for <e@80x24.org>; Sun,  2 Dec 2018 10:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbeLBKTU (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 05:19:20 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:53641 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBKTU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 05:19:20 -0500
Received: by mail-it1-f170.google.com with SMTP id g85so4948761ita.3
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38RGxb6j9vGEZqEeNL6zapg2OUgkReaXTh6zb5lqvWs=;
        b=DaXWso7pTYu49lMYglExTHzvvGOoa6oDpNjT08nAc2Z2REUoMcgI/1VNm2fvAXr0YI
         5iXCirTVrs8pvbDsyVKgjoGXBWVD9NK/XH77sl99cO1O+ywvdSnKhXuLSqsvkrwmsjHp
         iK2tqPNjODPpYsgYMltRLaSZkNAAr27KVTp4namA6s2aq60gPTKAOhYinrUnODXT24QU
         AMjw4tFG/XAjC1dZLVqopBFF8jeYLT2b1euFV9hnFwKcYvrLZa8IEbanJm6+jEm/NxG1
         88pcgty0FLT0rJ2rNf51nQMW5oICAMI6KAXRJANA0c52Caqy38zSJLrAaIda9OiYV886
         fm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38RGxb6j9vGEZqEeNL6zapg2OUgkReaXTh6zb5lqvWs=;
        b=N3M3WzyRAzvEmeJxXzZ8kQs4h+n0QdIAr7R7dtJvWpAUdxs7713spFfv3s3YoJXX/g
         HTNYdpLJ1QixV4+rE9O7fQFUSInq8NpRw3/Bd8qlUjsFxZ50L4zO/8rOj2Mx+pekGzNh
         55K9ShpwvrUdj/NHIB78fvj/UWeFqnSX73712Z8DMvYU+mgxX1QE+YBN67IDoNB6x7oZ
         8i5LYNLQUXWkyd2MsyqCfvJhX5c6UqRe8LK6buUeFJF6TcsHJjy3GEzxBxBzaDIM8Evd
         526qopNKM/ZKXd1dnG7XkcGs5lMEVa3+fzvusf4Jccrrp/j0CWg5mDYQTJ4VMW2z9VCm
         aHVA==
X-Gm-Message-State: AA+aEWZGZA68WCQ8QUFPQdSgU/wjkaitSKUYrRFepS1/n52uc4grzpMN
        NA2f+42LIT4zswQeTKSp0jNlVzaZQmEr+iIoSI4=
X-Google-Smtp-Source: AFSGD/VPswk859y7jwP1mDUpr0UxvDF6qUokGg84rKb0NuDmqhzF15GdWC2bH4kEb2lAutLIHsOffRbkoPML9epQL/E=
X-Received: by 2002:a24:f589:: with SMTP id k131mr3932285ith.10.1543745956052;
 Sun, 02 Dec 2018 02:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20181202100747.GA5019@laptop>
In-Reply-To: <20181202100747.GA5019@laptop>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 2 Dec 2018 11:18:49 +0100
Message-ID: <CACsJy8Ct3YY1TPD=pFoBGX-0woMNvM0JHYC1iRDGxWLJR51Esg@mail.gmail.com>
Subject: Re: Confusing inconsistent option syntax
To:     rjwhite2453@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 2, 2018 at 11:13 AM Robert White <rjwhite2453@gmail.com> wrote:
>
> `git log --pretty short` gives the error message "ambiguous argument
> 'short'". To get the expected result, you need to use `git log
> --pretty=short`. However, `git log --since yesterday` and `git log
> --since=yesterday` both work as expected.
>
> When is an = needed? What is the reason for these inconsistencies?

--pretty can take no arguments. --pretty alone is the same as
--pretty=medium. --since always needs an argument.
-- 
Duy
