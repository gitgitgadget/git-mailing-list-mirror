Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29CE7207DF
	for <e@80x24.org>; Sat, 17 Sep 2016 00:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbcIQAbt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 20:31:49 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33823 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbcIQAbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 20:31:47 -0400
Received: by mail-pa0-f52.google.com with SMTP id wk8so30383915pab.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nU0xl0av7Jrco2aDba8jQ0hGR6zR+e52OprbmOjc1j0=;
        b=VpHAhVhMTThOcKzDHeQNlsswePeXV87jdmphJeMG8SDpwS2VxpygETLMrz+cTwhUwo
         tKYb10YzeL1LkjTNgCWx5RZ15bSreB1Rite8bCkQHwUr4u4y6Bn5kOTtbfpvXdBWlgEY
         y+ALv3CQ5pAyTVXPMPCjOaT9B54ooWSbDjEWAaiftPfwU+oULn9Dsu7/PH+x5EXzLBN9
         zLbIhNo25JeYJCxXBb2vLFyAiMvUp5UJ5B3umt3MHtCxmUzWsmGZ8RTKl4CqIJpW+FW0
         pk2bHio44lyAbSnLFNsAsoRIRtDV01zP+yjH9V4Fzj8MkMM3zOAXniGcTr7XJlTIPtmN
         TO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nU0xl0av7Jrco2aDba8jQ0hGR6zR+e52OprbmOjc1j0=;
        b=jrRAxWD3TXufg3hWvTd1L1BFzwjGLunN9NCq8/LuysypwVEGgWWyAGqbST3iJ/UtY7
         1Kb9y5aMifaDmB4yShZeuQwvmtnuBAeYwxDw4wTiPQM7JUgek9wlmcakvslNF8j7CtdL
         Qs0Vk3IN1fUm419JUtTkW4DIBhXLtEKyX4AXCcdD23DJVbDpwN+vuEP9a+tNcvhnzILW
         AXnhnILF3Qq7YSV/2EcgyMaAGvEU9ym7IFX7ozd0jXGDiogyr8etE9TWGpQ3mSSb9LZ2
         ST//LBel72sARVbIpwuWM9+0g7adwEY+KK3hMSZeu3Ip/TgoVzMIVmNDOdA1AX5QeZf5
         zzVg==
X-Gm-Message-State: AE9vXwObNLYZoQpNAUE8z0R3a0FWQ1bA6M40Xo87QL9NQ1fGA8Y/PGh+o1rSoiGuI5RfrD6k
X-Received: by 10.66.144.227 with SMTP id sp3mr26943111pab.131.1474072306639;
        Fri, 16 Sep 2016 17:31:46 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c82e:43dd:7495:3b10])
        by smtp.gmail.com with ESMTPSA id m65sm54646710pfg.79.2016.09.16.17.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2016 17:31:45 -0700 (PDT)
Subject: Re: [RFC/PATCH 2/3] mailinfo: correct malformed test example
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
 <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
 <cover.1474047135.git.jonathantanmy@google.com>
 <5dbb0b0f64906fd18c217908cd2c04e74d80fa68.1474047135.git.jonathantanmy@google.com>
 <xmqqk2ebk5zh.fsf@gitster.mtv.corp.google.com>
 <2bfc2fc7-f16b-6d51-7353-54d38353464a@google.com>
 <xmqqbmznihe0.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <3a27685f-a53b-03a7-93d5-0492638faf51@google.com>
Date:   Fri, 16 Sep 2016 17:31:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmznihe0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/16/2016 03:55 PM, Junio C Hamano wrote:
> Hmph, these:
>
>  t/t5100/info0008--no-inbody-headers  | 5 +++++
>  t/t5100/msg0008--no-inbody-headers   | 6 ++++++
>  t/t5100/msg0015--no-inbody-headers   | 1 +
>
> have --no-inbody-headers in their names; wouldn't that an indication
> that they are expected output when mailinfo is run while in-body
> header feature disabled?

Yes, that's correct (they are the test data for when the in-body header 
feature is disabled).

> I would have expected that it would make more sense to make no
> change to sample.mbox and have updated expectation to outputs in the
> case where in-body header feature is enabled.

The sample.mbox file contains the following:

   From nobody Mon Sep 17 00:00:00 2001
   From: A U Thor <a.u.thor@example.com>
   Subject: check bogus body header (from)
   Date: Fri, 9 Jun 2006 00:44:16 -0700

   From: bogosity
     - a list
     - of stuff

Unchanged, the subsequent patch would break this test because it would 
interpret that as a multi-line "From" in-body header when in-body 
headers are *not* disabled.

Besides changing sample.mbox, the other way to make sure that this test 
passes is to suppress the test when in-body headers are *not* disabled, 
but looking at t5100* (directory and script), it seemed more 
straightforward to modify sample.mbox.

The patch I sent added a blank line after "From: bogosity", but removing 
the spaces before "- a list" and "- of stuff" would work too.

> To make sure this new feature will not break in the future, we would
> want a brand new message with a folded in-body header added to the
> sample.mbox, and see how it is parsed by mailinfo with in-body
> header feature enabled (and disabled).

OK, I'll add this test. (The subsequent patch already has the brand new 
message, but not the test where in-body headers are disabled.)
