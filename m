Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E0F1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeCESBV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:01:21 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:42724 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeCESBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:01:20 -0500
Received: by mail-pf0-f173.google.com with SMTP id a16so7524212pfn.9
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mVjnMKYBl464/JhaKDwq95yTdJGDDRpaS8W8WXvoloI=;
        b=p+PYNRyjsk6a1W4NzBzWYQwry2NKxL5xvtNBMVLVuLuF1x/HIUH0nX2R5OCeG684Bt
         2UxpSGMEtUqWAdqQF5yK4uZYTCBdH3WWSRv9uSQDL4fU9NIWckEc21sP4ZkLglGiB3pB
         muHHGH20L5FJryw3y0Gv2Z0nLiyRVWiEp2mdPxw/72DTSgenEIWG2MvQIFpq4hdXlpjT
         qkf6PP9SzXWzZhTe1oHKESXkVro5Z2ITHCIWq3eierAepQUQjCW+4jdVtcJlv0vB04sA
         BBXjeIyuyWZJc/irimYRXK2v40q1gkFZE26aDbjXSg8hqwVz1+ZsspOrZoxy6YdN7brB
         ELwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mVjnMKYBl464/JhaKDwq95yTdJGDDRpaS8W8WXvoloI=;
        b=qcfWASMqQ32cZevjOcsfl6iIh9vvqakz5NStQguwzcILv66CufEtvkTGlj8RSnb8j9
         V0aRJhBDkFJszpii/wZf7peSuZjok+1v/302Uvemn79XQUmx8D16wn5d3695CTjWzwDW
         ZDKWg6CW2OA7pTF+glXtsDY+e6h7utB1naezGM3WBe43iYhQpvFD1sew2VdWPj4rx+eA
         lkDzvmCuElgLaxEezMjMAZRJ25g/VQkIMXvfm+HSv/ovJG6Tw7WI30QNjbAG4I93qPPd
         7o33DBPWpOSV7Mofn3ooev4FJSehVRVFL0oAqvbFZ6OE3H0cxL96i+Y2vS/CcF1KMSTk
         OYtg==
X-Gm-Message-State: APf1xPDXSXqxUX5w3Du2e8f3TkKXBza1XfGrHYdHfPF83cur6mL3JTbR
        vhDvCTOgrYWvIU13JvVLhrYLlPPi
X-Google-Smtp-Source: AG47ELv7LWD0pTojUMnNMb2MWNw3SMPm2sulVsGt2euUy1vjpUJ99mEmYA+3ojJ73txMpMsTkgFQzA==
X-Received: by 10.98.32.200 with SMTP id m69mr16124758pfj.82.1520272877678;
        Mon, 05 Mar 2018 10:01:17 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z6sm11536879pfe.187.2018.03.05.10.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:01:16 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:01:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
Message-ID: <20180305180109.GA28067@aiede.svl.corp.google.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
 <20180302044409.GC238112@aiede.svl.corp.google.com>
 <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180303182723.GA76934@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Johannes Schindelin wrote:
> On Sat, 3 Mar 2018, Jonathan Nieder wrote:

>> Hopefully the clarifications and suggestions higher in this message
>> help.  If they don't, then I'm nervous about our ability to understand
>> each other.
>
> Okay, let me state what I think the goal of this document should be:
>
> 	To help Windows-based developers who want to contribute their first
> 	patch to the Git project.
>
> Whatever makes it easier to contributors and is easily explained, should
> go in, in my opinion.
>
> Wishful thinking, and philosophical considerations, should probably stay
> out.

I think this conversation has gone way off the rails.

I certainly share some blame for that: in
https://public-inbox.org/git/20180303182723.GA76934@aiede.svl.corp.google.com/
I let my emotions get the better of me and let my bafflement show
instead of focusing on my gratitude for the context and clarifications
you were providing.  And I am grateful for those.

What went wrong is that I somehow turned it into a debate.  That's not
the point of a patch review.  After all, we have the same goals for
this document!  So I am happy to continue to work with Derrick Stolee
(and anyone else interested) on whatever improvements he would like to
pursue, but I am going to bow out of the arguing with you part, if
that's okay.

Jonathan
