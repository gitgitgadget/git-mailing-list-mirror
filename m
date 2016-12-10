Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598811FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 18:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbcLJSXK (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 13:23:10 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:39604 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbcLJSXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 13:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=PlotidvepzAoWA
        hIjcHzJDFSrtudMbUJTRt4j3QI95A=; b=uvZx/oqIyYrr6vHrYj3xrHEAn8irKD
        VU0KHGE5Pu2sCdWggeSa8BBiJyGhjcNMfiTXpqSwnjs2805riHWJ+BLaCvEa8R5O
        2Wux/QER0+HeNcD6Zxrg8Cp7tUa4MZE9DgGArmBuHrcg06J6THB++7SnDDQ5G2PM
        UXR9jGSRlvTuo=
Received: (qmail 13048 invoked from network); 10 Dec 2016 19:23:07 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 10 Dec 2016 19:23:07 +0100
Subject: Re: Resend: Gitk: memory consumption improvements
To:     Stefan Beller <sbeller@google.com>
References: <d10d2b12-4ef1-61e9-0b3c-89aa41c9eeff@jump-ing.de>
 <CAGZ79ka4TRXW7-YY8hqvYz_NJ+dZxtwY6KDSOJ+0cZF4i-J+fA@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <0c2a3b89-832a-a78f-f77e-a4a2659ddb90@jump-ing.de>
Date:   Sat, 10 Dec 2016 19:23:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka4TRXW7-YY8hqvYz_NJ+dZxtwY6KDSOJ+0cZF4i-J+fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.12.2016 um 18:57 schrieb Stefan Beller:
> On Fri, Dec 9, 2016 at 3:51 AM, Markus Hitter <mah@jump-ing.de> wrote:
>>
>> It's a month now since I sent three patches to this list for reducing memory consumption of Gitk considerably:
>>
>> https://public-inbox.org/git/de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de/
>> https://public-inbox.org/git/e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de/
>> https://public-inbox.org/git/8e1c5923-d2a6-bc77-97ab-3f154b41d2ea@jump-ing.de/
>> https://public-inbox.org/git/2cb7f76f-0004-a5b6-79f1-9bb4f979cf14@jump-ing.de/
>>
>> Everybody cheered, but apparently nobody picked these patches up and applied them to either the Git or Gitk repository. They don't appear in the regular "what's cooking" post either.
> 
> The "What's cooking" email is done by Junio (the Git maintainer)
> describing the development of Git, whereas gitk is maintained by Paul
> if I understand correctly.

TBH, there might be no Gitk maintenance at all, because the last commit in either repository dates February 2016. It's a bit hard to believe there was not a single contribution in 10 months.


> I'd love to see those patches in use here (via a regular upstream update).
> 
> So I guess the way to go for you is to keep bugging Paul for an ack?

Like:

  Hey hey Paul!
  Come and get the goal!
  Fetch the patch and get applied
  to our all's delight!

or like

  Macke- Macke- Mackerras!
  Come here and join with us!
  It's just a simple 'git am'
  and you are the man!

Another encouraging poem?


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
