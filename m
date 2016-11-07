Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B452022A
	for <e@80x24.org>; Mon,  7 Nov 2016 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932559AbcKGRtn (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 12:49:43 -0500
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:37818 "HELO
        gproxy6-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932414AbcKGRtl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2016 12:49:41 -0500
Received: (qmail 31513 invoked by uid 0); 7 Nov 2016 17:49:38 -0000
Received: from unknown (HELO cmgw2) (10.0.90.83)
  by gproxy6.mail.unifiedlayer.com with SMTP; 7 Nov 2016 17:49:38 -0000
Received: from box531.bluehost.com ([74.220.219.131])
        by cmgw2 with 
        id 55pZ1u01D2qhmhE015pcGZ; Mon, 07 Nov 2016 10:49:37 -0700
X-Authority-Analysis: v=2.1 cv=PIacp5aC c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=L24OOQBejmoA:10 a=GhE016ZtFJQZrFCmKDYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID; bh=TueQnWdEg13JECE/s9OQPyEqB4TXYC828W2uveH3aIk=; b=adl62p6vwxmcgP
        frOPLQ/OZ8MYaJQOd25krQVqBsWrUT3B0N0vGQoiimQZSRf3WIjgSLAYN6Pz2iK8TMUScAL8HvAwZ
        0UMXighcP1/cim2hMR/G+5EXOelupLkX1YQYj;
Received: from [64.238.138.90] (port=59228 helo=pdsdesk)
        by box531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.86_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1c3o35-0003KS-C9; Mon, 07 Nov 2016 10:49:35 -0700
Message-ID: <1478540973.4171.22.camel@mad-scientist.net>
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and
 APPLE_COMMON_CRYPTO for macOS >10.11
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        tboegi@web.de, gitster@pobox.com
Date:   Mon, 07 Nov 2016 12:49:33 -0500
In-Reply-To: <20161107174559.t72vxxkckqdbxmbg@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
         <20161017002550.88782-2-larsxschneider@gmail.com>
         <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
         <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
         <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
         <1478540194.4171.19.camel@mad-scientist.net>
         <20161107174559.t72vxxkckqdbxmbg@sigill.intra.peff.net>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5-0ubuntu1~ubuntu16.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box531.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 64.238.138.90
X-Exim-ID: 1c3o35-0003KS-C9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [64.238.138.90]:59228
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 9
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTMxLmJsdWVob3N0LmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-11-07 at 12:46 -0500, Jeff King wrote:
> Specifically I wanted to make sure that
> 
>   FOO = bar
>   FOO =
>   ifdef FOO
>   ... something ...
>   endif
> 
> works as if FOO had never been set in the first place. Which it seems
> to, at least in GNU make (and that is the only one we support, for
> other reasons).

Yes, it will work.  Confusingly, "ifdef" actually tests whether the
variable has a non-empty value, not whether it's defined:

> The 'ifdef' form takes the _name_ of a variable as its argument, not
> a reference to a variable.  The value of that variable has a non-
> empty value, the TEXT-IF-TRUE is effective; otherwise, the TEXT-IF-
> FALSE, if any, is effective

*sigh* History...
