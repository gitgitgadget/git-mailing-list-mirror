Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAE820D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdFAXAG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:00:06 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33040 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAXAF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:00:05 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so39652143pfh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IuykJsNu3TLdnSS0EK7JyMUN83eNZuTk2CL5ZYe1v0c=;
        b=uQwZzmyR8HQsTEwTn13j3tgosp6Lq0wSZCW+DLBGWyVnfz+dTLDjamBdvzf238R0zJ
         Oku0EpQAVmm98b2DBRPADuqiH2Mb66AaG7XXHaMyExCfU3U7UxrV/hNGuSI5kHc81esl
         gU4yC7iznjzhudadGXRHJNZWXHR/Q6kNdTgcFAyYy0/m2spN+G52wdSF4EU/0wNGQAoy
         q8MTMEY0NT0ppdAZzMtex7qPFEKcI85e5OK12DysjEzF3HA8ldYUMYvU0RuNwdnBYvhh
         2y4CRseVwQPh+CNGHGZX1OFXYy+8d3kg4fUW4I9TfSHhZXSFYADNsOM1MF9gAGnB0Vn8
         GB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IuykJsNu3TLdnSS0EK7JyMUN83eNZuTk2CL5ZYe1v0c=;
        b=GJHIQr0as0Wz0TB+txxURgCH7tfjzqQwFBV5SxTuISEMCKPVaV6vpQ/0bAeAhcSLL7
         in1ugw7Fy4OqnCT2vXb6wkX6zl6p+s7osaUymTUmbaDF42/23k7S4M7Bac2+57XRaV5p
         cDe6FE3FDCYyvqEWnDLThdvBmQIjowX16yh7AwcFAPlbWop74bwvs6BfUIyVrB36BXHJ
         fuaxQ1QPQ1JGPgW0JCevG5APWe2oPW4sMiGSVbrocSVGWuYW9bMFM/6xMzx77pIf2DR2
         3JOZitB3kdGOc2QFxYxtbisE8dpKaMUrmqrDDj9EXFxWVbBfccJF33lM60R6kUnV8Cox
         x8NQ==
X-Gm-Message-State: AODbwcCg0ILLBvGiUd5KJJ/1XQlOEJd6SBpEo5MfKKIT+Jhep9CLEOQm
        2jLrZ+H3VKDuIExO
X-Received: by 10.98.12.142 with SMTP id 14mr3415012pfm.66.1496358004696;
        Thu, 01 Jun 2017 16:00:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:21ee:55f5:50a0:9409])
        by smtp.gmail.com with ESMTPSA id f86sm36278595pfj.128.2017.06.01.16.00.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 16:00:03 -0700 (PDT)
Date:   Thu, 1 Jun 2017 16:00:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, jonathantanmy@google.com
Subject: Re: git-send-email no longer works outside a repository?
Message-ID: <20170601230002.GB159608@google.com>
References: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/01, Jacob Keller wrote:
> I often use git-send-email in order to send patch files. Recently when
> I tried to do this outside a repository I got some cryptic failures,
> I'm using the master branch, git version 2.13.0.311.g0339965c70d6
> 
> I generate the patch files and copy them into a separate folder
> outside of the repository, and make sure everything looks good and
> write a cover letter, then I try to send them with
> 
> $git send-email --to=<address> 00*
> Can't call method "repo_path" on an undefined value at
> /home/jekeller/libexec/git-core/git-send-email line 1759.
> 
> Even weirder, if I move into the repository and try to send files
> which are outside, such as:
> 
> $git send-email --to=iwl<address> ../patches/00*
> fatal: /home/jekeller/git/patches/00*:
> '/home/jekeller/git/patches/00*' is outside repository
> format-patch -o /tmp/AZatqXB1uD /home/jekeller/git/patches/00*:
> command returned error: 128
> 
> I would expect that if you're outside a repository the command (as
> before) would alllow you to send files. It shouldn't strictly need to
> be inside a repository to function.
> 
> I found this first on pu, but as above, I checked out master and still
> seem to have the problem.
> 
> I'm working on a bisect now.
> 
> Thanks,
> Jake

This looks like it is due to '6489660b4
(origin/jt/send-email-validate-hook) send-email: support validate hook'.
It's trying to look for a hook in a non-existent repository.

-- 
Brandon Williams
