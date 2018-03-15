Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D3961F404
	for <e@80x24.org>; Thu, 15 Mar 2018 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeCOTSI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 15:18:08 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:42371 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932524AbeCOTSH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 15:18:07 -0400
Received: by mail-pl0-f53.google.com with SMTP id w15-v6so4368816plq.9
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4xaejERtwiuq+9ZURBOXIoT9YvyDFlkG36SpqWcDOGU=;
        b=s7YjhN8S5ElNY/EQMWBf+sKXPrHQUQdJQ3diyprsGxgm519/aVoMMTIK/FzyYvxgVB
         kvQ/3bH4w00PiPbSOhTohJbe+RUNtdZOhukmEVrsr7859wh1Ld9+z7yWoPi6gMl2x+gZ
         oHTUeCXmRD6OGfh3IBlJaaQHKtF4fvs8QrdgP/ykgD8zwNyYY083xOLZNVza2u+XEREO
         CrZk/bJ+jjeND1umMoBXqwlns6tp07E+hJonRpJ+sD+3y3xqxAeYCTQvX/ZCatBBpN+R
         yMF3omCPEZUqB+NEQ8HjWmTYS0/BgsM3R9KqpmV/WfCOCiTxITlbWlveHj8HxV0xzNh9
         MBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4xaejERtwiuq+9ZURBOXIoT9YvyDFlkG36SpqWcDOGU=;
        b=rJA3HsjeRiFUEmEO1GMGMWbamo8rU1i88Bprwf3Kjgwgi+LArvsXmGCodR4/IPjz+1
         XIPOzvwm2xEqalOUmkAqSt9G6kvEeMLpagst4mH+7r8jr3MoWEm/s3dwKH16PpyY7HeC
         xPopb3Qr+fC0p3hEPtg13iNMIIhaIf0BkXOTAkQW70Wwpxh7eIJjKifVmp/Br/D+NqgO
         jOio2poVsYwxMspOtBPlQ0iNPYX3Wn1pHQUchSq/XDy6xHJjG5mEnKfoHjGWULP8bJs4
         Jl8eimdZ4vVAb8HE7+NECc9zr3eV095ManLPAzdxhIV64BZLurKEysxf8MjdHqf4R1Ap
         VMPA==
X-Gm-Message-State: AElRT7FLJBGzpJxKHp3AiMdoxWKgQD1I02R7P3KShHSYThy2wk7Rz8RM
        +g8Spn1i1wsWua3k+jsFG23ASN6O
X-Google-Smtp-Source: AG47ELvSW5UMHtIybuf8X6CFVJ188oCN1gMQ5hBtHY1Qn4mDp362nnCEnW9o3Bq+c+Ar5oAXTsGbcQ==
X-Received: by 2002:a17:902:b102:: with SMTP id q2-v6mr1314832plr.151.1521141486504;
        Thu, 15 Mar 2018 12:18:06 -0700 (PDT)
Received: from rem2ua0031cfw.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p24sm12822014pfk.102.2018.03.15.12.18.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Mar 2018 12:18:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 15 Mar 2018 20:18:02 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7D05D553-D914-402F-8AE1-C49C1E1D64AB@gmail.com>
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Mar 2018, at 02:34, Junio C Hamano <gitster@pobox.com> wrote:
> 
> ...
> 
> * ls/checkout-encoding (2018-03-09) 10 commits
> - convert: add round trip check based on 'core.checkRoundtripEncoding'
> - convert: add tracing for 'working-tree-encoding' attribute
> - convert: advise canonical UTF encoding names
> - convert: check for detectable errors in UTF encodings
> - convert: add 'working-tree-encoding' attribute
> - utf8: add function to detect a missing UTF-16/32 BOM
> - utf8: add function to detect prohibited UTF-16/32 BOM
> - strbuf: add a case insensitive starts_with()
> - strbuf: add xstrdup_toupper()
> - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
> 
> The new "checkout-encoding" attribute can ask Git to convert the
> contents to the specified encoding when checking out to the working
> tree (and the other way around when checking in).
> 
> Expecting a reroll.
> cf. <66370A41-A048-44E7-9BF8-4631C50AAE63@gmail.com>
> Modulo minor design decision corrections, the series is almost there.

If I hurry up (IOW: send a reroll tonight), would this topic
have a chance for 2.17-rc1 or is it too late?

Thanks,
Lars


