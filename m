Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9701F731
	for <e@80x24.org>; Tue,  6 Aug 2019 02:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfHFCQV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 22:16:21 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:40768 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbfHFCQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 22:16:21 -0400
Received: by mail-pg1-f177.google.com with SMTP id w10so40694073pgj.7
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 19:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Oiqr4fS5SJqK93vLiP2kReZaajT+mkehDIQS/8qrFCg=;
        b=n+kl3uE6nfzlpouD69y6kSw51re1PQkkdZnj4WzjBpZrbAik/roFU9VMXcnPFzn/qL
         +WUss2cloNDf29eSnsH2onvEeIwU6QVYBAiRYwEYEdkg17xt/ZY2CGy/7+63sQ36S/nQ
         WCt3XUM7dJ4XJVvXn9FvQyYSJLkK+Llr1+hn6hHidqYySamVLksrUfwCiz3HIkWO2MZe
         nGHaq0tz/XCE+5ulT77RW/McdCk8U5CWxYRD7cm0l7xXTy4mzVpsDI0rqkddJO1zDWX/
         mv1ZVN33Nqdj3oWXAgeeGjPPnlTltC5g2o5/IQYAwHisD2yZfCn++WFbsFVggFAbTwba
         z2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Oiqr4fS5SJqK93vLiP2kReZaajT+mkehDIQS/8qrFCg=;
        b=qDRmnryTHP1sHLyXTzc84AsjiPFugkJ3XqLosXdA+6Kjkg85gwmnuu4ObXh3vIFs73
         9GVB6cFOkKfypmHKJRr1fQfrFgx/ZRZWBLaqdLuRRgmHldd40R//uPNGWc3k7Zm9D2kk
         bzWu+8DuhW4qD2TDouO0wWZMf+jDHWNbqlz7NffKDX1/Qm2A8FiuSQX7TMdO7VUOu+1V
         PEvaCCWlAGEMtQpnkm5TckFDfiv3KI+HCPGdEwf4B1ncx9q5edkbtHeGrgjo1FrELHUc
         SCOCelyz/gwh3B83jJNKk9euy7a4aL+0fqytF+ovA9ot21a9pZSkGJO+/YMXi9mSlLK9
         YsEg==
X-Gm-Message-State: APjAAAWLrIbFUfNVvUzqMFbD4mtsCt91h2GFogjNo3W5Fo2XRmyaq1ph
        TvNbMoXvCPc8/JvvDVlXjqZ8JU75
X-Google-Smtp-Source: APXvYqwINJg8ZnojV16YBB3Tgyyt/cOnfou+DffirdAO08U4EuupsmyknBOXGyogFlAijh8oQK9EVA==
X-Received: by 2002:a62:e710:: with SMTP id s16mr1108164pfh.183.1565057780180;
        Mon, 05 Aug 2019 19:16:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id n89sm9445080pjc.0.2019.08.05.19.16.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 19:16:19 -0700 (PDT)
Date:   Mon, 5 Aug 2019 19:16:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lukas Gross <lukasgross@u.northwestern.edu>
Cc:     git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
Message-ID: <20190806021618.GC61803@google.com>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
 <20190806013030.GA61803@google.com>
 <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Gross wrote:

> I had intended to stage commits but forgot to do so. Git responded
> with a normal commit creation message, so I pushed to the remote to
> begin a CI build. When the build failed for the same reason, I
> realized I had forgotten to stage the changes. An additional line in
> the response to the effect of “Warning: did you mean to amend with no
> changes?” would be very helpful to shorten this feedback loop.

On second thought:

	$ git commit --amend --no-edit
	[detached HEAD 33a3db8805] Git 2.23-rc1
	 Author: Junio C Hamano <gitster@pobox.com>
	 Date: Fri Aug 2 13:12:24 2019 -0700
	 2 files changed, 2 insertions(+), 1 deletion(-)
	$

Some non-judgemental descriptive output like

	$ git commit --amend --no-edit
	No changes.
	$

would address this case, without bothering people who are doing it
intentionally.  So I think there's room for a simple improvement here.

Care to take a stab at it?  builtin/commit.c would be the place to
start.

Thanks and sorry for the roller-coaster,
Jonathan
