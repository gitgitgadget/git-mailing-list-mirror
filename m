Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F6F1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 18:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfJKSsH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 14:48:07 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36072 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKSsH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 14:48:07 -0400
Received: by mail-pf1-f202.google.com with SMTP id 194so8163586pfu.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 11:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8nFuKfqgIXaliAhDWDZy80f5XgRD+N261+vFN9/FXCo=;
        b=niUAAaDy8t7K0nbmTg43ACj7DJk4o9hNMyr8dj6xCBIvlTq7uMKZW8nN743gYJAJuF
         PoDA2Ei2A0VR4uOlDY+wCkucgcm+8JzuDJ3w9V/uDdIem943F1VbYekuHpVwJxJvKxT+
         g8gO/6CtKI/vBdhMS3tnRxJ17rQxieRxAYYzSCMcUb4okzqzyIkodhzvi3co143Evu33
         d4zI3jPHmkS7SAfVn+phbE+BsLDEUhi2cgppK3GRGHZKmKdgglClf6hpllTWfurEgbH3
         +RnPuLm7cZJfxUDwfj2PpPDVrnV4OSrvC9IrV10AFdPbcaOjqTHieupFtPzotcDQ1hWv
         6z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8nFuKfqgIXaliAhDWDZy80f5XgRD+N261+vFN9/FXCo=;
        b=JEWFnUkwpamR3aWSfDDfYN/m9NOwUMhjmFUAt+fgM73IUUrhWr7yYACaSpjDe1ivjR
         rC/0JIPG0FRExcgoxEqkND4oHW3OKjZ+iKtsLTlD3mNSlPSEVj9r7OFBn/0958oCnvib
         PNQL9CxtpAaKTTCEnqikosWuaFoj50zFVmCT0ZORID0WJRd+85NERR5f+65PE8aq1VQY
         Cw1pcuXPB1gtfoQ/oaOPlpIeSTi024hKxXkJzhS1cXwPEddX0rvZ9epLJdMIGwckIpGV
         90cuYuF0ecUNho4IraNgpxfWO711csmfEPYCjQTUD4YD9o8hEKMDhbKnTvpBJo6t3/8F
         W+yg==
X-Gm-Message-State: APjAAAV9FsuWRj1Rw2kI/CC02p1gKXm7VKRTUfjN3iZalMglbKahdeYb
        u3dxhK2C1bh4JSI1urOuQYFtjCRK4+y0nH85hCli
X-Google-Smtp-Source: APXvYqxc6KJnJ1GPF6hJiIM2ISEiVeYag/9Xfwv7c5H5DSuOen/5dr8gB3Q3rsaw1RYQ2NvVFPreuPPICIxBXvupoMdF
X-Received: by 2002:a63:1c24:: with SMTP id c36mr18140858pgc.292.1570819686853;
 Fri, 11 Oct 2019 11:48:06 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:48:03 -0700
In-Reply-To: <20191011085217.GA8481@wambui>
Message-Id: <20191011184803.104907-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191011085217.GA8481@wambui>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
From:   Jonathan Tan <jonathantanmy@google.com>
To:     wambui.karugax@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Any reason why the names are renamed to omit "PICKAXE_"? In particular,
> > these names are still global, so it is good to retain the extra context.
> > 
> > (This doesn't mean that you are wrong to remove them - I just gave my
> > opinion, and a reason for my opinion. If you had a reason to remove
> > them, you can mention that, and we can discuss this together. Or, if you
> > read my reason and agree with it, you can say that and put the
> > "PICKAXE_" back.)
> > 
> I wasn't really sure about omitting the "PICKAXE_" prefix, but I looked
> at some of the other defined enums and it seemed like what would act as
> the prefix in #defines was only used in the enum declaration. For
> example I looked at:
> 	enum apply_ws_error_action {
> 		nowarn_ws_error,
> 		warn_on_ws_error,
> 		die_on_ws_error,
> 		correct_ws_error
> 	};
> 
> For comparison, I took "apply_" as the prefix that would translate to 
> "#define APPLY_" which isn't included in the member variables.
> I do agree about retaining the extra context though, so I can definitely put the
> "PICKAXE_" back.

[snip]

> > In Git, we often look at historical commits, so it is good to keep
> > history as clean as possible. In particular, we shouldn't move things
> > around unless we have another reason to. Here, for example, you are
> > moving the constants from above BLAME_DEFAULT_* to below. You should
> > move them back. (Or if you have a reason for moving, mention that and we
> > can discuss it.)
> > 
> I'll move them back. I have experience with all the "#define" constants
> being immediately after the "#includes" which is why I moved them, but I'll
> try to stick to the
> convention from now on.

Thanks for providing your justifications.

> > Also, I have a slight preference for putting "= 02" on the BLAME_COPY
> > line but that is not necessary.
> > 
> Noted.

Well, Junio provides a good reason for putting "= 02" [1], so please do
that.

[1] https://public-inbox.org/git/xmqqsgnzj4vs.fsf@gitster-ct.c.googlers.com/
