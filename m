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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9759C1F4C1
	for <e@80x24.org>; Wed, 16 Oct 2019 19:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394526AbfJPThz (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:37:55 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52931 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394488AbfJPThy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:37:54 -0400
Received: by mail-pg1-f201.google.com with SMTP id e15so18388966pgh.19
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pezz8Q86pBVMciU8kdyVOKUWHszR6cCdB9hon1luNCk=;
        b=booRf3Bctawxm44IdjgZl9/2FLFbOleRdlHswwCqGFr7d20e3dlKcj+5L0tii368Q7
         bTwyZh3V3VWPewCf50UE55DUv2TtOS3rFknvHtWO3R+MH1GSZuMWkBGW6kmobDVW2hVE
         67ruPqquu9hVZ1xXu+8EdURDfdU9JnLy/YWGcUJH1RNo9HOvCwiGHe4NxpOWprHjJvUE
         MxrjK/n7tKHvhoT2xabriCDNgjq+AajMeuC0+5aqo5TiTS7zEmssTGEQZ5lpj9SAkNfT
         87g1UppyxuqVM+sCQ6WsaTmFHRnHzOE3fh2nFCPgE5GLu3z6YOksFhl+p/w7+VXGqQot
         JAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pezz8Q86pBVMciU8kdyVOKUWHszR6cCdB9hon1luNCk=;
        b=AzW7L7NbgodlrAMyIvWPlU4+Rtaz3l3Xq4DKk3rSHkgTqbpU2miQORtWMWkUEBaGG+
         uaulV+CNJclsBeH+mpK7JtjEHjG6SaAIa2CU2A0jSv/kHSIBuy6usnOSLGtreBIbzegh
         a2mwzD46uWQKPE/4Je81nmcTfk3lfVRDojZzZD4RnrNtKnjH9UalUurEZL7xdxI8XZmd
         PZKHVUJOR3eDY6LtdomotSrFOcJTDvd+rOG7PGjN8fXmln9oFFMkNDle7eGxGU58icg9
         /vDQyEyOevGdCsNJQj6u4JUEVYO7OOpQGHFEA1GB9n8WH6lc9hEPrUlSM4WtYks2cSbr
         8KoA==
X-Gm-Message-State: APjAAAUnfvbmkLF/C/HjKQ8Xp/Z4uN6GBa0ZKDy75BEI7vUrJGtjBZOo
        Du3ONzuwoiAOctcVE4c5l8F5TX4+HWjYBLmxGsJa
X-Google-Smtp-Source: APXvYqz1JIjDaYV1Aeb2oAmWA0gOlhPsbPGE/km8F/VwPrG58m3+4R502oTM9o/LEfnZcHRKK76HVqHIcdacOh0XPmR2
X-Received: by 2002:a63:2644:: with SMTP id m65mr45325817pgm.170.1571254673722;
 Wed, 16 Oct 2019 12:37:53 -0700 (PDT)
Date:   Wed, 16 Oct 2019 12:37:50 -0700
In-Reply-To: <20191016191012.ij3zbexu7pxupdho@yadavpratyush.com>
Message-Id: <20191016193750.258148-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191016191012.ij3zbexu7pxupdho@yadavpratyush.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [PATCH 1/1] builtin/blame.c: constants into bit shift format
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@yadavpratyush.com
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hariom18599@gmail.com,
        gitster@pobox.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There was some discussion recently about converting these related 
> #defines to enums [0]. We might consider doing that here.
> 
> If you read through that entire thread, you'd see that there were some 
> disagreements about whether using enums for sets of bits is a good idea 
> ([1] and [2]), but it is at least something worth considering while we 
> are on this topic.
> 
> FWIW, I think it is a good idea to use an enum here.

[snip]

> [0] https://public-inbox.org/git/20191010115230.10623-1-wambui.karugax@gmail.com/
> [1] https://public-inbox.org/git/20191014182754.82302-1-jonathantanmy@google.com/
> [2] https://public-inbox.org/git/xmqqk19ag60g.fsf@gitster-ct.c.googlers.com/

Thanks for the handy references. You know my opinion on bitflags as
enums from reading them, but I think that we have already had that
discussion and came to a conclusion. So don't use an enum here.

The patch itself looks good, and I also prefer the bit shift format over
octal.
