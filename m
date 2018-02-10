Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1737C1F404
	for <e@80x24.org>; Sat, 10 Feb 2018 01:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeBJBEs (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 20:04:48 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50886 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeBJBEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 20:04:47 -0500
Received: by mail-wm0-f51.google.com with SMTP id f71so507882wmf.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 17:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/F0DuLkP5xXWZ4/ChSbPoeAuPgBSqE9juDXwqAcpv8o=;
        b=uaUeZ2k4TDj3PfLJ60q6+B0phiD+0vjxwkoHjHTP3DCuPQqifxV8UvY5KzOKK5/zKr
         Rd54Y+qxTHfiK2TCUll+OMEf82UG7Ep4VaVBShB6Z3lo0onwt4mYeL0iZPyBKCzThsaB
         Q8NtsP+5pUzJtV1QaqNiqtsBEsi9xJNkTqOsHqCc27Ez3KVwsRT3foFsymxuoFiCeTpu
         BJp9jZLhizidpxbriPyC+mihAC/Mj2/Ds/ulQk0iEcg2Ycw27s18xo8onanZI3cnTmJh
         sTGU79ttPlw2+LQogeqaht7iq7/rDTt4OxtwhxXOtCtsr1KHJA9KMQdyr0Zu4PSIXIjn
         f3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/F0DuLkP5xXWZ4/ChSbPoeAuPgBSqE9juDXwqAcpv8o=;
        b=q32qxFXOir+YEsqQokLiIUgb09KDsbl0D5wxFg+sIqlYggBJWIhLsKYuxRYTyGpGRM
         bbbE7iNgcn4Z9/veRZh1pcAfaIjv0Caep2ZEg0RXAuBYsTB/Tf6JAIqukXFgGq27d/ge
         Y+N10oEftuVJTC7pBRrv4eWd6pKcj9lV2mr24lBjhN2Tg3Yr5w7VLgJklwwT7TwzHHLF
         a9qm9W3TCvf8daTHNZiS7aE8iatRXT+ykUUr0trH5PC6diU1zhzErdfX7hfJz7BZUGUs
         Ubu58r/1sSiyhxmSchnJmJhc3+Ufh/TSWabsrJ/UEII3eBM0XMHXVrlEXBsjRpI1Mbc3
         YmZA==
X-Gm-Message-State: APf1xPCB4XbnnFuPvATgvkSTBKpC6x0RmN9VOV7vD7AJ+U+YskPGopm2
        4iHuNr/6QRPuzdzs3ZIZkAI=
X-Google-Smtp-Source: AH8x225vlHYfwDcwer4X5SGWmyMZv6GkVgWR+VCU1erhFkvGC/kHQtHTSIc7DvsytQSWy9nlpUkTug==
X-Received: by 10.28.21.136 with SMTP id 130mr3093845wmv.152.1518224686334;
        Fri, 09 Feb 2018 17:04:46 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5C3C.dip0.t-ipconnect.de. [93.219.92.60])
        by smtp.gmail.com with ESMTPSA id x203sm823317wmd.11.2018.02.09.17.04.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Feb 2018 17:04:45 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 0/7] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqk1vlx6uu.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 10 Feb 2018 02:04:44 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <6384A7D9-66F8-4723-A50C-071D1DE34E42@gmail.com>
References: <20180209132830.55385-1-lars.schneider@autodesk.com> <xmqqk1vlx6uu.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Feb 2018, at 21:09, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Documentation has core.checkRoundtripEncoding while t0028 and a
> comment in convert.c capitalize it differently.  I suspect that it
> would be more reader-friendly to update the documentation to match.

Agreed. I will wait a little for additional feedback and then send 
a new round.

Thanks,
Lars
