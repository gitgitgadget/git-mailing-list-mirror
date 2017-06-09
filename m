Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DE81F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdFIRED (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 13:04:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33608 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdFIREC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 13:04:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so9145269pfe.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IDkr4et95ZqCcfBtxFzMC90NKbrsR6qqmbYCc23WIos=;
        b=BEGmpSSAxl0wqEd3kfs8F8gwwlnLHyBbvaMG8Iwj6Scj7D5l/yNpgyLz8k2YrEc6iS
         2ahyBflKyUKGyTa6Gj72GhWdWilUylXEwVlMRqVRIV8BGgP4FYmaKUBqYN9k0I35pLVW
         UshYcN79YrGwy/pKM5lHXTthGDh7ZUgKS60VZZZECuQJqZH4XwaXbeSwHY8LM8FoOeNT
         c3UEFq2yPBf9ijAC67HbXtYugz/CvdIt9x720drbfIuxfucNBtQeEzPXyC8HdfXGqQg2
         KW9S0Wp+/rBteWyafg5wusjOJPh/JsNSlEJHWagi14BLs4XXW5rDiHaYDVEvNe1xA02r
         UQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IDkr4et95ZqCcfBtxFzMC90NKbrsR6qqmbYCc23WIos=;
        b=KwStMu4K2xGt03OONtTpMTFzseVxWXu2P70qBY+w7DBCFerXAG5s7KX01xdnFGTN4Z
         9NASuYxXZpRa7g+WMg0xZvWs0SipQ62D1YbNsLpiVyoktsyhNmQCy6YLTcD8eBFAw6Hh
         PbVMzFQcoIlyNHHZLw3JtgE0htiatluEdoSMbSzU/gXJ9RGhqoteG4HwSRG1uq//plYR
         5Q+vGaRaYU32TnRpgCHYOGmy6F+MDwmVF2HZt5wxstT8uOJi3GfkgC0VoqS+Rgk3Wqvi
         rkfIp3CIOiRw70Ux+iD4/L/Vf8lJM1eTlMVynrv5DW9an51tzaHpxI+DfEL+ciFFA2X/
         5F6g==
X-Gm-Message-State: AODbwcC+W3a55RzUMm58diCtRYIMVnuwtX0pof7XkXV+YXIB2jPEcLCs
        K2mdAiNJ3/g3Jg==
X-Received: by 10.101.77.14 with SMTP id i14mr19976366pgt.164.1497027841663;
        Fri, 09 Jun 2017 10:04:01 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8891:ea11:43cf:2c44])
        by smtp.gmail.com with ESMTPSA id t79sm3758236pfk.106.2017.06.09.10.03.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 10:04:00 -0700 (PDT)
Date:   Fri, 9 Jun 2017 10:03:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
Message-ID: <20170609170357.GE21733@aiede.mtv.corp.google.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170609142151.94811-1-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Some mostly nitpicky initial thoughts.  Thanks for writing this.

Lars Schneider wrote:

> Many open source projects use github.com for their contribution process.
> Although we mirror the Git core repository to github.com [1] we do not
> use any other github.com service. This is unknown/unexpected to a
> number of (potential) contributors and consequently they create Pull
> Requests against our mirror with their contributions. These Pull
> Requests become stall [2]. This is frustrating to them as they think we
> ignore them and it is also unsatisfactory for us as we miss potential
> code improvements and/or new contributors.

I think this description could be more focused.  It's also not
self-contained --- e.g. the link to stalled pull requests is likely to
become stale over time, especially if GitHub gives us a way to disable
pull requests for the repository some day.

Could you summarize for me the motivation behind this patch?  Is it to
make Git more approachable, to avoid frustrating contributors, etc?

[...]
> I am perfectly aware that adding a ".github" directory in the Git core
> tree is ugly. However, I believe the benefits ("well informed new
> contributors") outweigh the injury.
> 
> You can see how a github.com Pull Request creation window would like here:
> https://github.com/larsxschneider/git/compare/master...larsxschneider-patch-1?quick_pull=1
> 
> I added a link that jumps to a part my GitMerge 2017 talk which explains
> Git core contributions from my point view. Although I tried my best, the
> presentation is not perfect and might not reflect the view of the Git
> community. I wouldn't have a problem at all with removing the link.
> 
> I also did not break the lines in the .github/*.md files as I thought it
> renders nicer on the github.com web interface. I am happy to change that,
> too, though.

This discussion is much clearer to me than the commit message.

I've found that often happens to me when writing patches, too.
Sometimes after proofreading I completely replace the initial
description that I wrote at commit time with what I came up later and
was going to put after the three-dash delimiter.

Would putting a PULL_REQUEST_TEMPLATE and CONTRIBUTING in the
top-level directory work?  If I'm reading
https://help.github.com/articles/setting-guidelines-for-repository-contributors/#adding-a-contributing-file
correctly then it seems to say the ".github/" prefix is optional.

I also find the long source lines hard to read.  Can you say more
about how broken lines render in the github.com web interface?  I
would have expected github's markdown renderer to behave like others
and cope with line wrapping.

Thanks and hope that helps,
Jonathan
