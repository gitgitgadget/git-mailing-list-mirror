Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77BBF1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfBHKC2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:02:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35579 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBHKC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:02:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1481223plo.2
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 02:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L4HpES+3qAJ7uqb9mb6eMrXrC3kEgW5m5Engj/APWlk=;
        b=C+j8fFBMusHC7QxfQE1088cPW4IDss6MFyUESji+BNDICTZBwonzIZf1W2v2dFU/DO
         qSX5u2thnDcLWgEYUyEtptuHU82hjbj6Ml0+1sTZsnhpNQpnmyQbuYtFUAB0IfelFRPw
         A1Lnm4v1enlCDs+fUIDv0k+TSOzrN4tObUEICcheYtf5ZmUqsIxVI5RruYmM7uwm9CJT
         zKH5mrwcT0JVV3vlPi74aj801ArfmjHqN1EJQELIPEqGCagwP1tOLMPheC7ERijBPr4R
         VQJpSIRQb+nZZ3oRg5BriTFrpWWvLXQ98eHIvyAjOBL2Ca4gMAINs2BOhExSK8+/WAyO
         e+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L4HpES+3qAJ7uqb9mb6eMrXrC3kEgW5m5Engj/APWlk=;
        b=YHGs3X5P+qKEOq/MHsZFRlmy1FR8z9qIBLYKgvRFLfj66iF6X85MoMTFv3dICPO2uV
         rsS0BXP4QY6/x8/6Kye/vlUMxYmGzFSSlOh3DVASKCPdWwc5VvaPw/qp4qdKKNcPVmDN
         2VAMX3US5T4DsO+avMq7hK+LXDZMx18BrPCq/c1vHcZKWmxUsSt3facVdBPW0id4shQz
         GodFFJTIQuBmGd67vTQsHW5aFKwdwYO5vboZ6eqzURP9CGEUp4gV+ouekqHMV7ihsxK9
         TFUhf+/+kGNgyDmOiwS6zsyYeBrV6glfSDauYaqCEVYVpZQEq8g4nE1rubU/lWro6GMk
         ElQQ==
X-Gm-Message-State: AHQUAuYcCiEu1pF1AFyqIYXjlUvIaIXIz+3yjKJ14NXjOv9S/PpmLEwF
        7feG+fxh/Vzl3R9qp+tYvJE=
X-Google-Smtp-Source: AHgI3IbPYqNnV1Ul7x0qJSdWAI62FIiR5hzAuJN9Bq1bT9sh96nGYZ0qyFx9Qi4F5B20RfAThiNpJA==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr21267044pla.252.1549620147659;
        Fri, 08 Feb 2019 02:02:27 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id i8sm3699680pgo.19.2019.02.08.02.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:02:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 17:02:22 +0700
Date:   Fri, 8 Feb 2019 17:02:22 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: could not freshen shared index
 ..../sharedindex.0000000000000000000000000000000000000000'
Message-ID: <20190208100221.GA22283@ash>
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 10:25:25AM +0000, Luke Diamand wrote:
> I've recently started seeing a lot of this message when doing a rebase:
> 
>    warning: could not freshen shared index
> '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'

There are only two places in the code that could print this. The one
in read_index_from() can't happen unless is_null_oid() is broken (very
very unlikely).

The other one is in write_locked_index() which could happen in theory
but I don't understand how it got there. If you could build git, could
you try this patch and see if it helps?

-- 8< --
diff --git a/read-cache.c b/read-cache.c
index f68b367613..5ad71478dc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3165,6 +3165,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		fill_fsmonitor_bitmap(istate);
 
 	if (!si || alternate_index_output ||
+	    (si && is_null_oid(&si->base_oid)) ||
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			oidclr(&si->base_oid);
-- 8< --


> (There's a repo called dev_full, and I've got a worktree where I'm
> working on my 3rd attempt to make it work with gcc8).
> 
> That file doesn't actually exist but there are a bunch of
> sharedindex.XXX files in there with more convincing looking names.
> 
> 2.20.1.611.gfbb209baf1
--
Duy
