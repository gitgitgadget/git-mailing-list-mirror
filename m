Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163AF1F428
	for <e@80x24.org>; Sat, 16 Dec 2017 05:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbdLPFih (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 00:38:37 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:41351 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdLPFif (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 00:38:35 -0500
Received: by mail-it0-f44.google.com with SMTP id x28so23082477ita.0
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 21:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yg9a0jeZUaxLtM++C2doeyDavstj/Q7Y6Hdr/ogzlEg=;
        b=pJyiSsJqUMX8jwazPrqjV9p65X4rRxWgZwJzL313gHjs1zfa5JfKcWr+3evqm+gIgo
         PNnRjMVaxoR3WIj8eF1cD++ETAoBYETEHO5S5buF/O7cGfh5ezkuXbNqfgRhoP/iVOSM
         peizZeAIzcYnsKwrDOBFwxj76qqW+UpUIAaNd+rbfZdE69aIhNllh61D2AL2I/b8nA2L
         P8JvhMsk5OYUqw01AzQCIB4L/GFkI+3Uf/5C+2UAmdoAdrvUx2VMC2QX5QrCizZ5+Rt5
         uioJaxPfQen5qL7Mr1D+AiBDSNG2JMx8dCV7oPa8+OXq67RE3RiypTOn9AVhns8S6wB1
         hytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yg9a0jeZUaxLtM++C2doeyDavstj/Q7Y6Hdr/ogzlEg=;
        b=QbaFQXNaNs+8IF1Kbu3VLbxeIIIBT+o5ASQgW1v0/ll0gvWT5ImirQ8u2RVwk20jQR
         IVOH6zG9I1WmarOr6u8M6gZzymxLFAbn0EiZPntYX2XPF0hLlROJDI1oYs01ERehW8eM
         zniCvztEMvY/KgzI+Z1uLSFaU8H00OczH2eKq/XrxmZ/Pb4M51octDar46w89WYYzrC1
         HjrWwUWlJRCmFjNERA2gPQGxcRNf6z4xt4uqrtdH0o65hdjakJBLuArfALNgmZlK6JNT
         0TmDXhMz0sPJqawK5w8nVisje+nRHNcUw8AXKqEt+QpKh+PwEnfF2slGl7jFV6cvJ7rI
         5KSw==
X-Gm-Message-State: AKGB3mLnCRvFqnPotLbkThjR41+fY/nCIi3KqRJkPQ7Tz5gUL+vzvfNM
        fAc81qLBjJsEb/WygGzoqgrUlwKw
X-Google-Smtp-Source: ACJfBos6NazG0wpDxIz0hUuczvsFgj1wqN6o3hlgJVdaqa67j2+vBOCR+Roxyv4AH0d7yctUKa+ODA==
X-Received: by 10.36.71.83 with SMTP id t80mr10786883itb.48.1513402715095;
        Fri, 15 Dec 2017 21:38:35 -0800 (PST)
Received: from [10.4.2.238] ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id v62sm4238405iod.83.2017.12.15.21.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Dec 2017 21:38:34 -0800 (PST)
Subject: Re: [PATCH v4 2/2] Doc/check-ref-format: clarify information about
 @{-N} syntax
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <xmqq609olg1p.fsf@gitster.mtv.corp.google.com>
 <20171214123027.9105-1-kaartic.sivaraam@gmail.com>
 <xmqqa7ylur1i.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <641984aa-40b1-fde1-cafd-af109fa486bb@gmail.com>
Date:   Sat, 16 Dec 2017 11:08:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7ylur1i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 14 December 2017 11:32 PM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> Looks alright.
> 
> It was made unnecessarily harder to review because it was marked as
> 2/2, even though this no longer applies on top of the copy of 1/2
> that was merged some time ago.

Sorry about that but I don't remember doing anything that made it not to 
apply on top of 1/2. (I just amended my changes to my topic branch. It 
can be found at [1])


> I needed to find that it was rebased
> on top of 'master';

I don't remember doing any rebase on top of 'master'. My topic was (and 
still is) based on the 'master' when it was pointing at 89ea799ff (Sync 
with maint, 2017-11-15). Anyways, it's my mistake as I didn't specify 
the branch on which I based this. Sorry about that.


> 
> Also re-wrapping the lines only to squeeze in "but be cautious..."
> and replace s/branch/checkout/ in a few places did not help to make
> it easy to spot what's changed.
> 

I expected this would happen but I thought the line shouldn't grew too 
much so that they have to re-wrapped. Seems it would have been better if 
I did the re-wrapping as a follow-up commit (didn't strike me then).


> This part looked a bit strange.
> 
>> +it can be used as a valid branch name e.g. when creating a new branch
>> +(but be cautious when using the previous checkout syntax; it may refer
>> +to a detached HEAD state). The rule `git check-ref-format --branch
> 
> I think "e.g. when creating a new branch" is a parenthetical remark,
> so it should be inside parenthesis.

It was. I brought them out to introduce the parenthetical warning. I'll 
send a v5 by putting the remark back inside parantheses and bringing the 
warning out. If it's not ok, let me know. I'll also try to do the 
re-wrapping as a separate cleanup patch.


>  As the last three lines in the
> new text (quoted above) already warns that it may not be a branch name,
> I am not sure if the "but be cautious" adds much value, though.
> 

That warning was for the impatient readers, who might want to find quick 
answers as to why they saw an odd behaviour (check-ref-froamt --branch 
not failing for a commit object name) (or) those who would want to use 
'check-ref-format --branch' but do not find time to read the whole 
paragraph.
