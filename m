Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB72A1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933741AbdBPXhZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:37:25 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34272 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933463AbdBPXhY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:37:24 -0500
Received: by mail-lf0-f68.google.com with SMTP id q89so2591249lfi.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 15:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VlsRWtzc3gZVA8LuXAFca09HBMuLnfYUQOlPVtopXNY=;
        b=ansi5Snar2p1eqI5gRtGtDTRRN2ZwtwPFLJG+pz/jTsG4bSXLBX3OmZGy5ZdPa0WlB
         r/V9KPFeMfcb21ynTUxhQlWDv+Alk6IrrWjlj7qNvqV/iAJhiLcMr5QuIiOo6JQ1AvMi
         WHFi6TEKgAmF0d+ENPGh0snwTrCMw288+LbjhapwXBD7b9k96inoY1a0Z9uUBlWrrSY+
         Di80bxG7BchZXdBCeNdO375L61wPwDsqVehnMEOZUpW/Hp3CExn+gdEFV23cSjFaQbNb
         7Z9Ry7ef5oKYSLOucvdu0M+HDO2fORSNOXVtVhMmooqsiAmd6NbpTNacszoYNKvSE81O
         vYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VlsRWtzc3gZVA8LuXAFca09HBMuLnfYUQOlPVtopXNY=;
        b=auclHsD1pBeCBefg4IoVHonW5rLRgWk6Bo5QhhODe3wojwTbiL/OJlfEDxmjwQPK2d
         XuKkADWDm0zbqmV+NLIzEFSAc35tWYMdHRhZ907hGwLJzSYhsFMUkdkKLohcApjgqNVQ
         b5Rcvh0WZMYxgr3048ZBOX2+VDKlT4e+9iFMT7x36ddtPp0/xDo1TFnNA9mgB2pOTMtA
         4JiXHBatuEXfkjmkPgmQxAgwJxc6r2LEv0K9Pe7o5qZWwbiMOsBjm67zYSmjyq6vTn9E
         pHd4nona4ljeJ2Dx88w4IDqvAvOfjPuuLpye8C+i9arzPiWgqSppHftqmdVmRt/jNR1N
         i9MA==
X-Gm-Message-State: AMke39kMM6ZnXq90DB0sQzCbAtcUFAjBN06BlTu4mq6HvpZLCiPY2hSEfUiXplgk1Y8U6A==
X-Received: by 10.25.15.68 with SMTP id e65mr1518810lfi.117.1487288243094;
        Thu, 16 Feb 2017 15:37:23 -0800 (PST)
Received: from ?IPv6:2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb? ([2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb])
        by smtp.gmail.com with ESMTPSA id o5sm2076439lfo.35.2017.02.16.15.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Feb 2017 15:37:22 -0800 (PST)
Message-ID: <1487288237.25073.1.camel@gmail.com>
Subject: Re: [PATCH V2 0/2] Fix l10n
From:   Unknown <franchesko.salias.hudro.pedros@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com
Date:   Fri, 17 Feb 2017 02:37:17 +0300
In-Reply-To: <xmqq8tp5vhgk.fsf@gitster.mtv.corp.google.com>
References: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
         <xmqq8tp5vhgk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

В Чт, 16/02/2017 в 15:33 -0800, Junio C Hamano пишет:
> Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com> writes:
> 
> > In some places static size buffers can't store formatted string.
> > If it be happen then git die.
> > 
> > Jonathan Tan: Thanks a lot for your help.
> > 
> > Maxim Moseychuk (2):
> >   bisect_next_all: convert xsnprintf to xstrfmt
> >   stop_progress_msg: convert xsnprintf to xstrfmt
> > 
> >  bisect.c   | 9 +++++----
> >  progress.c | 9 +++------
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> > 
> > --
> > 2.11.1
> 
> Thanks.  Queued with minor log message fixes and pushed out.

If is not too late, please check the version 3.
