Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF43207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947282AbdDTUA7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:00:59 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36154 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031995AbdDTUAL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:00:11 -0400
Received: by mail-oi0-f50.google.com with SMTP id r203so65195963oib.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bUGmjvZg0XrKp+Yk2H68RLuhZAf0QwniXXP5d4Ngbic=;
        b=LqwTQQbR8Qw743R/x1c1fmAKcCE+Vt8u1bxtfr+jpIqEeYBgSFfzM+l2PQDj76hguE
         zON5ZXfUuz9c7K1vYIMsvaUhPYmMSKfzak4Bvl3zryKDINNGpDTekYNPlkuvLKzXzl27
         znYAcTgiLLkE+zzK1gklHRLKuj5fWyc+jzZFbLhmH8epXFNRh5h7Dprc/zhJBr6yErGY
         2J55SZVMAbs7gyCPkd+yNRODrv2rB4GFIPJ1IFLSYcrJbCYt1P0NnLdTt/OYje9NyoEK
         RhnQM2QfqQbu5wqywelzjCOVQV+yn1VRNWU1Rbx+1ZbNJ0vrNO6YeJGS5LHfR7pxnV2P
         v/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bUGmjvZg0XrKp+Yk2H68RLuhZAf0QwniXXP5d4Ngbic=;
        b=RyF3ZM4t1qeutJLsRi7gz2E8qc/65MvXGSQtU8w9J9vCuBR0OrkmwVQdCd2NHJ19sX
         bVpL6qQEw00YjgVeWCPRmindvGml0kpjM3TMc4z9RhNU/oS7HJS0UoHU7MjZ1sb5e63q
         6Em5mut9Ihri2v+zr2FWkIjasnt5rCMY3yPKQ2RgIAeuDi3LXAaQLr+pyXVduOCLTZqU
         Iw29ytvRqvLYJEZhgqYQSrPMqZQ2DQGoDjFzfUpIqTtRLtPbA0wuJK9J246jGV3lW76m
         xhGsGvMzIPweueWV11Pi758+6+j6PFoj1r10RNGYa14KpiD5zQdIeqQy10RVtWcgyowf
         vzqw==
X-Gm-Message-State: AN3rC/6X1KMvxB9gQ1nLignTjP6onLk3huCZY8bCH02ozMMVGEYlmdfr
        VJ5iE39XrvjESa0tXkELDDbIJ0yZdBFq
X-Received: by 10.99.44.140 with SMTP id s134mr9220005pgs.178.1492718409004;
 Thu, 20 Apr 2017 13:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 20 Apr 2017 13:00:08 -0700 (PDT)
In-Reply-To: <20170420194130.GF142567@google.com>
References: <20170418213725.7901-1-sbeller@google.com> <20170420194130.GF142567@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Apr 2017 13:00:08 -0700
Message-ID: <CAGZ79kZxfAJDQ96QngOCSp1q6kepgcByv7zSkRn_aFL3CLcznQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/4] recursive submodules: git-reset!
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 12:41 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/18, Stefan Beller wrote:
>> v2:
>> * improved commit message to be proper English (Thanks, Philip!)
>> * clarified why the patch 2 is so short (i.e. it doesn't matter if the submodule
>>   is initialized in the preparation repo, we care about the actual testing repo!
>>   Thanks, Brandon)
>
> That was the only thing I was unsure about in v1. v2 lgtm.

Thanks for the review.

Well the last commit still needs a better commit message as Junio
pointed out, so might just resend the last patch with better wording.
