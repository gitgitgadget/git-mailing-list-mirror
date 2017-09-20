Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D0020A29
	for <e@80x24.org>; Wed, 20 Sep 2017 18:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdITSr6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:47:58 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:49237 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdITSr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:47:57 -0400
Received: by mail-pf0-f180.google.com with SMTP id l188so1962041pfc.6
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmzAQDRQ23AiClfpWmEQYl8L6o4SC+hGfx6cg4w5skk=;
        b=uIU6haCv7IXMuGTsnp5RqbYhlHxEgJvUJJiOscMJw3T3QTLOeO/KU9yXDSDXW1v4ba
         fhf57otd2n8ozZ00z7cGe0OaurTThZegT/6cr3UHy3nugIBFJHqC+Dpm7M2w0BnmaMAV
         oUi2Ee6k/jZ8XCBkipbPVC7GZ2YdnkIr32L3N3tD1tMzaVQpP+YRAkowI+uvUr3q01eb
         fC13LMh75lx8r2PCtKDzLUqwjrZyU1VsCZj8ixrYoiXfsGTYM3+xCJfpLNuSHwWVEDWD
         ZDaDJ30UeHGMcYaV+eRIfqj5/azEWHdvmwzEj7WIAoZo1/ncqkDxeuB2I405Gc/cMM46
         sU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmzAQDRQ23AiClfpWmEQYl8L6o4SC+hGfx6cg4w5skk=;
        b=RGjqbQ7KaUAQFPmNKa5sF0uxSGLzwLas/O7vNZif3GYQIyrkHg4zHcUoljvWB/hj6w
         EBAke1njvWq5ta0fO6JLw18lJpqbuYOBPgtEC4im05qsqeN0MiIKN/jOPycT8aVhQ+HC
         R2SSVrv61qgZaijg0ZIknggMnXobDK/b0HBAcR6dIjxVCPpuWbO0UrTlDcV92ot0sYu5
         qUfnzYtysPdOdMf44ugKHDYDmv3ibHTNfHCeDUpjqxOIMnREg/4y4DeuMTSL0Eh7lgx/
         aWrfIRtIQAWUptWOX+Hr418+WudUWZvvyRGIvejo1A40EbxHw2PFeY+g8zCovSev1gf/
         RwOA==
X-Gm-Message-State: AHPjjUgd34WP8md7MvlF6Q0e6Lv8LD8JV9MZPr7rnoL7wtRlbY9ms2Or
        GQj1+rdRRZjxixRk8DFIc7I=
X-Google-Smtp-Source: AOwi7QA7MrVZwn8W9vuO+g/MXKVNIgxbLw/afa4mkMCrsXmwTRgzvOuI/P/X8xPFhdO4nxZxRXvG9g==
X-Received: by 10.84.252.144 with SMTP id y16mr3058853pll.113.1505933276838;
        Wed, 20 Sep 2017 11:47:56 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id w90sm9530954pfi.80.2017.09.20.11.47.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 11:47:55 -0700 (PDT)
Date:   Wed, 20 Sep 2017 11:47:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        kewillf@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add t/helper/test-write-cache to .gitignore
Message-ID: <20170920184753.GC27425@aiede.mtv.corp.google.com>
References: <20170828200618.27569-1-jonathantanmy@google.com>
 <20170828210939.GA71562@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828210939.GA71562@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 08/28, Jonathan Tan wrote:

>> This new binary was introduced in commit 3921a0b ("perf: add test for
>> writing the index", 2017-08-21), but a .gitignore entry was not added
>> for it. Add that entry.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>
> Looks good to me

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
as well.

I wonder if we can automate this a little.  Some thoughts:

 A. We could include a test that all the binaries named in
    TEST_PROGRAMS_NEED_X are also named in t/helper/.gitignore.  That
    way tests would fail if this ever falls out of date again.

 B. Even better would be if we could have /t/helper/test-* in
    .gitignore.  E.g. if we rename test-*.c to *.c (e.g.
    t/helper/ctype.c instead of t/helper/test-ctype.c), then the test
    helper source file names would be easier to type and maintaining
    this .gitignore would become a problem of the past.

What do you think?
Jonathan
