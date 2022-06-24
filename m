Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFAC433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 01:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiFXBDF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 23 Jun 2022 21:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFXBDE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 21:03:04 -0400
Received: from omta015.useast.a.cloudfilter.net (omta015.useast.a.cloudfilter.net [34.195.253.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E39F5B3
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 18:03:03 -0700 (PDT)
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.148])
        by cmsmtp with ESMTP
        id 4L61ockThfvVh4Xiwo4jeJ; Fri, 24 Jun 2022 01:03:02 +0000
Received: from thunderbird.smith.home ([70.176.251.46])
        by cmsmtp with ESMTPSA
        id 4XiuotTk7n20P4Xivo9m3Y; Fri, 24 Jun 2022 01:03:02 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.4 cv=EvTBEAQA c=1 sm=1 tr=0 ts=62b50d46
 a=OCGoW4wscCDr3YEa6K7Wzw==:117 a=OCGoW4wscCDr3YEa6K7Wzw==:17
 a=8nJEP1OIZ-IA:10 a=JPEYwPQDsx4A:10 a=irK6OhU5MZFQRCZIAbcA:9 a=wPNLvfGTeEIA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 8AC06196158E;
        Thu, 23 Jun 2022 18:03:00 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.org>,
        Kyle Meyer <kyle@kyleam.com>
Subject: Re: SHA-256 transition
Date:   Thu, 23 Jun 2022 18:03:00 -0700
Message-ID: <12140906.O9o76ZdvQC@thunderbird>
In-Reply-To: <220624.86fsjvj690.gmgdl@evledraar.gmail.com>
References: <12011256.O9o76ZdvQC@thunderbird> <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net> <220624.86fsjvj690.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-CMAE-Envelope: MS4xfH/Jtnfx+2VtT+qlmSSBEezYBsQcAfRF4VSmgqFlU9h9Un+dV32/t/Moh9MlRdkPRHWkPb2nEChjSOuwNgzHFvFJK2hFnfWJsl10h7l5zwxBTaQP+OV0
 d3S2bS5kUa8Rx+t673yxfV+B+1GMuLICxbYhGFv1CLHRpjTcyKuoKxT7vbmRp7jZQc59JNBWQTvcSmag4nxIcrmMo7McxEkYoJC9wwQKnrKav/Rr/X395PTh
 xSfEJtiCHIabvqwUPOy4GdpFH+wS8uXhOeo4QBg+QPIcYBPLpoYgqK0a2d0WmeWdc3jc9fX1ZBoGglANeIywOQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, June 23, 2022 3:21:05 PM MST Ævar Arnfjörð Bjarmason wrote:
> Finally, I'd really like to thank you for all your work on SHA-256 so
> far, and really hope that none of what I've said here is discouraging in
> any way. This thread has received some attention outside this ML (on
> LWN), so I wanted to clarify some of the points above. Thanks!

I had looked on LWN before I started the thread to see if anything was being 
discussed and it wasn't.

I tend to be an early adopter.   I hadn't seen any new commits in the main git 
repository in a while and was beginning to wonder if it had been abandoned.   
This thread has convinced me that isn't the case, but the main person doing 
the developing being busy.

I too want to say thank you (Brian) for your hard work.   






