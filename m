Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7510F20986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbcJGS4V (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:56:21 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38844 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755265AbcJGS4T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:56:19 -0400
Received: by mail-wm0-f48.google.com with SMTP id i130so57947283wmg.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=s5+N4XCMtGHG1WMFDxZTsAiRw79BqSYWWY4eOM2RBNE=;
        b=JaI/pGSDnXGeI7jwXFNt3f94sMvkuxRI101+r/hzxROORYttowJcC7nlo+nJL370GT
         +yqvt3/zNw5uahor6qrmO8uV5sqb7WHNvr8N6lfmGcg8hE01ihabZj1b5UWFwpv2TeeZ
         Wa9eZ+j5aPQ653cbuhZWsz0u8K9OS2h6k6Ta+Gg01KwuAgGEykfyFt6Ger6hYfWOhd7Z
         gDii3T6sFwyTbDl5kauFX95td9jxdkns9Eeoyrg/lPiwBY/O2VU+j1VoZ6vQ7RuyugwM
         EQwuUG1VziBVHCfFdyd3LbSZX2YiwO1rOmF2W/+20Q3bDXbE9C5K2j5ptYCbQUyq0NgP
         xL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=s5+N4XCMtGHG1WMFDxZTsAiRw79BqSYWWY4eOM2RBNE=;
        b=kZCofQqcbjJEdCs5XyWdbCJAxGyIIM1sGN/b/pO+fePP4H4TcWQwHN7oq6Sm/kQ8D8
         M0dGIjQZFCdshGQxuCQXjgGTpc6p3A/phS7SraChQUvUKvy/b1xyRAZPTfxiXNUmO+R0
         CXJavoxfmefCnh6xjrkflt7i9GnfxvvNCIAD7XtwH+ED9gmchLmVeBKrzG55/f9KGt7v
         9ZKGA6YHCRhISuddhecMcrSmOYppoQAuGMrmXD+076JWyPwggz64zQHrN81rLy6xTT8J
         rSq0+7HAfw8bVCZ2QlwXdInQgF7nQEu7YYqTDMh7dSv4Mbxe/FAAsS5EYVSqVFBHg5G4
         3kxw==
X-Gm-Message-State: AA6/9Rk6jFFj5bK3d5tD9/VMBSTQO8bQ/ACTng1UKUmtZOk4MvnKqe7ePK7EPfd6+k99Mg==
X-Received: by 10.28.133.70 with SMTP id h67mr141082wmd.61.1475866578006;
        Fri, 07 Oct 2016 11:56:18 -0700 (PDT)
Received: from [192.168.1.26] (afc148.neoplus.adsl.tpnet.pl. [83.25.132.148])
        by smtp.googlemail.com with ESMTPSA id jt8sm16604272wjc.33.2016.10.07.11.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 11:56:17 -0700 (PDT)
Subject: Re: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research
 paper)
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
References: <20160930191413.002049b94b3908b15881b77f@domain007.com>
 <20161007205220.e7cc582a042f12cd13b6aef7@domain007.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4879aa41-e84f-634f-4c4a-1a16f5980e39@gmail.com>
Date:   Fri, 7 Oct 2016 20:56:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161007205220.e7cc582a042f12cd13b6aef7@domain007.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 07.10.2016 o 19:52, Konstantin Khomoutov pisze:
> On Fri, 30 Sep 2016 19:14:13 +0300
> Konstantin Khomoutov <kostix+git@007spb.ru> wrote:
> 
>> The "It Will Never Work in Theory" blog has just posted a summary of a
>> study which tried to identify shortcomings in the design of Git.
>>
>> In the hope it might be interesting, I post this summary here.
>> URL: http://neverworkintheory.org/2016/09/30/rethinking-git.html
> 
> I think it would be cool if someone among subscribers could post a link
> to our discussion thread [2] back onto that page.  Unfortunatrly that
> requires a Disqus login which I don't have, so may be someone in
> possession of such login could do that? ;-)
> 
> 2. https://public-inbox.org/git/ce42f934-4a94-fa29-cff0-5ebb0f004eb5@gmail.com/T/#e95875b7940512b432ab2e29b3dd50ca448df9720

Posted.  Thanks for the idea.

-- 
Jakub Narębski


