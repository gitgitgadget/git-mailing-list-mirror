Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857BAC6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 18:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiILSQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiILSQM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 14:16:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AAF1F2FB
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 11:16:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 8so3662101pga.8
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=xUql5TW6WxumQSlsd8Ovn6UBWu5EJnplCtI6h+rSA+Q=;
        b=EfoYA8IG+/kSaoYCVf4MlENhuLv29WT2UWaEjw4xn/vI9m/SqyaghhhZm+eRT4ul/Y
         /AeGIpWSKPm+nH6Pn6ejvuRKMgcOEpdc9rbn3unf2cXOS1ue459IUBMl7MiAm+QlBgIb
         MDTCpnjppp+VfR3OFob4+zK3CH50fh4DEbztwRtihTQ83FVIoNWG+9H9B6YGSnqn+wN5
         O5soWtvCEDZX0JNDMSWbRVtAZcBHbazuEp/9rIn7nP+n+IIpJWQSn++1cbzW+59r+NOt
         Z9S4do7Fnr3KdBd42eebukHnqh1bHKC7kO+syF7m/KNm50RT3Hl8axPGzJw3VtFLlBOi
         rkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=xUql5TW6WxumQSlsd8Ovn6UBWu5EJnplCtI6h+rSA+Q=;
        b=Zy3touPWXMP/3Lf0TID62H5HTvZ3zCQqGyqfOWN/2dxq1w/1wxV8lPNfwoXcnDWIBs
         Z09CvbKtWRE0N1CSSkmHYkzAclGIl3+S2h0Rizn4DKGPleyMnN7RcDh0K7QCpD7s/uYM
         mGEOqHVzKiK398iJbYVWQDcxYjgoh2KvTOdfJXMUtWWhZ+gxmHmOn4vWDZom4brsjXE8
         momRS3LBiaw4Svz8KHGyIVqgu5KzhbzsU0G3VOpr7lz+o2zY3EbdYUuT1q3PHDAoXyNR
         2p+AYxZ3mJAOKiWDj6JA2Nm3J3EyzrIE47mh9uOoBi0X0gKNjyOU5wGXenYP6QxcZ5RA
         nCdw==
X-Gm-Message-State: ACgBeo1ft89+9NwmuW5jgLtg7cqulvoQzUl63Dr+EP8FRtVLwXrjP2ys
        TSz5PisHmy1kOzP7xWshx+A=
X-Google-Smtp-Source: AA6agR7qWh1IU82DistVMDSnIwvVIm99tjaLd3c1szIxeEx2N+tlkuBwlp5+qN10s5k5bxCua/XxGA==
X-Received: by 2002:a63:e25:0:b0:41c:30f7:c39c with SMTP id d37-20020a630e25000000b0041c30f7c39cmr24243638pgl.147.1663006571205;
        Mon, 12 Sep 2022 11:16:11 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090abb0e00b00200b12f2bf3sm5470170pjr.51.2022.09.12.11.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:16:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation: fix various repeat word typos
References: <20220911102320.39954-1-jacob@initialcommit.io>
        <20220911102320.39954-2-jacob@initialcommit.io>
        <CAPig+cSsJ0-MOzwy1Nen7MA0nXYmdtD25k9D5KbezKEwrYTNig@mail.gmail.com>
        <xmqq1qsgh8n0.fsf@gitster.g> <Yx9zLYf3AmkiVn3S.jacob@initialcommit.io>
Date:   Mon, 12 Sep 2022 11:16:10 -0700
In-Reply-To: <Yx9zLYf3AmkiVn3S.jacob@initialcommit.io> (Jacob Stopak's message
        of "Mon, 12 Sep 2022 10:58:05 -0700")
Message-ID: <xmqqa674fogl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Stopak <jacob@initialcommit.io> writes:

> On Mon, Sep 12, 2022 at 09:14:59AM -0700, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> 
>> > On Sun, Sep 11, 2022 at 6:26 AM Jacob Stopak <jacob@initialcommit.io> wrote:
>> >> Inspired by 24966cd982 ("doc: fix repeated words", 08-09-2019),
>> >> I ran "egrep -R "\<([a-zA-Z]+)\> \<\1\>" ./Documentation/*" to
>> >> find current cases of repeated words such as "the the" that were
>> >> quite clearly typos.
>> >>
>> >> There were many false positives reported, such as "really really"
>> >> or valid uses of "that that" which I left alone.
>> >>
>> >> Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
>> >> ---
>> >> diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
>> >> @@ -13,7 +13,7 @@ that appears to be "backwards" from what other project developers
>> >> -Suppose that that central repository has this history:
>> >> +Suppose that the central repository has this history:
>> >
>> > This looks like a legitimate "that that", but it also reads just as
>> > well with your change...
>> >
>> > The the rest rest of of the the patch patch looks looks fine fine.
>> 
>> Yup, that matches the result of my scanning, too.  Thanks for being
>> a careful reviewer.
>> 
>
> Thank you both! Should I submit a v2 patch to undo the change to
> "that that"? Or is it ok as is?

I've locally munged the patch to tweak that "that that" and
applied.  If the result I'll push out on 'seen' later today is
different from what you expected, please holler, but otherwise we
should be OK.

Thanks.
