Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246021F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbcHXOjb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 10:39:31 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36169 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755988AbcHXOja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 10:39:30 -0400
Received: by mail-wm0-f48.google.com with SMTP id q128so204675856wma.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YsGw3pFqZnmIBOGPxaNFtc0j+dk2Lt5sD7T3EC25fG0=;
        b=TpX6nsSg065jDfBOKHhepKCD6L9f9+pBw3CA/go+xlfOgcIXEv67N3n4HROofa4yuV
         G8rQNNl/WFn6aiwh/beANJCLwF4hEAXHEQaBiKtsoCSsDCH8ipxsBtfPd1klStl3zYxh
         Cosa21fwCPcidCL7c4Rc0qZwh7WL4U9QvCaJFJMkqlYdUPlynR9px/X/7kMTEQWq/t0M
         iqigRtBWGuaYa/gZ49zZhb7zZTshkE6EAFEOvBqbSQO4VRhTkN1mx4g8HpmgZfYlI6ev
         tdSTK685Y3xsgrs7UVobEItd2O/xTOPa9m5K/cPJi4qT8Ob5/IsVRd0V9tmtv/HHn9GA
         b1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YsGw3pFqZnmIBOGPxaNFtc0j+dk2Lt5sD7T3EC25fG0=;
        b=YXZDZxxkWdFseWTesaFlWf0bK7kRWCviWwhLilVKvxPQ5GI9/MKNpT2+fs0hvM+1JP
         hhrlleRAVN7/6Wd5pq7Q3UpLdtY64b+MjerYBIJNTApmYFNhGjXy9meWeYTZwhxlziYG
         AUcrf1s8riqSzokPV1LJGkD3WzMHPvDBposaPg9iJTVydK0ZeQVdcGT7IrCTRI+yTAdm
         WRn6t828qAgfLrMWGPPG/nU14W9bmx85v92VDOPtVzEQa2qy4x1Y0VZLSrC4CTxEM19V
         u/QBbogmj9WePgYmHzyh1Wf+dAzd3E/ZcRtnoFZitA4nbztSY2QuNmr6ixkS6nzDYen9
         o+hg==
X-Gm-Message-State: AEkoouth7CqsQJydS/s+NIK3zHaQq0fRh6z4URiso2xX9zmL2g3W+8CZTwQkTVvsIFm1dg==
X-Received: by 10.28.134.203 with SMTP id i194mr24290233wmd.22.1472049569180;
        Wed, 24 Aug 2016 07:39:29 -0700 (PDT)
Received: from [192.168.1.26] (epy16.neoplus.adsl.tpnet.pl. [83.20.66.16])
        by smtp.googlemail.com with ESMTPSA id q65sm10928246wmd.24.2016.08.24.07.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 07:39:28 -0700 (PDT)
Subject: Re: Getting the "message" given a branch designation and conversely
To:     Jeff King <peff@peff.net>, norm@dad.org
References: <201608141458.u7EEwF8P099500@shell1.rawbw.com>
 <20160815122820.msajaamgmlexe2jd@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d75b165c-0b68-bd8e-31c0-cf7e704d6e61@gmail.com>
Date:   Wed, 24 Aug 2016 16:39:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160815122820.msajaamgmlexe2jd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 15.08.2016 o 14:28, Jeff King pisze:
> On Sun, Aug 14, 2016 at 07:58:14AM -0700, norm@dad.org wrote:
> 
>> I am learning how to use git. I would like to know how:
>>
>> Given a branch's designation, such as "master~4", how can I see the message I
>> furnished when I created the branch using "git commit"?
> 
> Somebody already pointed you at "git log", which is the right tool for
> looking at commit messages (or perhaps "git show" if you only want to
> see a single entry).

I think you would want "git log -1 master~4" or "git show master~4" to
see the commit message of a single commit (without diff).

>> Conversely, given the message I furnished to "git commit", when I created a
>> branch, how can I see the branch's designation?
> 
> Try "git log --grep=some.regex" to find a particular commit. Usually we
> refer to commits by their sha1 id, which will be shown by git-log.

There is also :/<search> and <rev>^{/<search>} syntax, if you want 
composability (see gitrevisions(7)).

> However, you can use git-describe to generate a name for any commit that
> is based on traversing from a tag. Try:
> 
>   git describe --contains --all <sha1>
> 
> for example. Using "--all" tells git to consider names based on branches
> as well as tags. Using "--contains" will generate a name based on
> traversing backwards from the tags and branches (like "master~4") rather
> than basing the name on a tag that you build off of.

The "git describe --contains" is interface to "git name-rev" plumbing

-- 
Jakub Narębski

