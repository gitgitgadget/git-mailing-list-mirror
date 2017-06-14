Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECB220401
	for <e@80x24.org>; Wed, 14 Jun 2017 07:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbdFNHnE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 03:43:04 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33343 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdFNHnD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 03:43:03 -0400
Received: by mail-wr0-f177.google.com with SMTP id v104so166434584wrb.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Zq2vLWLrbkAjrcC9utjefpBo6pWyi19aaDCb2Np/Nw=;
        b=KUU3VBMJUvgQs6ciKmFT2iIvSpU5XkilUCe0B6ZMCjHClBMVBIOsfI1WVbn1alyCbw
         AgsjyNSH5DwO7pUxMvBp9Wh0hzKND+VMBNMc63yi3L2KDshnuYJUkS53LH4PdQKiVKBq
         fDjsLMeLSfZ4CAZ+Qq+0ORa+qAUCZoFCmmDQTQO+FGUqgzuNIBTJqtrNlFwNC08kNX/z
         HQ6koiNWGU3+euEJBZEM1VhdBkpnAS7/D1aEKPrWmf3rIfw8EN+MzRz9vp59+TE9vCFD
         EahFezx+yVwFH9huofebi57StK75kFtEb3khi0IvTDbzmUagPZRapRMgqXGAKTRio45z
         kWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Zq2vLWLrbkAjrcC9utjefpBo6pWyi19aaDCb2Np/Nw=;
        b=WZec+tJc0ExW0/t06daLcJykXC+eIST0X9zPUOtcwTshIGYzJ0YQe1OW2oi2HlCi5g
         TM1P9wMFsax1foUKlxywJSb5eTtOdLzNUg/K601OOROtZtUmJgNwvx5sCl1qcW/AIKfZ
         bFbSYtyfctvi/1rZoXWw06ORtdZYLurwbtz17bSUw87vkBIjXsNTxTu7B9vC0R42He8W
         FBY3luCYVsqtFpzFz59u8rpe7UkeQ73wvJgN1Zs0c8qZgtNvDWXbysmzqbVI+vnv8qnT
         eSaKunfM3IHrOni8bDNljzK+NHTklf8VkodjshgJ3yVMbDmwgwaGJCUTRvTNjdxVjDNO
         C19Q==
X-Gm-Message-State: AKS2vOwidCddF88x5U+4d+ckYexrhn3Oo9Ze+k6LhanFIgqKzNAyYEQV
        0bgucO7PCuWS3g==
X-Received: by 10.223.175.223 with SMTP id y31mr5495170wrd.77.1497426179623;
        Wed, 14 Jun 2017 00:42:59 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4E74.dip0.t-ipconnect.de. [93.219.78.116])
        by smtp.gmail.com with ESMTPSA id z194sm291696wmc.31.2017.06.14.00.42.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 00:42:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2017, #04; Tue, 13)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 14 Jun 2017 09:42:58 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3304FB6C-D9A3-42FD-A047-EF97F50BE258@gmail.com>
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Jun 2017, at 23:40, Junio C Hamano <gitster@pobox.com> wrote:
> 
> 
> * ls/github (2017-06-13) 1 commit
> - Configure Git contribution guidelines for github.com
> 
> Help contributors that visit us at GitHub.
> 
> Will merge to 'next'.

I just pushed v3. If possible, please use it for 'next':
http://public-inbox.org/git/20170614073536.45498-1-larsxschneider@gmail.com/


> * ls/filter-process-delayed (2017-06-01) 5 commits
> - convert: add "status=delayed" to filter process protocol
> - convert: move multiple file filter error handling to separate function
> - t0021: write "OUT" only on success
> - t0021: make debug log file name configurable
> - t0021: keep filter log files on comparison
> 
> The filter-process interface learned to allow a process with long
> latency give a "delayed" response.
> 
> Needs review.

I wonder if anyone has a few free cycles to review this:
http://public-inbox.org/git/20170601082203.50397-1-larsxschneider@gmail.com/

My GitLFS users are desperately waiting for this change :-)


Thank you,
Lars
