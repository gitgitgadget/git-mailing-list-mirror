Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F831F461
	for <e@80x24.org>; Wed, 26 Jun 2019 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZIWj (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 04:22:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43917 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZIWj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 04:22:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so1587098wru.10
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VVyQizAvGmRNfhPSeZsaUGuyVCqRFUYbjDuwkWfKT8U=;
        b=gDQvO0hRaGdwGZdaDE/BRT0iWQOaouA/s8TcmRp+FfHRSKrias59IUJK137ZO99qkB
         IOM/6WDk1qeepPlp8vxl2aguU0ZMyxuEnxi8aAPN4Z0FeuzTonB1qKPOzrXA2xlmF1Zd
         4dgAKw9xP7bBRdU3OoARhl5JbNff7jpkP8iwCSAbFyGgKQOwTVmHJmvKly/+bQWxy7es
         ar0eTKadQQlEa+KQWWivTciNvhp1BszJqfD6kBvqrwMCy4+Yl4rlSsimj6fpZ+RNJBs/
         jQTuB+ZWSCArwSNMrdwUWhPEV5+iVdDvKeRuDmXIlzqBY5bvuiatvMIEWBAHph349qqj
         mxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VVyQizAvGmRNfhPSeZsaUGuyVCqRFUYbjDuwkWfKT8U=;
        b=aZv9m3+OQAnkx8griZuMlBZpmQyKSMx+MjROUpDWPrv+mMJjh/oPayymV6QfVd40YQ
         V0RSl3Uf/7uYzvjOrkwyQl7dwM4H3czGHKldHIhnoC9KvJCdSpV50K1IiGPSEUrcL7k7
         IuADbxhMZjijrekuQbsMhZ6FmTEPw1h6m9ija498skdB6cGiAEWm4UIckJJt90/Gv8S/
         04NUHJOlcf/qyzIwgquePBKZ21PXAwA8U+MhJqWSx+YiDIf7H0HfyvL2UeaJ5INjDrq7
         wLAQR7tE9t0qRuK0O5xZpEjkWw7uMyAhvqGNpmR4Xu7ECwzVLYgcr3yzG7Mdb1Pb6GxS
         5SBQ==
X-Gm-Message-State: APjAAAXCB0HepDwa0Vq3bsRsSWQ3C7EAImGtGZRTEydBi9nB5DdCa0P0
        B97G+axqsbgaDKVitnxXJdQ=
X-Google-Smtp-Source: APXvYqwMUNmaT+d51CdGLxBC9kVkwQR5Wpz+mf8X7Xg8Rhkyl0tRHKjOLiS9N1SrpJdyMNhpSIrF5Q==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr2409531wrr.252.1561537357642;
        Wed, 26 Jun 2019 01:22:37 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id s188sm1549772wmf.40.2019.06.26.01.22.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 01:22:36 -0700 (PDT)
Date:   Wed, 26 Jun 2019 09:22:34 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Catalin Criste <cris_linu_w@yahoo.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: fix form -> from typo
Message-ID: <20190626082234.GC2423@hank.intra.tgummerer.com>
References: <0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com>
 <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/25, Martin Ågren wrote:
> Hi Catalin
> 
> Welcome to the list!
> 
> On Tue, 25 Jun 2019 at 09:43, Catalin Criste <cris_linu_w@yahoo.com> wrote:
> 
> > @@ -88,7 +88,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
> >
> >         This option is deprecated in favour of 'git stash push'.  It
> >         differs from "stash push" in that it cannot take pathspecs,
> > -       and any non-option arguments form the message.
> > +       and any non-option arguments from the message.
> 
> I think this is actually intended as "form". It took me a couple of
> readings, but what this paragraph wants to say is that any non-option
> arguments will be used to form (construct) the message.
> 
> Do you have any suggestions as to how this could be made clearer?
> There are at least two of us that have stumbled on this. :-)

Even though I originally wrote this I had to have a double take on it.
Maybe what you're saying above would be good?  "and any non-option
arguments are used to form the message" sounds a little clearer to
me.  Or maybe even use the word construct?  Dunno.
