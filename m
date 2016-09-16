Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CDF207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 22:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756137AbcIPWmw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 18:42:52 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33367 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755331AbcIPWmv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 18:42:51 -0400
Received: by mail-pa0-f43.google.com with SMTP id cm16so29856411pac.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ue+snPD++iZr3XmcmnDQn63ong1VWz7yuxmGnobRgH4=;
        b=UrK9mYbhjJXqyBBRaVTzbTAD7/iPJNAfGDJVRVWseFbcatlTyIWqcxbmkbWL9n1NG8
         i02UI1W+Ia6tauTpr4fJwZRocUIYAoD1eOujXCYfW+OGk9q3ktBjkjcokAn96bbbpYoX
         JSxeGFnixbHc+SyFEVKZPcsTTaZuIuGqVJsYvsoJaTuu/N2QnQw9HeKJCSeofJin3uc0
         iugV6YDisraBfsvTp7+G/7YnqxQxPTzCg8rTNYlCkcXFtUxN+HLMIveWkla4TeRFTvHk
         R7EZFFwl50oZhVnC6N4SJ/SFHO2wFp1msirQ8mXX3hCY6FcX352XKxbPXdpVeNKsqeJt
         TTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ue+snPD++iZr3XmcmnDQn63ong1VWz7yuxmGnobRgH4=;
        b=RNa5g5xEovSiaJrCCspT1znZylR18GEGA0/dA9Qhw0t3XNmdUKP6QYOIwvyiqBI/Xv
         ooj+00RH59ANh/a0e+CjtBDBkHf2peo0yGTureRItcNwGJIQmd1sl8mQvfnJFB12eAJk
         G4V1DLOITq+6YwPkeiB+13DzrGFbpikiBGGR9Atq3MkHKhGPwa8S8woRM1CmkcMMd7B8
         bE0pkqnnyjVfiDmoxdLJmBN2gwvVr/pVzKqEryCoc/SpKx2I3oX8bz8d41kBviIdy0cX
         dq+r9+EhI67hdOb8K3h0wu2bti9Zzu2DXQzyNwawHpF9t3oCKnkhWtVVyGCkJXWhDebc
         2D/Q==
X-Gm-Message-State: AE9vXwNxFK84wzEFMTDuCwiDuTJuHQ9oggjux/Kh6BV58FkwkqKAILSqkt1up3Ff8UMOztrn
X-Received: by 10.66.26.207 with SMTP id n15mr26463173pag.69.1474065770136;
        Fri, 16 Sep 2016 15:42:50 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c82e:43dd:7495:3b10])
        by smtp.gmail.com with ESMTPSA id 70sm54450288pfw.92.2016.09.16.15.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2016 15:42:49 -0700 (PDT)
Subject: Re: [RFC/PATCH 2/3] mailinfo: correct malformed test example
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
 <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
 <cover.1474047135.git.jonathantanmy@google.com>
 <5dbb0b0f64906fd18c217908cd2c04e74d80fa68.1474047135.git.jonathantanmy@google.com>
 <xmqqk2ebk5zh.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <2bfc2fc7-f16b-6d51-7353-54d38353464a@google.com>
Date:   Fri, 16 Sep 2016 15:42:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2ebk5zh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/16/2016 12:19 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> An existing sample message (0015) in the tests for mailinfo contains an
>> indented line immediately after an in-body header (without any
>> intervening blank line).
>
> This comes from d25e5159 ("git am/mailinfo: Don't look at in-body
> headers when rebasing", 2009-11-20), where we want to make sure that
> a "From: bogosity" that isn't meant to be an in-body header is not
> identified as such, even when it is immediately followed by a
> non-blank line.  "From: bogosity" is for msg0015 but the same
> applies to the header-looking block for msg0008.
>
> Adding a blank line there will defeat the whole point of the test,
> which is to make sure we don't do anything funky when --no-inbody-headers
> is asked for, no?

Before I revise the patch set...I think that the point of 0015 would be 
handled by 0008 (after this patch is applied), but if you prefer that 
0015 retain its purpose, I can unindent the bullet list in 0015 instead 
of adding the extra line (and then dropping all 0008 changes). Would 
that be better? (0015 needs to be changed somehow, because its indented 
line would be interpreted as a continuation line after RFC/PATCH 3/3 is 
applied.)
