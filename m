Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37561F453
	for <e@80x24.org>; Fri, 26 Apr 2019 00:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDZAkg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 20:40:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34080 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfDZAkg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 20:40:36 -0400
Received: by mail-it1-f195.google.com with SMTP id z17so3292927itc.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 17:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+jR5sVBLHBNzGcPMvQmwtk/nzucZ/KD80n4VWhJn4s0=;
        b=IMmkwjrjSzKzkHz5vBIvuXm2ztWga+XYT7y+YXjqVV4eLIvrXad6PO4k+JJAHK9b4c
         oNq+N2e7AbYjDKXwjvpdeZ6CYtxuJQ5MKKe6w4g80i7/vfWFhd7XtKIdjP1VnYerMipI
         VJ50LS1ghWvXmqhXfB3oy6Cv2nk4Ok1vVlDz/dSNfcBrm4QAbeTnt/hBR5Z2Taw+cKs6
         tqsJ09WzN64ud/BQyN4BM3FUKTQbEmjS1EpGY56JKbFowSJeldAmg/0V3GXjc/b8iLhu
         UJ4Ynvjzh7viG9tK9BAXk9u5UQQN82Cq6+joe3b2HF93Pp92hevOK3VCeAT3gGARwJNO
         veIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jR5sVBLHBNzGcPMvQmwtk/nzucZ/KD80n4VWhJn4s0=;
        b=QlCMNp8sw5WpgjxU6aqqcXSIO4nU5xNqDhz+Lg3WnXP+XaUYEnzaG9KOZuZhy5E4EH
         66cSMJ4o77l9MBn+0UDQrV2bxYuNTuwzNkFLSYHuYf6vyTlAahvbL3NT6niLUq5RMMeC
         P0d4aPmpb0TuWK95HCaaWXWJEuZav+kFxPRPi9JkGvWWvFfR3tAVjd7vFIZ4D94m4nIR
         W7fOpnQpiUhTMI7SiJpu6frcZ1ixwvwotB2pNvWb/nPBWvDECXuAlzjpB4ossfV5NIRX
         s1zlW0x4+RaOzqWoSLzibMuiVdtpz0SjohAvAUnIXSnnJpa9JRjN/n4dc5Z3Cs9V4LqJ
         1UcQ==
X-Gm-Message-State: APjAAAVefAwjY8L0Q8kgEv5ukndDJHqwKHcwP+2OBTvQI3nx3oDmeiUa
        wDxiSH+9BQr1LgMVQHtkHj0og4bo
X-Google-Smtp-Source: APXvYqx1Cxr1vxBiAiEAuyqWKHyIWmuU1xXn7sryMLiWC32BgfdIAnMWPf7OGS1WqKgON9Z0NZXf6Q==
X-Received: by 2002:a24:b342:: with SMTP id z2mr2737525iti.121.1556239235127;
        Thu, 25 Apr 2019 17:40:35 -0700 (PDT)
Received: from dev-l (104-56-115-7.lightspeed.sntcca.sbcglobal.net. [104.56.115.7])
        by smtp.gmail.com with ESMTPSA id l20sm1842032ioh.83.2019.04.25.17.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 17:40:34 -0700 (PDT)
Date:   Thu, 25 Apr 2019 17:40:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t2018: cleanup in current test
Message-ID: <20190426004032.GA19743@dev-l>
References: <cover.1556226502.git.liu.denton@gmail.com>
 <c0c7171e3d523e5d4a0ac01810378447a38854da.1556226502.git.liu.denton@gmail.com>
 <CAPig+cTdJv9-M+zmp+Jo2bjOrkO3NgsguJ2xM+aXhf38OjjEEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTdJv9-M+zmp+Jo2bjOrkO3NgsguJ2xM+aXhf38OjjEEw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 06:34:07PM -0400, Eric Sunshine wrote:
> On Thu, Apr 25, 2019 at 5:10 PM Denton Liu <liu.denton@gmail.com> wrote:
> > Before, in t2018, if do_checkout failed to create `branch2`, the next
> > test-case would run `git branch -D branch2` but then fail because it was
> > expecting `branch2` to exist, even though it doesn't. As a result, an
> > early failure could cause a cascading failure of tests.
> >
> > Make test-case responsible for cleaning up their own branches so that
> > future tests can start with a sane environment.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> > @@ -60,38 +60,36 @@ test_expect_success 'setup' '
> >  test_expect_success 'checkout -b to a new branch, set to HEAD' '
> > +       test_when_finished test_might_fail git branch -D branch2 &&
> > +       test_when_finished git checkout branch1 &&
> 
> I'm aware that when-finished actions fire in reverse order but the
> inherent subtlety of ordering of these two invocations still caught me
> off-guard for a moment since they are reverse the order in which one
> logically thinks about the actions which need to be performed. I
> wonder if it would be easier to digest if written like this:
> 
>     test_when_finished '
>         git checkout branch1 &&
>         test_might_fail git branch -D branch2
>     ' &&
> 
> (Probably not worth a re-roll.)

This sounds like a good idea. If Junio doesn't get around to it, I'll
send a v1.5 of this patch later. Thanks for the suggestion!
