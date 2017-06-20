Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4AFC1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 00:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbdFTAib (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 20:38:31 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36255 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbdFTAia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 20:38:30 -0400
Received: by mail-pf0-f178.google.com with SMTP id x63so61288408pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mH9wMdvgqlXJddmeS/745/kngcA3DYnpzsVOVHgvT7Y=;
        b=dQ1lzcmRbezjTiD3iWPIbWuHEZeAAqZMGu4E0oYiOtRDD5BDV+VIYSKGWA6T/5vzIH
         OLz0FhwvJgkbqp1IexlHNUU8GPBymM4Ai5Z2Zq6OXQalFiAA3i24FiGbv9AOu6kMDmuw
         sB03GntsTy6DgTpwL7toYIJRq44HTZIM4ijsjDPG/8DlDWLsufBFO1zpaYjsN0ufUSX5
         4ChDjAtPKbCM7WhG9o4CK9R6D7DAH1JkI04yNcrQy/J5rW2qtQjNUN5CwqRWOBBMQzh3
         IiVGQKD1w8Hp+l+jV0AyBxSBUHtr16tBt0y0pXA8wLCQPsiYZ/1xvJ5o3xasSmINEpCd
         lrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mH9wMdvgqlXJddmeS/745/kngcA3DYnpzsVOVHgvT7Y=;
        b=ates5jXiHY5Gl9UrcO3gztwB3iHk5MvN+3/NnXieMVNAuUXJdI/RxKsqCpDlS37zSf
         WEVBHBQhRrVBhsHDzsm/h8vxgC/SkX8aUw1JVWHhKcXMyPfq7JOlW0Umv8tqdpFAWGp6
         TAaeM0NeKoiB8eT9ODX4UFDKeQfw56hXL7lHs1Dd3/l0OGmXUwGcVlVM+2g/bIaRe+9k
         XG/fc92sFtO0rB2Jw6IOLrdO7x9wEvG4LOZvKeHRmJXBCMEpgbo02YN3cQ3qvgF6hzqC
         p0iNUflhUmJQZCS3GmFGwfeRyD+ggnPvQ66pq3buvOc0KHsB1kMrmstIHtquc8dfqSkR
         Pikg==
X-Gm-Message-State: AKS2vOxR5naq97yrTVFc8/+bDDsXcmYYBKgRFyKiUSgCp5WXkC8+IwKQ
        VyrNKQm8X5tv3uHFsLLNsA==
X-Received: by 10.84.229.5 with SMTP id b5mr5706593plk.164.1497919109549;
        Mon, 19 Jun 2017 17:38:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:a192:f5d5:865:c29d])
        by smtp.gmail.com with ESMTPSA id m11sm23234196pfg.85.2017.06.19.17.38.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 17:38:28 -0700 (PDT)
Date:   Mon, 19 Jun 2017 17:38:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC] Update: Week 5
Message-ID: <20170620003827.GB194323@google.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <CAH5451n4XDdeAz4T7aAsaSC00hnZ53Gb7j0CSiTg4QLUZKvxXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5451n4XDdeAz4T7aAsaSC00hnZ53Gb7j0CSiTg4QLUZKvxXw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Andrew Ardill wrote:
> On 20 June 2017 at 07:41, Prathamesh Chavan <pc44800@gmail.com> wrote:
> 
> >    But as communicating between child_process is still an issue
> >    and so there was no simple was to current carry out the
> >    porting. And hence, a hack was used instead. But after
> >    discussing it, instead using the repository-object patch
> >    series will help to resolve these issues in this situation.
> 
> Just wondering, does that mean that your patch series is dependent on
> the repository-object one? I saw some discussion around it recently
> but couldn't see it in the latest whats cooking so maybe I missed what
> has happened to it.
> 

Due to some of the discussion (and finding a bug with how git_path works
with worktrees) I decided to break the series up into smaller bits since
the original series was 30+ patches.  Once 'bw/config-h' and
'bw/ls-files-sans-the-index' have been merged into next I'll probably
send out v3 of the repository object series.

-- 
Brandon Williams
