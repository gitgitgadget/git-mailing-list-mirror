Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923771F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbcJEVuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:50:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32771 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbcJEVux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:50:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id p138so621593wmb.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=aH4hNDZkVW2quDAPa9Bk/yu03e+tfIfsPF31U6bNPH8=;
        b=uMQS/HTjBuJEagDFVb6gIS+n1oC0kFr1jH1PeWxZaNVIEV97PbyAvimwF5zpMe0+gJ
         ELL5/VJegHcdUMUegwwkK44YHIHzGuf9MaA1BlNnOOj2Trn4+We3FSfVYFrg06Mtsk3R
         bPQxrDnr43gtRGOQFD3gTfTaNHpH92jRDuTCax8CvC5VHtNX21fFgooTPBbILvSOX/wX
         9m16TsiIi4Thv1uzQ7rbmEP+hXOUumVtDCjP967kkp22IZGOr4a9VnJ9j2v3c/1w3jX4
         H5fL84aL1rbAWcw2Vte7EvCGcsoL/L1c8+EBy7Q8B67hpvs8ykm7Lt207OpA56yqPJZV
         tCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=aH4hNDZkVW2quDAPa9Bk/yu03e+tfIfsPF31U6bNPH8=;
        b=XVJO6HpDzfKkenOz46UHPAIFWw28mPDviMyxXu+WOFhUV6XuHnvfXqaUFBkoGhW+zC
         8D88gY1ifSkNnpG2YETVCbdlwiOZVFGbu7E4+EXm6WsE9teulAxZLbYjcibIoCmHH02Y
         QMLTROD6hc2fE0PlKEbfjYPjeNyEW0nzCFCeSKGPlvdUCTwMO4/t3BVpfo4USnbRvoQO
         OmlikDtnp+5HljYTq3E+qAp4qOzoa2nHGN9q7+0bL4S0i5jKSSBQX1V6ekWlumJGaH1c
         qf2l0oOI4s2RvXnjv8n4Bkh/tRc8sQECAlp33mCB/tAB1t75VaZRpmhiwuylXlxPanrv
         3HtQ==
X-Gm-Message-State: AA6/9Rm14jCWvJP4xaqD0dojFDqFaN1BpjLmziWb2fOSAtFNVrkWu9MKFgP6KdsvdkebbA==
X-Received: by 10.28.7.71 with SMTP id 68mr20110237wmh.38.1475704251195;
        Wed, 05 Oct 2016 14:50:51 -0700 (PDT)
Received: from [192.168.1.26] (epq191.neoplus.adsl.tpnet.pl. [83.20.58.191])
        by smtp.googlemail.com with ESMTPSA id jr3sm10955504wjb.13.2016.10.05.14.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 14:50:50 -0700 (PDT)
Subject: Re: [PATCH v3 00/14] Mark strings in Perl scripts for translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <44a32c9e-55dd-e4ce-a5da-b16660edd587@gmail.com>
Date:   Wed, 5 Oct 2016 23:50:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 05.10.2016 o 19:20, Vasco Almeida pisze:
> Mark messages in some perl scripts for translation.
> 
> Thanks for the reviews of Junio Hamano and Jakub Narębski.  Although I think
> Jakub Narębski's suggestions are overall good, I am not willing to go that path
> because I cannot see huge benefits from them given what we already have and
> also I lack Perl skills.

All right.  While I think that Locale::TextDomain-like interpolation
in translated strings (__x, __xn / __nx, etc.), which is labelled as
'perl-brace-format' by gettext, is more Perl-ish and better for unbiased
translators, the printf based interpolation, labelled as ‘perl-format’
(and identical to 'c-format', I think), may be preferred in this case.

The 'perl-brace-format' doesn't need TRANSLATOR comments to explain
what placeholders are, and placeholders are easier to reorder.  On
the other hand translator needs to know to not translate contents
of placeholders.

  "This is the {color} {thing}.\n"

With 'perl-format' / 'c-format' the translator might need to know
how to change order of placeholders, but he or she should know
how to do it translating strings from C code.

  "This is the %s %s.\n"

Also, if Perl code shares translation strings with C code, as in
most cases here, then printf format is needed to do translation
only once.

tldr; I am reversing my opinion, and agree with your solution.

> 
> Interdiff bellow.

One thing I have noticed in the interdiff is using *translated*
strings in hash content (translation takes time, and might not
be necessary), that is:

   $hashref = {
	KEY => __('value'),
   }

   ... $hashref->{KEY} ...

instead of marking value for translation, and doing translation
only on print, when it is necessary

   $hashref = {
	KEY => N__('value'),
   }

   ... __($hashref->{KEY}) ...

> 
> Vasco Almeida (14):
[...]

I'll try to review those later.

Thank you for your work,
-- 
Jakub Narębski

