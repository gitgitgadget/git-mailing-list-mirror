Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A48203EA
	for <e@80x24.org>; Sun, 11 Dec 2016 14:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbcLKOJB (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 09:09:01 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:60673 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbcLKOJA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 09:09:00 -0500
Received: from PhilipOakley ([92.22.22.210])
        by smtp.talktalk.net with SMTP
        id G4oEc8NkmgKstG4oEcLgBY; Sun, 11 Dec 2016 14:08:59 +0000
X-Originating-IP: [92.22.22.210]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=ml+yzTU89BnYyX12/wy+jA==:117
 a=ml+yzTU89BnYyX12/wy+jA==:17 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8
 a=-V7NIcEsZz9uUadvRR0A:9 a=wPNLvfGTeEIA:10 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <C42D5B32E3FC43F8933D3F66CB2456C7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>,
        "Git List" <git@vger.kernel.org>
Cc:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-5-kristoffer.haugsbakk@gmail.com> <2645548666054ED5BD30436E9DA41C14@PhilipOakley>
Subject: Re: [PATCH 4/4] doc: omit needless "for"
Date:   Sun, 11 Dec 2016 14:08:58 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfChAbFNwoOwTIx97KiIvRiZvowyZMfuiE8DHzExXGJAbPcv7FwosENfmrheo1qRoSmori4kqOCiy0JrDKTH3wkc3KroP3H4rSeP4XIeIfRw2nmu+6qEX
 G0Y631rgeOwiE3ci52qbWeZcbKPXwF8o7dh5w3ySydQdGt/8rDa18SGru6xw25zqmttS2eYjJFKcJQPKaJsO2mE0+yLQgtI2D0eUBIZPld9LWKz5TQnk0OXG
 2/aCEEnOJChGesxQ4d2tVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip Oakley" <philipoakley@iee.org>

>> diff --git a/Documentation/gitcore-tutorial.txt
>> b/Documentation/gitcore-tutorial.txt
>> index 72ca9c1ef..22309cfb4 100644
>> --- a/Documentation/gitcore-tutorial.txt
>> +++ b/Documentation/gitcore-tutorial.txt
>> @@ -25,7 +25,7 @@ you want to understand Git's internals.
>> The core Git is often called "plumbing", with the prettier user
> 
> If we are tidying up here, then perhaps
> s/core Git is often/Git commands are often/
> to better clarify what aspects are plumbing / porcelain.
> 
accidentally dropped a word. Should have said
s/core Git is often/core Git commands are often/

