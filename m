Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3EC20281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbdF2SqZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:46:25 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36388 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdF2SqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:46:24 -0400
Received: by mail-wm0-f41.google.com with SMTP id 62so90676736wmw.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PIL8UdM/1pmi7dsILNA6BJIq0yk+AVvlF+CxG1giM78=;
        b=iXJcbXlAwT0f7sXEFLUWyQeOQvmxr9kGMDcSxcLDxHsKI6nC//m9yjQQ46AZIZMqSK
         WcOPf+Mdk0JziUTpYJ4aCf5HKR6AP3Mfrn2MOo+v/m4x7qmAM5mjBKlDqBhBazYnPuxC
         lKvIhNfK9sAhceHkDqHJj/Q2N0j3z2CfjS4ca+TR/tLlQWEe/Wpn8s/D0Aq11MwfALxn
         PgXorK0V91x3AzZcUQgAQeDimzXPhRBSYrnjNMYIOKDiB9FgefUDcRRkl3aMV3ZpdxkN
         Oa6Udlp4HiUgNF39/mbe4kRNs+pEpoNXuRoTyh9elO71J3wuHHHcW1z9x1K3Oh3+10/y
         ++YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PIL8UdM/1pmi7dsILNA6BJIq0yk+AVvlF+CxG1giM78=;
        b=AmCFsflvWshWpWJx+LS6q6dpw6LKFmuLZ7pWP7sQexJbMWsPxzeitcvBE26BPcUAir
         5LgEAg08PwYyKHMACkYRIE23Ma55YMrctfZguirkH+QKl363uv9dSIU/epCJuuXhrXbJ
         qnl3xqjIs76lX90cHHEXI7YAaS+FjYHhgKkRZuaBe0BYFIUcZ3S660JTbH+fNvg1tCEf
         SWB4Vw3lryMLe4OF6dZCp0IkN4EURpAPtNKI3ZeOTuEY7G+aXtuXgPwliP2RxXkUkQoW
         RD99fJdEU6jkibNp+Ufz280WrWujMfX7CIbsrgjSjaB/AeqPydoDqWO8WZqeHLby4NdP
         XW9A==
X-Gm-Message-State: AKS2vOzh4LgbM0rc21xFCSvyNhLuz7ogaORc2sdz+nqTDbtVpJ665kL6
        nFEKdsQyP30Hww==
X-Received: by 10.28.0.78 with SMTP id 75mr9400665wma.58.1498761983400;
        Thu, 29 Jun 2017 11:46:23 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB50F9.dip0.t-ipconnect.de. [93.219.80.249])
        by smtp.gmail.com with ESMTPSA id 185sm5528618wmu.33.2017.06.29.11.46.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:46:22 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 6/6] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqinjetzgc.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Jun 2017 20:46:21 +0200
Cc:     Git Users <git@vger.kernel.org>, peff@peff.net, tboegi@web.de,
        e@80x24.org, ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <C36BBCCA-6694-40EC-8E1A-36B0CB9D4B2D@gmail.com>
References: <20170628212952.60781-1-larsxschneider@gmail.com> <20170628212952.60781-7-larsxschneider@gmail.com> <xmqqinjetzgc.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Jun 2017, at 20:34, Junio C Hamano <gitster@pobox.com> wrote:
> 
> You seem to have squashed an unrelated "table-driven" clean-up into
> this step.  While I think the end result looks good, I would have
> liked to see it as a separate step, either as a preparatory "now we
> are going to add the third one, let's make it table-driven before
> doing so" step, or a follow-up "now we have done everything we
> wanted to do, let's make this clean-up at the end" step.

I am sorry. That was a misunderstanding - I thought you want to have 
this change squashed. 

The "preparatory" patch sounds good! 
Would you be OK if I send a v9 with this change?

Thanks,
Lars
