Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82987C6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiILR6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiILR6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 13:58:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983E2CDD9
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 10:58:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v4so8958379pgi.10
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qt6qsFl/230rZsV3GCBmZ2hwYffM/1qm3hOEIVb8i6Y=;
        b=KKfGWUE8/4N32xp/y+y4locSlhqHreBy6lzkvQY5+VZ1tLK7/s24iwKY68cy/Z/kC3
         dc+ti3FEPs0wcqF4tH0Nd6RbMwJIM8DwWF604OAb00lw4D4AvnagfjdlFLM4kMFhqVDS
         Wut3wlNOYEJr/PRagYyg2Dq42LFNyu/ACExG/1np0ZanykyVfVK7MrvG85oxsrRmnFeu
         3TdHZq+pV8BaoO2FcWKxFH22aTZqgSwE+WB0pacKWgMz9P0zRzh+ESjWu/FQqopc7VPo
         +nnfRiV8S4JTEGnEZZ8VX9MrjS2JY9uFQlacOj84Xfv87xfXRe1ZySGA6HgxoovVT7V9
         W/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qt6qsFl/230rZsV3GCBmZ2hwYffM/1qm3hOEIVb8i6Y=;
        b=mEpMWiIDLCFUIItd/GqP7/WSwtxIb8Bo3J7LtCow57cuOY7OiMPCyibw3vtpz87C2e
         OQ7mUwyvDVNFP2ARBgSr/v2G3ciblhS+PQGa2dsGXbxv4wX1MiggOfNI9xmpFtekchvz
         GjYrgWXzOR5thxuWmjC892v0GrJUd2cmFK/ptv0D60XfnBieIvCpYIDM6MtpwvU+q/pW
         bKel6yq/KnvmCjz09/jW2PD1lYlbTXzKoStrO5rtE8aaKpP5e4e5wWehQVRUR1Iuz+vk
         sd4FHI2frKXGPS951Zy4E/MwSgZvkGWiyXJM0dfXvbcK2wrAep7HtyglcO9j/M11TjFp
         RCLw==
X-Gm-Message-State: ACgBeo1nRNPNdkPnvN0E2nVylPOXLVCL40IXwQ2b0sCYRTUKCVmqlMl+
        hijphlXK9I2aXR+7fgv0fj1KwA==
X-Google-Smtp-Source: AA6agR5m0KhwYlxUtLwUGkWY73Nj76+4BmrWF+ugj4IuJ4Cw9xmW1/37uZDMrV4mCmbeRCUY/BFWOg==
X-Received: by 2002:a62:1c8f:0:b0:537:2284:bd00 with SMTP id c137-20020a621c8f000000b005372284bd00mr28771818pfc.78.1663005489684;
        Mon, 12 Sep 2022 10:58:09 -0700 (PDT)
Received: from initialcommit.io ([2600:8801:9c0a:f300:b5d1:79e9:801c:571f])
        by smtp.gmail.com with ESMTPSA id y6-20020aa793c6000000b00540d75197e5sm5889975pff.47.2022.09.12.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 10:58:09 -0700 (PDT)
Date:   Mon, 12 Sep 2022 10:58:05 -0700
From:   Jacob Stopak <jacob@initialcommit.io>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation: fix various repeat word typos
Message-ID: <Yx9zLYf3AmkiVn3S.jacob@initialcommit.io>
References: <20220911102320.39954-1-jacob@initialcommit.io>
 <20220911102320.39954-2-jacob@initialcommit.io>
 <CAPig+cSsJ0-MOzwy1Nen7MA0nXYmdtD25k9D5KbezKEwrYTNig@mail.gmail.com>
 <xmqq1qsgh8n0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qsgh8n0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 09:14:59AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Sun, Sep 11, 2022 at 6:26 AM Jacob Stopak <jacob@initialcommit.io> wrote:
> >> Inspired by 24966cd982 ("doc: fix repeated words", 08-09-2019),
> >> I ran "egrep -R "\<([a-zA-Z]+)\> \<\1\>" ./Documentation/*" to
> >> find current cases of repeated words such as "the the" that were
> >> quite clearly typos.
> >>
> >> There were many false positives reported, such as "really really"
> >> or valid uses of "that that" which I left alone.
> >>
> >> Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
> >> ---
> >> diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
> >> @@ -13,7 +13,7 @@ that appears to be "backwards" from what other project developers
> >> -Suppose that that central repository has this history:
> >> +Suppose that the central repository has this history:
> >
> > This looks like a legitimate "that that", but it also reads just as
> > well with your change...
> >
> > The the rest rest of of the the patch patch looks looks fine fine.
> 
> Yup, that matches the result of my scanning, too.  Thanks for being
> a careful reviewer.
> 

Thank you both! Should I submit a v2 patch to undo the change to
"that that"? Or is it ok as is?

Best,
Jack
