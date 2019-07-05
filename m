Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7D61F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfGERBp (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:01:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfGERBo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:01:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so4547118pgb.9
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+JSRqGV+9pOFrlkFzkdUftp/i1hegj0WswPlREtBXCc=;
        b=JpfxkpAfZScJb6jXanNfglV4BCTQ+eWLPenQGQlrP0r92v9dcYw0zTY0gjS9SBaTAI
         jg3Z3PmcdG/QvYmEoJ7Z1ETVWESOJDyvDdudq9Yul/ds0EE2TD03bCkc9hLPTKi/NlRp
         AA9eLnW/gT0Ar5MMJT6wQdKbhpp4TqeuldsioPaxK/zyQ+2qwSXkW4V/jLY0rFMRxrra
         91GfXUYJ4A3cs/iGXQQ9JslmixjLjttAh0sxp9xDpvPJJW4MU7+a+evqPMFY0fvNbk4f
         u39Humgl3+hMP0wjNOWwvj0T62Y05mjIVftEl/Y3D493iTtRhxrkeOut+QR7qU7/MkFY
         JkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+JSRqGV+9pOFrlkFzkdUftp/i1hegj0WswPlREtBXCc=;
        b=oGIF7nIKW6ZyH4eUXR2cQ3nP1elSDvnYfBOpjYjatwhHkqjAsIT5Pvs83EKgUhJmxD
         C9ACzmUbnQ1MBAE9QbpVIzAOaU9TssE0gBwSSnmfw4x3uHQkUg2gsCfro35VF1hU750t
         FP9LPv9NhLim3xQeiJYrLbYP6CNkWrgBquxZWHBbW0zPRes7rZVXNT3inK9o30ory+Hg
         mBJMbUodVera8yPsPB7QqXIj3N5ZOHZXfOmPpX7zYyPcI5s5GmnjODH+jsQqkIqjIJT4
         GjLZALp7NGfSDvi67ca1rGYKAGmoKLJZcYZo4mf+EUlKydRHhx0yK6xjJEJcp5PLf2h4
         ovVg==
X-Gm-Message-State: APjAAAXrtjoLmtXW3dsjJx7DSzQaN1hfwrjydXqPa+G6quzhDZ4GD9qG
        WEm1Rl/W5CZYOOaEKaRtBz83rEW898ZhjQHDBkpe4b9u
X-Google-Smtp-Source: APXvYqw7Zftaya4BslJleX0Ika3Chi+/kfTklu9oc90fRI2MDsej7lb9h0gUS9Dvkc2+Cg2jrJp2+fvWlO0vwbHM+o0=
X-Received: by 2002:a17:90a:eb08:: with SMTP id j8mr6962899pjz.72.1562346104070;
 Fri, 05 Jul 2019 10:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190705165624.22243-1-eantoranz@gmail.com>
In-Reply-To: <20190705165624.22243-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Fri, 5 Jul 2019 11:01:33 -0600
Message-ID: <CAOc6etYRSRJm34X1=x7nh6PyhypF3nTvKSqzDhDCzOrNXyZkQw@mail.gmail.com>
Subject: Re: [RFC/PATCH v1] merge - make squash a 1-step operation
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 5, 2019 at 10:56 AM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> ---
>  builtin/merge.c | 63 +++++++++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>

This would be a first step in order to achieve the dream of having
rebase/squash in a single step. Let the flame-fest begin. I'm
wondering if it makes sense to support -m with squash or if we should
keep the default message with all the revisions that are being
squashed (perhaps erroring out if the user mixes --squash and -m, just
like mixing --squash and --no-ff)

Thanks in advance for your feedback.
