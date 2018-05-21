Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006651F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeEUROJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:14:09 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:42098 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbeEUROI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:14:08 -0400
Received: by mail-pf0-f175.google.com with SMTP id p14-v6so7391481pfh.9
        for <git@vger.kernel.org>; Mon, 21 May 2018 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mqv1JxRLjBizpykgzpW8dNcbV0f6onpKPFbNrUQ/er4=;
        b=rjditH2Nc+rQf7z5UuDbkAonsGilPuLLsUbaodq5/HSb3sfAIunG/KptynF++88CWj
         ZJNEJuhWiL9xCdBeZdjA6KdVZtjiepbqc537gM5FXXfLIGtpL1MlgOfaxxnx7K0EWI2T
         fu+3NQnXw7A9lF2Q4mlT6SHYvgkhg1D28fyOk9NwiTJIFPS7awsKscX0e5Yn1E+aTpDQ
         1Th+I+2YfDNg0MJaYld+BSd8EJ0MPgsqNg4kl9iWCszgkF+cUexjFJl1bokHegb+yXaz
         fJnAjvooE15Ed1W0nE+9XvA5BtEp6hgbwURVCzes4C0A29lyXd7FE40Qp1atYavFGfh7
         PKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mqv1JxRLjBizpykgzpW8dNcbV0f6onpKPFbNrUQ/er4=;
        b=slvG+kkHCT5TygRvWPSnZdBYgoiCOWqQFOL7Y3bgGyZaeq+YeXHm7J8pEBrfRLV5/O
         VImSESC+K9Hel2btgFQ2DQxMstDOvOdYzELoR+2pChdvuKWVISVzi7jwFU+ARjW5EADg
         Iv0qVjqyt1wtgvQbRsFHso1EC6HBN/5bAxc5qR8siZ2lmjhGx0xPA9+DhgDXIzi2PSxz
         +Cj2tdbxZjI/NDp7IBCyH9poKe0YWYqyEHDVOPHFtc8JaR7LfX6POUf4J+Kxz2ozT/PT
         NfX3RjP5jPh21k1eWsr8indigOCSEfoJCUC2xmH6HVGj6uELw69qq9J7DcfqwM4LFF5W
         L8cQ==
X-Gm-Message-State: ALKqPweHJqaU1+vdbMVi1lhbIQO/URfLP+f5Btab0zvRKlQcKPbCnISc
        77H5eIyN9GHmYmSmGKmfDLM=
X-Google-Smtp-Source: AB8JxZpChdnMJMJuFmXDofba6FI5mXIEQJBFP8x55cQc1Jj7XpeS/BsCDPVLoe6+wlESA6nF6eAX1Q==
X-Received: by 2002:a63:b107:: with SMTP id r7-v6mr8396592pgf.167.1526922847578;
        Mon, 21 May 2018 10:14:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b72-v6sm29297608pfm.69.2018.05.21.10.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 10:14:07 -0700 (PDT)
Date:   Mon, 21 May 2018 10:14:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: issues(?) installing git-lfs via fedora "dnf" command
Message-ID: <20180521171405.GB10623@aiede.svl.corp.google.com>
References: <alpine.LFD.2.21.1805210625410.6679@localhost.localdomain>
 <20180521170353.GA10623@aiede.svl.corp.google.com>
 <alpine.LFD.2.21.1805211303260.19892@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805211303260.19892@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:
> On Mon, 21 May 2018, Jonathan Nieder wrote:

>> The packager should be able to find out whether it's an issue in
>> git-lfs upstream and report it to that project if it is.  Git-lfs is
>> not part of git.git; it's a separate project:
>> https://github.com/git-lfs/git-lfs/blob/master/CONTRIBUTING.md
>> I believe they use github's issue tracker to track bugs.
>
>   it would *appear* that this is a combination of both a git issue,
> and a red hat packaging issue:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1580357
> https://github.com/git-lfs/git-lfs/issues/3013

Can you clarify?  Neither of those bugs points to a git issue if I
understand correctly.  They may be a git-lfs issue, though.

This kind of confusion is exactly why the Git project adopted a
trademark policy to prevent outside projects from identifying
themselves with Git: https://git-scm.com/about/trademark.
Unfortunately Git LFS's existence precedes that policy.  I believe
they got permission to continue using the name, confusing as it is.

Thanks,
Jonathan
