Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454B52022A
	for <e@80x24.org>; Mon,  7 Nov 2016 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbcKGRhj (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 12:37:39 -0500
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:58799 "HELO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S933038AbcKGRhR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2016 12:37:17 -0500
Received: (qmail 6589 invoked by uid 0); 7 Nov 2016 17:36:43 -0000
Received: from unknown (HELO cmgw2) (10.0.90.83)
  by gproxy10.mail.unifiedlayer.com with SMTP; 7 Nov 2016 17:36:43 -0000
Received: from box531.bluehost.com ([74.220.219.131])
        by cmgw2 with 
        id 55ca1u0142qhmhE015cdXn; Mon, 07 Nov 2016 10:36:38 -0700
X-Authority-Analysis: v=2.1 cv=PIacp5aC c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=L24OOQBejmoA:10 a=hDE4tMfa8fsOSKfQCnEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID; bh=rhka49JDeU7N16Z3BXjUA1z5FO6YcIV+JY6Z7CKYYmc=; b=M7Bbj0BLcHjC1f
        iLiG5W/DxFlPWb2nZX7r6hvq1WOqhz3hYBPg1w+JKk4bwV0t97VtksXU18RZR01ppPKmt+eap6UmF
        +queoCMjoq0PDd666TPkxfEnuNeA/0pwbto4V;
Received: from [64.238.138.90] (port=58990 helo=pdsdesk)
        by box531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.86_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1c3nqW-00057A-5Q; Mon, 07 Nov 2016 10:36:36 -0700
Message-ID: <1478540194.4171.19.camel@mad-scientist.net>
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and
 APPLE_COMMON_CRYPTO for macOS >10.11
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, tboegi@web.de, gitster@pobox.com
Date:   Mon, 07 Nov 2016 12:36:34 -0500
In-Reply-To: <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
         <20161017002550.88782-2-larsxschneider@gmail.com>
         <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
         <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
         <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
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
X-Exim-ID: 1c3nqW-00057A-5Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [64.238.138.90]:58990
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 4
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTMxLmJsdWVob3N0LmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-11-07 at 12:26 -0500, Jeff King wrote:
> I have in the back of my mind a fear that it is harder to unset a
> make variable than it is to override it with a new value (which is
> what you'd want to do here to turn openssl back on),

It depends on what you mean by "unset".

If you mean it as per the shell "unset" command, where the variable is
completely forgotten as if it never was set at all, that's tricky.  You
have to use the "undefine" special command which was introduced in GNU
make 3.82 (released in 2010).

But if you just want to set the variable to the empty string, using
"FOO=" works fine for that in all versions of make (GNU and otherwise)
and using all the normal rules (command line override, etc.)

It's not easy to distinguish between a variable that is empty and one
that is actually not defined, in make, so it's a difference without a
distinction in almost all situations.
