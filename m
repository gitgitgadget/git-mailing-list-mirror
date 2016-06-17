Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A485920179
	for <e@80x24.org>; Fri, 17 Jun 2016 13:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbcFQNZY (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 09:25:24 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33542 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbcFQNZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 09:25:23 -0400
Received: by mail-yw0-f175.google.com with SMTP id g20so71363006ywb.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 06:25:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qxArEwSuAFqCX5SjBil/qMJZVS6lHytfnAmb7n/hyBc=;
        b=ZILQAhedAcEhu/+U1bWfXAZJjScUMRe52H/gwR/EqsiGRMok6xUQgxWhuGFqqYliJ9
         f1y0+mDcs6vS1ffAOxTexo/GsKfjMO/11ZGtdnja+t++jNphS9TIHNvMoquNjFVD0+Jx
         oDe5eXVHIqbxxCnxi85tLrZZNFYzUXfP7MsT5r7ZLKsmAAMCv5ThFtPe708tUPzbg1fS
         x37MMp4zSzJI+KvkrMVtStL6+xSMz+3cNAQj4RG17i/6Q5IMFG+xfc2LmRz1RmQsEfht
         MQwGme7i03EFJj651POYMQrm23WGmYEccMtTkiFWHFylNH2gOPURPlGF8h7d1TxQzHTy
         SO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qxArEwSuAFqCX5SjBil/qMJZVS6lHytfnAmb7n/hyBc=;
        b=ZLs7fWQEwNp6yETtlCz1FqDUIsanMSuDD5uSU0MQNfA7YTD/NMHlh5Hillm0Naw7wI
         C3bNpMavuAdnrXYf1OYDtMtgV4r9XXSMt6HoENW3jf+USmIYtH49Iy7yQnSxAC6qlUKw
         bFm33FJXcC/YicaKmDHsWmG7NjL3ztylJaksOu/KoYQh71uVmuzwrGqQB4/40b6MEgis
         BePLGqe7fkufzEyO4Ff6a1h6kYHg0YByZpPvPlEye0K5Ltx7C+hQKcK70E183VuQ3eoH
         LCMfRPMMfIUvpKoCmXfTVYJZRZT5lLvtCFUgdlTORNqNMMbEWPGNessYmklYDnUjOsFU
         DJaA==
X-Gm-Message-State: ALyK8tKdkmX3L9B4MecjTXpLoPWZJnIdE5VQtKUZUoDFlaN/1kuJouQCL7mbCcjHSX1aQc4mE7e6mrk2e44F7w==
X-Received: by 10.37.114.9 with SMTP id n9mr1089192ybc.80.1466169922841; Fri,
 17 Jun 2016 06:25:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Fri, 17 Jun 2016 06:25:22 -0700 (PDT)
In-Reply-To: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 18:55:22 +0530
Message-ID: <CAFZEwPO3VA0O-t4fL_tX68QibJF7KowzQuimTj0dbrQ6NX8yPA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Fri, Jun 17, 2016 at 8:50 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * pb/bisect (2016-05-24) 3 commits
>  - bisect--helper: `write_terms` shell function in C
>  - bisect: rewrite `check_term_format` shell function in C
>  - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>
>  Beginning of GSoC "git bisect" project.
>
>  I know another topic is getting rerolled many times on top of this;
>  are people happy with these three patches?  If so, will merge to
>  'next'.


This matches the last re-roll[1] I did which looks good to me. Thanks!
Though I was under the impression that the whole topic would be merged
to next after the completion of the GSoC project because the test
suite seems lacking at a few places (pointed out by Eric). So I had
intended to do the coverage tests after the completion so that I could
use the gcov rather than setting up a coverage tool for shell scripts.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/295518

Regards,
Pranit Bauva
