Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575951F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 20:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfJKUFG (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:05:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54576 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfJKUFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 16:05:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so11575478wmp.4
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4wB9F6ocUNHFFV/0wU4Ofq049vvohNE+KoJyZJtpWs=;
        b=pmnuWJUM9lxJTDT21WVbnEy5qNuwNTIVRKKBR260tMmxDTW1Q2bXr6VjSjk96qIxgv
         QFDqSGjMtGwqE4oVRhIQs9vLTpQuT/CXHuXn5MbSxRWJsuXtqY2mQ8BuLw4RWWJAo7zJ
         PMTM4t7Do7GgszDvkdXwoZyxC1sE2cWyOm8M9pBXQBERiHYG7tN8EL/D85M5zAHyaB7j
         o5nH0chxBss30l7MIP0XzEtv+5dC0u2B5zzMxHd0wteswONn0lgpyck18xe2kCAI8Xx9
         Ep2ovDVROnDsvxgpupzl3oc3zkgC2LcOY1EliO6Fmtie5vvLFzTqa5a8YjNZs8+XKd+j
         tyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4wB9F6ocUNHFFV/0wU4Ofq049vvohNE+KoJyZJtpWs=;
        b=Q8f2OPeh+/DC7i3HoiiZFa3sOAVp8Ek4wF9NFTOCkfW+VAGIGx/TcYX9HSRoMiHDQE
         ECcQdr+PD1lDAV+bc/WB7udgnW+5fNVIuw6/E8TfkWr4XDyW9WcyrxxsRmEk2XWmQLS6
         Pw5jEDV05tLWqLxJ16cgglWTQBjF17GVg7UtKlQHzbKPGbpbBGPVgitC/UIKicAcPuZo
         FjGiXXufQiGTMM2VDtrrvls/JxQ459xetF37fNtJolM3guhKhW2U6C54OJQjyORi/x3j
         zQWJDe3UvAINdzxgxILZQKVdFG8K8y+tI+FHlMueJ+/0qc1JnrnRAa5WOQ4/KmsKvFUM
         HRTA==
X-Gm-Message-State: APjAAAU8EDfkDbCEZvSr/DzU9Qkp+ol8kVp1XfEfQpJVmK5lnSUhISic
        1+uexU/d6DK7GFeW3oST100=
X-Google-Smtp-Source: APXvYqxzi5iiwz4UmpeB59xUjzSQxZxsRjrW7bXM3jgURr9RdlVdFOUTD7/y3yH2TBScGRLk4/ewfA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr4436503wms.168.1570824303329;
        Fri, 11 Oct 2019 13:05:03 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id q15sm16366550wrg.65.2019.10.11.13.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 13:05:02 -0700 (PDT)
Date:   Fri, 11 Oct 2019 23:04:51 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
Message-ID: <20191011200451.GA25862@wambui>
Reply-To: 20191011184803.104907-1-jonathantanmy@google.com
References: <20191011085217.GA8481@wambui>
 <20191011184803.104907-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011184803.104907-1-jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 11:48:03AM -0700, Jonathan Tan wrote:
> > > Any reason why the names are renamed to omit "PICKAXE_"? In particular,
> > > these names are still global, so it is good to retain the extra context.
> > > 
> > > (This doesn't mean that you are wrong to remove them - I just gave my
> > > opinion, and a reason for my opinion. If you had a reason to remove
> > > them, you can mention that, and we can discuss this together. Or, if you
> > > read my reason and agree with it, you can say that and put the
> > > "PICKAXE_" back.)
> > > 
> > I wasn't really sure about omitting the "PICKAXE_" prefix, but I looked
> > at some of the other defined enums and it seemed like what would act as
> > the prefix in #defines was only used in the enum declaration. For
> > example I looked at:
> > 	enum apply_ws_error_action {
> > 		nowarn_ws_error,
> > 		warn_on_ws_error,
> > 		die_on_ws_error,
> > 		correct_ws_error
> > 	};
> > 
> > For comparison, I took "apply_" as the prefix that would translate to 
> > "#define APPLY_" which isn't included in the member variables.
> > I do agree about retaining the extra context though, so I can definitely put the
> > "PICKAXE_" back.
> 
> [snip]
> 
> > > In Git, we often look at historical commits, so it is good to keep
> > > history as clean as possible. In particular, we shouldn't move things
> > > around unless we have another reason to. Here, for example, you are
> > > moving the constants from above BLAME_DEFAULT_* to below. You should
> > > move them back. (Or if you have a reason for moving, mention that and we
> > > can discuss it.)
> > > 
> > I'll move them back. I have experience with all the "#define" constants
> > being immediately after the "#includes" which is why I moved them, but I'll
> > try to stick to the
> > convention from now on.
> 
> Thanks for providing your justifications.
> 
> > > Also, I have a slight preference for putting "= 02" on the BLAME_COPY
> > > line but that is not necessary.
> > > 
> > Noted.
> 
> Well, Junio provides a good reason for putting "= 02" [1], so please do
> that.
> 
> [1] https://public-inbox.org/git/xmqqsgnzj4vs.fsf@gitster-ct.c.googlers.com/

Yes, I'll include it in an updated patch
Thanks

wambui karuga
