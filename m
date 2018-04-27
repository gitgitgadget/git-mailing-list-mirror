Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFAA1F404
	for <e@80x24.org>; Fri, 27 Apr 2018 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757539AbeD0HjM (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 03:39:12 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35375 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757444AbeD0HjL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 03:39:11 -0400
Received: by mail-qk0-f182.google.com with SMTP id b131so701043qkg.2
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/mC7s1N06WGif2+f2j99Yscdb4/FZCzStIhurehMJTE=;
        b=adkBmaXCPnAdmwjBjmyW/sbnCNA1QAqsyA0Z7iOv0s02jH1SrEznL4BUDB5j5s/3/z
         fjjaKXpXA5LPNtZ9SATuGDN2hQ1mF0+Ffp9JIs/u//JNT+nxUs0Q6c3Fo+X6B39sbl+w
         E1eAoryH2wBrtyKJoJrVqYexClG7M0N5+mlTEepZUMPD5DZzFErs6bq+w9SXKb55Knp9
         PsIAWIIkFgmzRrp3Dt3+gfH2A0YKzJb/PnnC/ylCQSxZ4Xyb0Ybz92rGEdvf3vULu0Lc
         mhYWI0ve8vvqp84FxgQpZJ1rxhAO8TYepw1ipi60sm4YlxAMbxpV1ZlvP2/aHaH6b73v
         LHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/mC7s1N06WGif2+f2j99Yscdb4/FZCzStIhurehMJTE=;
        b=qcBlQAqyilWnE7J0HfexS90Udeig4Qoh+OiAYgDEx9Ei9U3oH6nH2groI1DXAZ2KrX
         n3To9WmGkRK5yy8pXrfV5VSbbSHRHqBa17rx91SRPwuxxstJdZGFRovUEjx3MWcXZdZ4
         Zg3Zz3HZNHDfQy1daVqdfhTMTGRxVA/RsGlURAoKMJ7LQuy1gERWgD4u7Tx/stcx1JCi
         JaDWev7NxuTC7o5e4GSukNFo48pOpiw8NnMFq2pH0s0yZ1qFiBfJjXvK46JVXigXm56r
         ihh1IdJR+rIUTsujYRmPm/2rjl7UILVOJtVOmkOdvoosEP59nSTvMfqAw7Y7Lmewjlhe
         tniA==
X-Gm-Message-State: ALQs6tDvmNqotxZmVTBamBaRPhgkY3Q9uiDAxGRpE/asvxhqjfXsSYGt
        Gapx3Oi0nky0ftHdMomYpUO9+j+YKTz0iT21Saw=
X-Google-Smtp-Source: AB8JxZrKth1KmiVXBHAV2bn/sX1TFGI2+/7IEdvXwLuy5cJmzF79y60tmmuWWbIb/uxtbP3NutDeR5L+Jzw8Y9qGiQ0=
X-Received: by 10.55.111.6 with SMTP id k6mr232019qkc.145.1524814750707; Fri,
 27 Apr 2018 00:39:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 27 Apr 2018 00:39:10 -0700 (PDT)
In-Reply-To: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 03:39:10 -0400
X-Google-Sender-Auth: _3z7TgwtsZHq4Yz00DGUekeb4bk
Message-ID: <CAPig+cShfaKR_L+ypKwKZV_Hv8kwY37dGhJ8_WTSMZFqWX+EkA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * tg/worktree-add-existing-branch (2018-04-25) 4 commits
>  - worktree: teach "add" to check out existing branches
>  - worktree: factor out dwim_branch function
>  - worktree: improve message when creating a new worktree
>  - worktree: remove extra members from struct add_opts
>
>  "git worktree add" learned to check out an existing branch.
>
>  Is this ready for 'next'?

I just gave v9 (which you have queued) a final full review and found
it satisfactory (and gave my Reviewed-by:), so yes, it seems ready for
'next'.

Thanks.
