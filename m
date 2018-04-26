Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3C61F404
	for <e@80x24.org>; Thu, 26 Apr 2018 07:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeDZHoE (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:44:04 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36476 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754274AbeDZHoC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:44:02 -0400
Received: by mail-wm0-f51.google.com with SMTP id n10so11207778wmc.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VRjdr2iSP3Qt5f+hpFLG25jMKDwMsQadKTwxIbOUHnY=;
        b=PqZiUOo6qxUB4/V63566Z8d/JjPQhvPl3T1YxZUDlE4J3PDssxOG05WPYWZ/DeR7jW
         EJ63E6YMTy3DeBD43M4ZxKOkJ/45CFCboiGvLYQtucVk/ye/n4GVv5NgSrBso3hMTRGM
         wl4NPAxtTjT+W/9YarIWJB4YRmLRz+x0FlfHEG7bby910FifvVsckBO4X0IMYtm4P8+A
         +7MGrlryZFL1Y7OO99KzjAPLnXg7+fHkzLJhAwArwcdGySv5V+2u96aeU/QovQXoFX15
         BvxsGiJayD79vl+SZnY/5MlaHkWvkLsBEcgKh75FJx5dVGZ1ZtshH7D0dTEzhXR0OrVW
         KS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VRjdr2iSP3Qt5f+hpFLG25jMKDwMsQadKTwxIbOUHnY=;
        b=lZnCspupbMyO3CbtLmSqrPHDl6gV55dXBDfAGo+2MjKomQfdH0RczOjHqSmGo3cOVV
         EQ3qfrLL1YtTw6UCkNAuVKrW5O1SMFBwtAC4Ftfkq9agAh2brTBZyvwnf/CtwDr6ZXNT
         rSmiKltNHwoETJsL+6eNQD2kyH9xXdmB8z+OopSqSrMQqCrheNneUOhCtoCm41bTxHKB
         FtQKla3ur3A7dF9jPtquYt0xC9oSu0o8+pFyRDyP6QCHklw3wkfCOSwq6yIMERQhgzJB
         DIGr98BJE2ryihsP9KdNdTp1Qe+4nVqk2UyTyA9+BoMx040aWLOi6trA++EjPFEg2UCo
         fo7A==
X-Gm-Message-State: ALQs6tDAcA+NWOTi4+6f61OUHc0bt3syQtKRvwe7A2fCcP/AL0X+dNVW
        N2/dlfqhAfr/+dakvDwlaKTJ8yf0
X-Google-Smtp-Source: AIpwx4+5kjt6KRIFLoz4EUgXNBzniv3uVqoaighImMMY2rHXd6++AamVB0rVBcsct83nAhRUcmMgug==
X-Received: by 10.80.170.135 with SMTP id q7mr42275727edc.124.1524728641107;
        Thu, 26 Apr 2018 00:44:01 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id u5sm11393354edi.79.2018.04.26.00.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 00:43:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: Antw: Re: java diffs show no method context
References: <5AE07A3A020000A10002B5C5@gwsmtp1.uni-regensburg.de> <aae8d748-101d-1eb2-f8e8-9da2e53e2388@gmail.com> <5AE17203020000A10002B5EF@gwsmtp1.uni-regensburg.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <5AE17203020000A10002B5EF@gwsmtp1.uni-regensburg.de>
Date:   Thu, 26 Apr 2018 09:43:58 +0200
Message-ID: <87y3hacszl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 26 2018, Ulrich Windl wrote:

> Thanks for that. It sounds plausible, but I wonder why it works automagically
> for C, but not for Java (Politcal reasons put aside): Using ".c" for C is about
> as common as using ".java" for Java ;-)

It has a bit to do with it being in C, but not in the way you think. By
default Git doesn't enable the "cpp" driver either for *.c, but it just
so happens to do the right thing more of the time because the default
heuristic is basically to search for a nearby line that doesn't start
with whitespace for context.

This doesn't work for Java because your methods tend to be indented
since they're part of the class you're working on.
