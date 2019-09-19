Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B43B1F464
	for <e@80x24.org>; Thu, 19 Sep 2019 19:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392347AbfISTdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 15:33:53 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45124 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389652AbfISTdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 15:33:53 -0400
Received: by mail-pg1-f171.google.com with SMTP id 4so2430844pgm.12
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FwfvKXWdQEvu8sa7HFuNdu9cH0YgsEDcnwMOdCIwP0w=;
        b=U9d5JsySQRMDhPcPBzFP7jDv8eILabL7m6rWTF7IwWZJ8Hu53RvjPmjJbeNvwL15on
         9SKLioL2MZkEZsnVKJt/3iO9xH5B/ua+o6p4mm+vIFhNu/+wmO3QdsOTN0iJk993uvI6
         9LO3N3w5xUO7K3YhSHP+Azwz+ZxGSHcmloa7cvnpwc79NNZ9KjFSWWSyLYWjjsCCrFsr
         DQ0VUOvRMggQuKQUAibEY14KW65JD8HHlycsxJQUtojSNnGj8AVA+vTq5yIDM3HpEadd
         6jItaFEZiV6LFMWoIBGoLFyLaKa3Gt/oT4qHUbruPM2OQamF5zmi1V9A9qO919ztI2vR
         HssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FwfvKXWdQEvu8sa7HFuNdu9cH0YgsEDcnwMOdCIwP0w=;
        b=rxtXlR3+S9VTeG2VkUgMTO7F71a2LTW/kwxP/PBxn7H4KZaP0L5YU6ZWCfohE4yWxb
         kqzTLzq8PoXNFfDLkTRzEK9mumu/c5pqkOx4+dZ/CsKJKmDsbZyi5JnL1XVMDB607ZRF
         1IAkVAnbOpCKg2SLXKHqn3FvxqFViF7puu+q9CgoLfJLNurc9QRbGbfSBeZjtnjL/3Ut
         Kfi7ipNLG+EeR/w8wh6PwFDaxrugiFiVIX3a+lO+v5BWJbtgwtObDj0lSbIvoiJpL1gI
         /1CNuZubnezZy+BmODMgdDIITIvgxiJlCpAIWPFS1cJJ8fVEG9eObR88OmPEFIbZRImL
         WcXg==
X-Gm-Message-State: APjAAAWfVd+K+Umg9K49iNnZIjzEkBVq/kMFdmzSYIBInCmJGUH8C3l6
        a+OY7M992u41GZKvAFLNOG0=
X-Google-Smtp-Source: APXvYqxIk01DE4D3QG4niTqj3n5pZi2+pgSvgeDnKBamANVL73ZBMBiLpQC+vhKOPG2cP8TtFLY+nA==
X-Received: by 2002:a62:2643:: with SMTP id m64mr12361628pfm.76.1568921632693;
        Thu, 19 Sep 2019 12:33:52 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id 37sm13827514pgv.32.2019.09.19.12.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:33:51 -0700 (PDT)
Date:   Thu, 19 Sep 2019 12:33:49 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190919193349.GA89519@dentonliu-ltm.internal.salesforce.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
 <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
 <20190919183258.g7ae4u5nzuzwgu7b@yadavpratyush.com>
 <20190919184708.GA83166@dentonliu-ltm.internal.salesforce.com>
 <20190919190359.cuvy5g3xangrkgim@yadavpratyush.com>
 <20190919191105.GA85790@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919191105.GA85790@dentonliu-ltm.internal.salesforce.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 12:11:05PM -0700, Denton Liu wrote:
> > > For the record, you could do a
> > > 
> > > 	git cherry-pick -Xsubtree=git-gui 00ddc9d13c 7560f547e6

I forgot one more thing, if you end up doing this, you should probably
sign-off on your cherry-picks by doing `-s`.
