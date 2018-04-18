Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72FF1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 04:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeDREZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 00:25:00 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:41990 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeDREY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 00:24:59 -0400
Received: by mail-wr0-f180.google.com with SMTP id s18-v6so867014wrg.9
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 21:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Kr7tlrXDrlC1pXtvYxQL5PD+MqIZEFFdPqxQEIq0fM0=;
        b=kyEmekT+3R/pt2PNcxxsUnC8ia/j/l5bZCZFyHg80rgVGg3KBJpGzlsf+WiIxlHng0
         ix8sqfmAgIs+QpqTGySfAjDsrFasNlvORDgh67tmeD1umZHWN0f67Nv9QzsE7n4iKu7b
         B6kety1WnBazo5x5MHGVD3S7quE7mR+ME3fnRg3MKzYV7KnQbDosp8gmllxbvhaX+LhR
         IV9UcO6J/Mg9d12MXJ1ouEHjorhRFuNJtQRmHGws3NLSDK914P1zYw5tiRhcAAFFA3/2
         tFb5yWz3pkg05ZngI6Gvt5gKNe1FsQV1NF6E7w/Og4lj7XFV58fSjvyJuamIDxbvomox
         jWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Kr7tlrXDrlC1pXtvYxQL5PD+MqIZEFFdPqxQEIq0fM0=;
        b=YoEPdvAew+4YY3eSEAwO8F2y9mLiprEeeszG8rWDDy7APtAIXkKha5LywL6PER8zZY
         NfBKJSfJL8/ZVzH+2N2W2RhK++3Yw3tiysvXPCNA/WAi/N6AonAuP2vCjX4k4+vAvGqi
         Vm8E0oCyFNS8zD3QMkbUNeysH7RHHLZcH8JR6UVFY++XYRkhumQKscKmK2/oA4RHvF6V
         cDA3shdbZI3kg5lPK02wjCqJFTLMtDEXYfuFeoF9q/b06rDWJLRomyMitUKbK7U1ACEC
         03J2ARqE3efnm6IizcjpzyjrHqAzcNxBn8mrXz24uHIB7bjbu/ycdvodCasgZ2fnQvrS
         U5Ew==
X-Gm-Message-State: ALQs6tDO0DYSpJmHLasx1jQ+hhjDY4DblBWu/pvPl3jcF8KKpIXEioDc
        EBYUadtLm2gS5g6SK1+34Yw=
X-Google-Smtp-Source: AIpwx4+yixsESsZwgWNFXiR9/tu/+rRueCUEYxHajNL0qTTR0gMGZ3+TxquwGacv08du/yA8KNCjww==
X-Received: by 10.28.91.209 with SMTP id p200mr449839wmb.11.1524025498246;
        Tue, 17 Apr 2018 21:24:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y191sm869876wme.14.2018.04.17.21.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 21:24:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] doc: cleaning up instances of \--
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com>
        <cover.1523991648.git.martin.agren@gmail.com>
Date:   Wed, 18 Apr 2018 13:24:55 +0900
In-Reply-To: <cover.1523991648.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Tue, 17 Apr 2018 21:15:25 +0200")
Message-ID: <xmqq1sfdjg4o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> This is a patch series to convert \-- to -- in our documentation. The
> first patch is a reiteration of 1c262bb7b2 (doc: convert \--option to
> --option, 2015-05-13) to fix some instances that have appeared since.
> The other three patches deal with standalone "\--" which we can't
> always turn into "--" since it can be rendered as an em dash.

All looked sensible.  As you mentioned in [2/4], "\--::" that is
part of an enumulation appear in documentation for about a dozen
commands after the series, but I do not think we can avoid it.

One thing that makes me wonder related to these patches is if a
newer AsciiDoc we assume lets us do without {litdd} macro.  This
series and our earlier effort like 1c262bb7 ("doc: convert \--option
to --option", 2015-05-13) mentions that "\--word" is less pleasant
on the eyes than "--word", but the ugliness "two{litdd}words" has
over "two--words" is far worse than that, so...

Thanks, will queue.


