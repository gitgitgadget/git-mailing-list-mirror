Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D8A1FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 11:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbcLILvi (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 06:51:38 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:49036 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbcLILvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 06:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=to:cc:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=K04YeC7J1bKMmoepDE4t1sY/PnQ
        T3ILChhLbm85m4DM=; b=i31Y+dZqNs0/eZYRy1vslz/lGr63+TI1b84DcU22r5y
        QqfQw1jJG7BcZlphgffap8g/BQJjzBAJRRfbg4qrk1rFQ5PN1tIfnLLX9TsI+lL/
        NqoAqFjvpdNQTxbL8yaVuE+pcFJ5RHq3+lSYys591y9RdeatPCyvH9fpyh6vFs/8
        =
Received: (qmail 6071 invoked from network); 9 Dec 2016 12:51:34 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 9 Dec 2016 12:51:34 +0100
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Paul Mackerras <paulus@ozlabs.org>
From:   Markus Hitter <mah@jump-ing.de>
Subject: Resend: Gitk: memory consumption improvements
Message-ID: <d10d2b12-4ef1-61e9-0b3c-89aa41c9eeff@jump-ing.de>
Date:   Fri, 9 Dec 2016 12:51:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


It's a month now since I sent three patches to this list for reducing memory consumption of Gitk considerably:

https://public-inbox.org/git/de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de/
https://public-inbox.org/git/e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de/
https://public-inbox.org/git/8e1c5923-d2a6-bc77-97ab-3f154b41d2ea@jump-ing.de/
https://public-inbox.org/git/2cb7f76f-0004-a5b6-79f1-9bb4f979cf14@jump-ing.de/

Everybody cheered, but apparently nobody picked these patches up and applied them to either the Git or Gitk repository. They don't appear in the regular "what's cooking" post either.

Anything missing? I'd like to put a 'done' checkmark behind this.


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
