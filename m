Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56116205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 09:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031929AbdAGJaT (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 04:30:19 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:34781 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941251AbdAGJaD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 04:30:03 -0500
Received: by mail-it0-f42.google.com with SMTP id x2so8469671itf.1
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 01:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sTMLSaazc/K4N+rqR/1atMAkBUL9y8o2wzuZyKKPW38=;
        b=oTBHEyZ4HzR+UhaSaar4FJtbcyYkrvncIZDVkzKwMv2F48nq0pj7SdlerDZ+nRN2nM
         PHPGfA60Su+viTo4BES3iCO9rX3NKt24AEJEYpaxJbpNCAIl35adoFn7rHNIWZG60b4X
         zhFzo1Eg4uyT3sc0z1RdOigg/v/k36AxWBVW1X33YFUantjzHQJ4GjCHzcrYdVUgonb8
         tsryOSC5G7cCOwtPjbC0wwnF6z2zSQFtNmvHRUBrneI6ECXHT40UUlmzmKlbRCYCcZZL
         scmK2Wpxeuy7aomxPvq6YSUAp2veBgOYstAXorDSX01d2OyIn4C1+gkfyMRdrhP+m3f6
         Ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sTMLSaazc/K4N+rqR/1atMAkBUL9y8o2wzuZyKKPW38=;
        b=bKXiPSCdG5kMQyFCNn+4OZw1SWfuDyzRKkc6qvlDZmxViRe+IKL0Ln+8Nd9BA7zprC
         NzBhhj5KevnFiLvtDMhsTBSwahaUJ4nWONfDY7ZkNqv7bPZ7fR7frS/yQNIf9Urbdeqi
         zMiMahRSyg8Ua2aYNEMIUR1vlRcbfpO3kpbPXaKFfS6dIq3VUs6yqJcPljiyizClbhVV
         PT7M+rMqtuEBsWlfmIQghhRePdTNKPH8AFcUDxcM6jo3fct9y07MW7Hzz5tRCClJ1WVS
         FMSEDhpRyfLlem+EcpSstS3lySs60I/lcw1+I4QlJYeRxt5vwhjAIJ7ucWS2Hm5g8aeO
         +aZQ==
X-Gm-Message-State: AIkVDXJyB103zCLFB2Hve6Zv8sPbd19jNcU/wiJw/acET6tjIEsNbBATFm6PcrRCE3S1ttmAxyHMTQGcNuZx0A==
X-Received: by 10.36.124.85 with SMTP id a82mr2300856itd.74.1483781402544;
 Sat, 07 Jan 2017 01:30:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 7 Jan 2017 01:29:31 -0800 (PST)
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com> <20170104180411.150000-1-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 7 Jan 2017 16:29:31 +0700
Message-ID: <CACsJy8CM6FfHpVuqby=hjPmiYAxvJjzr1W6LdO5B82KQnTmmog@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] pathspec cleanup
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 5, 2017 at 1:03 AM, Brandon Williams <bmwill@google.com> wrote:
> Changes in v5:
> * Move GUARD_PATHSPEC to prevent checking if pathspec is null twice.
> * Mark a string containing 'mnemonic' for translation.

Argh.. I've run out of things to complain about! Ack!
-- 
Duy
