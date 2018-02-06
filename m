Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36731F404
	for <e@80x24.org>; Tue,  6 Feb 2018 04:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBFEjf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 23:39:35 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40256 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFEjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 23:39:33 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so628052pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 20:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DYgaLtGt9Y+tNxus4GINl/swE/nkIjatew6X8LHJwWw=;
        b=aAslD8kc6j8K/qakSHlZWl4K1cUWJpn9MhxUmI+DmB3i1VMEFuP7aaZPiJtdLbwUJk
         M6Y4M/V8+WZxjDrmaLTuv06gAzRIhSxUSr3m7/s1H8o0xI/JuUpsDj+ZinLSLJHarmDC
         CiOi0bAurq0IwXIWnMYocTGnHVfSE2ORFEVw/8Oyv9Q+Cd0AUKDaJhNBe9VGvV8A45Au
         fV3fC30alwtu/NW9MRa3r85u0Ztqd0xVey4N2FWMqv/3IAREmjK9DrYyRkPnZ3H2RgrJ
         mjK+BfQjrw4MYzRxUnzZHoU0rvG8pTiptiuD0qpADO9Cc3yt5eNft6mNj5+N/0DybEqx
         pyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYgaLtGt9Y+tNxus4GINl/swE/nkIjatew6X8LHJwWw=;
        b=Jx3OJgNRQw0RH6WFWRq9Aben+/wYuj/RT404285i1nXQ88iKwForKCJw/Dg8DXnG9C
         b8AHqD4Vv2oanh8q5AU62X4AFHPEqXSZyLgMM8ViYiothxURuyP8er33v7guGTyKJBKA
         M/KR4mziQyN9ZBhtCtpMP9bmuIBN750VdOVhLCrJXGr2UpDf7eEloTLMJu6tJmY3vgaD
         EiblSZVXEAMiJRgPzOnDnRj6mRgFmLc3L/ZsHqgCcZfG2JBsdlBPjOO+lwFC42MznPiV
         dae/+1TbJQt1rclvpeX4ET+dhYfOVr4odHmRdVrpC0SKomT1vPNn9vwTejAz5gSkC3pz
         hOng==
X-Gm-Message-State: APf1xPCXgCRAuBAiAWwdsKOFO1ILWRtIwFZgeRdx7AHLhe+RpZbVsuX/
        4KcVA9DkvafphcaW9Tt7NxM=
X-Google-Smtp-Source: AH8x227J2QARWJY45SctnyVUzGeMcCy5KHcTfJVuCVYomMHezKVQ0Y6HqG1/U5gRFBWU+y/tDZQQ5Q==
X-Received: by 10.101.86.15 with SMTP id l15mr957498pgs.340.1517891972960;
        Mon, 05 Feb 2018 20:39:32 -0800 (PST)
Received: from localhost ([139.199.219.104])
        by smtp.gmail.com with ESMTPSA id d64sm18912719pfa.91.2018.02.05.20.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 20:39:32 -0800 (PST)
Date:   Tue, 6 Feb 2018 12:37:23 +0800
From:   Chen Jingpiao <chenjingpiao@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v2] commit: add a commit.signOff config variable
Message-ID: <20180206043723.GB30460@localhost>
References: <20180205104059.4759-1-chenjingpiao@gmail.com>
 <xmqq4lmvb5sz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lmvb5sz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05 11:22, Junio C Hamano wrote:
> Chen Jingpiao <chenjingpiao@gmail.com> writes:
> 
> > Add the commit.signOff configuration variable to use the -s or --signoff
> > option of git commit by default.
> 
> This is a rather old topic.  Here is one from 2006:
> 
>     https://public-inbox.org/git/Pine.LNX.4.63.0611281426311.30004@wbgn013.biozentrum.uni-wuerzburg.de/
> 
> which was referred to in another discussion in late 2008:
> 
>     https://public-inbox.org/git/20081227070228.6117@nanako3.lavabit.com/
>     https://public-inbox.org/git/7vabaijvxl.fsf@gitster.siamese.dyndns.org/
> 
> I am not sure if the reasons why the last effort was retracted still
> apply to this round (the world certainly has changed in the past 10
> years); it would be good to explain why this time it is different
> ;-).
> 
> Assuming that the new configuration variable is a desirable thing to
> add, the change to the code looks OK.  Documentation updates may
> need more thought in the light of past discussions, though.
> 
> Thanks.

I agree with Johannes Schindelin once said "a signoff _has_ to be a
conscious act, or else  it will lose its meaning."
I think I shouldn't add this configuration variable. Thank you.

--
Chen Jingpiao
