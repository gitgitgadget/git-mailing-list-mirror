Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8655A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeCPUwr (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:52:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44761 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:52:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id 9-v6so6594297ple.11
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CG+Umk0ddhCnlfEVNJpVAZjOuZSoEuaKr7PjUIQ3nY0=;
        b=Ib4XwFRzCscDuc3Nsl16ZhJ6Z9njQgREhQpcTUG4TQQAdXm1AN2QEAo/dPYUYLoDgA
         cp2RNMaE12CsfPeb+ITPvbxioZ1ECKjj5GWw0jGDtkIBr1YoFNsrE2dNWWRQgla4OQjm
         n2mCNmAazSqdaGepz219hcZ5VGTaGWI1DTEDtqlUY3VOJfLaeyypLakM5j67Qm6FPpTa
         p/zbW8B2gKMre1d4fP3V30eu43QXDEOZsyGJLvu58icTRhKif9dOcYCNDHKpPrnBIRVc
         H8b0k4FP8aBuPolUI4xhkdNWW/nFQyi4nmZWnXh1dZRxdpeO5Lde9V+YV9hsA8HlQjNf
         Vf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CG+Umk0ddhCnlfEVNJpVAZjOuZSoEuaKr7PjUIQ3nY0=;
        b=j4YxTXOsUZVFGfA1fsZMRDsmyuskHKtnTrPyBB59rsHJEMRhHjDO4BSu626uzYlTkP
         hpSa57WNzlKg+s0zy01jwuRJAyT/KI+V6wHz/7UmAyHS/BQxhPOzqNFFweMSqRO8RKdK
         WzUXZZ82dCYRj5UU24e1mjtLBfCEEYEoBevLxCmpFGBo+TQiHWXmVa6D6sFT/dtvx1uX
         6QG4nkHq0VHb+6br1I1AN7Ry1hX2e2uG4/o21lqDJ4PzYzLCY1irpJZjQFCXNPg0VmFy
         FjNaMOrJjJXWYDVqrAb5o0g+IOeqUC/6XugjBmpyikkPY7DMRfLZZaQ2eB2DyJOdJZYg
         x9vQ==
X-Gm-Message-State: AElRT7Hos5fsItaaHgTJx+vnOOANcTmjJvpIkzAah1ltDFUa2TTuXSbb
        9nQf7ZFZP3Q5snq4x5lOxXs=
X-Google-Smtp-Source: AG47ELvqx0SkcS/QvePLFYlqDiffVrMeUYYVkYQsllHRa2DCJmWHUtFR6Xs5nHnFP3nmI4/PPN4iBw==
X-Received: by 2002:a17:902:5066:: with SMTP id f35-v6mr3573683plh.14.1521233565436;
        Fri, 16 Mar 2018 13:52:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r1sm13459094pgq.41.2018.03.16.13.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:52:45 -0700 (PDT)
Date:   Fri, 16 Mar 2018 13:52:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Briggs, John" <JOHN.BRIGGS@aei.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
Subject: Re: getting fatal error trying to open git gui
Message-ID: <20180316205243.GB151588@aiede.svl.corp.google.com>
References: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316195756.GA151588@aiede.svl.corp.google.com>
 <CY4PR02MB2262A567EE2D2A54316BFE3FFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR02MB2262A567EE2D2A54316BFE3FFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Briggs, John wrote:
> Jonathan Nieder wrote:
>> Briggs, John wrote:

>>> I just installed git for windows 10 and am getting "git-gui: fatal
>>> error" "Cannot parse Git version string.
>>>
>>> When I execute "git version" in the command prompt I get Git version
>>> 2.16.2.windows.1
>>>
>>> Everything else seems to be working. How can I get the gui to work?
>>
>> That's strange indeed.  Why is Git capitalized when you run "git version"?
>
> Got it figured out. Git gui must be ran as administrator.

Hm, that leaves me even more mystified.

Before v1.7.4-rc0~155^2~4 (git-gui: generic version trimming,
2010-10-07), git-gui was not able to handle "git version" output like
"git version 2.16.2.windows.1", but since then, it should have been
able to cope fine with it.

I wonder: do you have multiple versions of git gui installed?

Thanks,
Jonathan
