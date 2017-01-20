Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888241F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 11:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbdATLhn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 06:37:43 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34368 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdATLhm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 06:37:42 -0500
Received: by mail-lf0-f66.google.com with SMTP id q89so8319670lfi.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=041UopJki6A+BMwoo30vRI44kCdo105G05ezwPcHFQg=;
        b=SIUtduMizJO2KA+1+aD3/CNiQVmugiEfF6pVAKAIfqLgBGid5/boLvoqJsYftAwav1
         zhggks9KVV9mXmFoP2oEhHhg5OfbDfhoi30Quj0K4r3GkCsgKRWRU07oOQh47u75asJ4
         Rwhr2sBHDZnpnOoVyNYV8eMQjEH2GPBC49OgH1g27a3HWqgWmuodsudXzBvSxmeDp+2I
         T/fjBI1h486u0AfVar/GvrYgBqiwweCA489K5yqeGxF5Kd5Zv4YPWEqgKbff1DAY9Sey
         JhzzPGPLH7qDRljKIjFoL9BanSbhPtuZ+mkXinTPc4cvDnEUE5WKCmCvg09MJZxMel9B
         q9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=041UopJki6A+BMwoo30vRI44kCdo105G05ezwPcHFQg=;
        b=BmgpnS7fUZMGWP0MWGhnj76S+72YOXIkBpeLO4cUewmT4vAXZdCXNSZhGjRW30ERHm
         krztf7/U/5D71Z6kYBPeiZOdiaV1Sc/tVQnSGrty+ysNs/9BRiFHLNbYGcRKi1yMWig3
         dK6Y2s6VE2IOTMljTplwpGdXcOPdso3sK7LVIRzthBZgwMvbsyenAqHe5uKlQgMBzDX1
         aFi1tgdkz2N6dnXfrjpuwcRS+HEw2gGRHBoxnm4LdP3X1U4BHkRHq7qhfp9Pr9sWKZYx
         ViJ9i8eNKKCN+gDY8vsmdcD8ilimTlx0O8PYUtZov+gxdxRQpeap437J3b9sJmioub7z
         +pdA==
X-Gm-Message-State: AIkVDXJqMLxaYI/1Oa0Iv854dSt66U1S2EAicutn8Oa+hFsv5rmflBvaB3um2eNrXCr87Q==
X-Received: by 10.25.150.212 with SMTP id y203mr4714120lfd.179.1484912260126;
        Fri, 20 Jan 2017 03:37:40 -0800 (PST)
Received: from [192.168.1.26] (enm186.neoplus.adsl.tpnet.pl. [83.20.2.186])
        by smtp.googlemail.com with ESMTPSA id x78sm3298392lfb.44.2017.01.20.03.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 03:37:39 -0800 (PST)
Subject: Re: merge maintaining history
To:     Junio C Hamano <gitster@pobox.com>,
        "David J. Bakeman" <nakuru@comcast.net>
References: <58798686.5050401@comcast.net>
 <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
 <5880BB23.8030702@comcast.net> <xmqq37gezpz8.fsf@gitster.mtv.corp.google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <38ca43cb-2fc7-0448-352f-7d9413f815c5@gmail.com>
Date:   Fri, 20 Jan 2017 12:37:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq37gezpz8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 19.01.2017 o 22:42, Junio C Hamano pisze:
> "David J. Bakeman" <nakuru@comcast.net> writes:
 
[...]
>> Thanks I think that's close but it's a little more complicated I think
>> :<(  I don't know if this diagram will work but lets try.
>>
>> original A->B->C->D->E->F
>>              \
>> first branch  b->c->d->e
>>
>> new repo e->f->g->h
>>
>> Now I need to merge h to F without loosing b through h hopefully.  Yes e
>> was never merged back to the original repo and it's essentially gone now
>> so I can't just merge to F or can I?
> 
> With the picture, I think you mean 'b' is forked from 'B' and the
> first branch built 3 more commits on top, leading to 'e'.
> 
> You say "new repo" has 'e' thru 'h', and I take it to mean you
> started developing on top of the history that leads to 'e' you built
> in the first branch, and "new repo" has the resulting history that
> leads to 'h'.
> 
> Unless you did something exotic and non-standard, commit 'e' in "new
> repo" would be exactly the same as 'e' sitting on the tip of the
> "first branch", so the picture would be more like:
> 
>> original A->B->C->D->E->F
>>              \
>> first branch  b->c->d->e
>>                         \
>> new repo                 f->g->h
> 
> no?

On the other hand Git has you covered even if you did something 
non-standard, like starting new repo from the _state_ of 'e', that
is you have just copied files and created new repository, having
'e' (or actually 'e*') as an initial commit.

   original A<-B<-C<-D<-E<-F
                \
   first branch  b<-c<-d<-e

   new repo               e*<-f<-g<-h

Note that arrows are in reverse direction, as it is newer commit
pointing to its parents, not vice versa.

Assuming that you have everything in a single repository, by adding
both original and new repo as "remotes", you can use 'git replace'
command to replace 'e*' with 'e'.

   original A<-B<-C<-D<-E<-F
                \
   first branch  b<-c<-d<-e
                           \
   new repo                 \-f<-g<-h
   (with refs/replace)

>     Then merging 'h' into 'F' will pull everything you did since
> you diverged from the history that leads to 'F', resulting in a
> history of this shape:
> 
>> original A->B->C->D->E->F----------M
>>              \                    /
>> first branch  b->c->d->e         /
>>                         \       /
>> new repo                 f->g->h

Then you would have the above history in repositories that fetched
refs/replace/*, and the one below if replacement info is absent:

   original A<-B<-C<-D<-E<-F<-----------M
                \                      /
   first branch  b<-c<-d<-e           /
                                     /
   new repo               e*<-f->g->h

But as Junio said it is highly unlikely that you are in this situation.

HTH
-- 
Jakub Narębski

