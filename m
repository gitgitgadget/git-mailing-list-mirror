Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E2E1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 05:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbfFJFae (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 01:30:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43389 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfFJFae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 01:30:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so3155094plb.10
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjpZYaTeyTNdDlEWwx1PHFC5wSsIiQY26RPXFc1dxRM=;
        b=UA5sDJA7yiPa3fjY47vyHsdNMbkAr12aUkYf6TE1B245+NtJeQqVCo0wayE9H3M3RM
         9g4cSZSVV6mktLNpbH/ctY+IF3ArBz8aDgb6umr6UtOe1xK/CwlYoTskqTGMoFjieTnf
         3b282F7YZLVcyOEWP3hTQM6IVDoUEaBJwiP0eMYPp//VQhxjDOp7a+3W+bx7lrspe8gP
         pt2iNYa79TSTq74VukgOppimceY/puO/0vkK5NSFbFaz592ywVfkQKzhy/WdbqKnPkUJ
         k4kOL3K6qfqWxVv+6op9UaWPjKeTk7LREyowXASF3T3/ar5ltM0tsmPdYumP8E742WQ2
         j/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjpZYaTeyTNdDlEWwx1PHFC5wSsIiQY26RPXFc1dxRM=;
        b=o+ZOf/T+cA07cGylXoMI9tMyXiv3ueK0UCP84qgO0UUhNE95hIeSNEjHUbhQA0LZov
         IvCEN2MghqZwcYbcHaErjX7UPxFjd9Ws4rTZ3zY8cIDanEjP8VCdmKBcFgugWMukFoIE
         ngKYvdxjRDXL/CnEh3Nb4kdFF3Dm/93YiNenwvJdAetE2UmRTaN7kZ9g3JHQkn+kMil5
         dL4jaaXvArs9uiGDOOQET/f9YsAJ8eSAl63JN3xxE33ETWmdqZ3W7OHe3mbF7cTxptoa
         Ua7nANWsjKY4+mhWxCX1u6783xAgBkjQ4lG8bvpSOOb7rYiq0G3M5yar2wnHrSR22P0T
         RXww==
X-Gm-Message-State: APjAAAVYmXLBJusCUeq7BvubDmCSVVjWbsYI7M22OnEexIyAukj765bL
        kxpoSl1HX63S1vOi4Xl+wCCkEdPmz7A=
X-Google-Smtp-Source: APXvYqz5jvIrGe/HgwCCc1stQJt8oEJcsB7yw5pLm20oMUTUpatE9zO8Fg09UM4EDbibFyum7ms1yg==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr68828053plb.221.1560144633433;
        Sun, 09 Jun 2019 22:30:33 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3108:4602:68f6:50e8:cfb8:76b6])
        by smtp.gmail.com with ESMTPSA id u1sm8543863pfh.85.2019.06.09.22.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 22:30:32 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 3/3] cherry-pick/revert: update hints
Date:   Mon, 10 Jun 2019 10:58:23 +0530
Message-Id: <20190610052823.17013-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <61a8bfde-018c-5a69-5abd-89d4a332e39e@gmail.com>
References: <61a8bfde-018c-5a69-5abd-89d4a332e39e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Phillip

On Sun, 9 Jun 2019 19:03:02 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
> Hi Rohit
> 
> On 08/06/2019 20:19, Rohit Ashiwal wrote:
> > [...]
> > @@ -2654,8 +2654,8 @@ static int create_seq_dir(void)
> >  {
> >  	if (file_exists(git_path_seq_dir())) {
> >  		error(_("a cherry-pick or revert is already in progress"));
> > -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> > -		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
> > +		advise(_("try \"git cherry-pick (--continue | --skip | --quit | --abort)\""));
> > +		advise(_("or  \"git revert (--continue | --skip | --quit | --abort)\""));
> 
> If the user has already committed the conflict resolution then we don't
> want to recommend --skip as there is nothing to skip.

I think it is more about suggesting what are all the possibilities
you can try and not about intelligently suggesting what you should
do. ofc, we can not use `revert --<option>` while cherry-picking.(
we should not be able to do so in ideal conditions, but the world
does not work as we think it should). Still we are suggesting so
here.

Also, I think it is more reasonable to make "this" a part of patch
which will cover "tailored" advice messages which is also a topic
of discussion as I described here[1].

> Best Wishes
> 
> Phillip

Thanks
Rohit

[1]: https://public-inbox.org/git/20190609200038.GD28007@hank.intra.tgummerer.com/T/#mbb071f6e29c69f291ecd9c61c71b889774ff33b2

