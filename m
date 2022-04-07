Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EAAC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 07:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiDGHYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiDGHYK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 03:24:10 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76BAB8
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 00:22:10 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <markus.vervier@x41-dsec.de>)
        id 1ncMT1-003B21-Jc
        for git@vger.kernel.org; Thu, 07 Apr 2022 09:22:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=x41-dsec.de
        ; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID;
        bh=m+GM5Xjwj6rI1e5/IDhze3+Z6cviCRvWqPOHH3J7R+0=; b=WAe+gsxuY7huzkzOS7khESQxZb
        o06J3BD4p9VRLnUlctpVd8Qp9IJNUmdLG5xtKcvalHsypIgaaTFIXXU2lEIGKELfDyaL4ZJdrKzYy
        keD5y0fEFZkfrkt6e3ItV/PYb8ApF1DY6leVOEmFIhWZiB0LnEMifUsGzaL7AyWcrOp6zCfSHxQXZ
        sqZjT+2nqK4T3W7a79ElCB/OQjRjkljQr6UMkhmDEvWdlfIVor1oCRIPwfDOJoSZDjaDNRjw2kU5G
        1Fq9CNkqovGiXuwibsRh+tU1EKH6T6rJBUCfedetZ/l4ra6NhQEU1bKpHktI0U/dPHnnrfnSIAAJB
        obDmWSYA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <markus.vervier@x41-dsec.de>)
        id 1ncMT1-0006jy-3X; Thu, 07 Apr 2022 09:22:07 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (684850)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1ncMSr-0000MR-H4; Thu, 07 Apr 2022 09:21:57 +0200
Message-ID: <6cb10d5e-d8f2-0d7e-a15a-4728466e0c21@x41-dsec.de>
Date:   Thu, 7 Apr 2022 09:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Derek Zimmer <derek@ostif.org>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
 <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet>
From:   Markus Vervier <markus.vervier@x41-dsec.de>
Subject: Re: Covierty Integration / Improvement
In-Reply-To: <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 4/6/22 00:17, Johannes Schindelin wrote:
> On Fri, 1 Apr 2022, Markus Vervier wrote:
>> X41 is processing the current RfP
> would you kindly provide a bit more context? This seems to come right out
> of left field. Is "RfP" a "Request for Proposals"? If so, I am not aware
> that the git developer team submitted one...

thank you and everyone else for their comments. To clear up the context:

The OSTIF (https://ostif.org) is organizing a security audit for git
and one of the questions was about Coverity and if the results it gave 
in the past could be verified and/or improved.

Many Thanks

Markus
-- 
Markus Vervier (Managing Director)
X41 D-Sec GmbH, Dennewartstr. 25-27, D-52068 Aachen
T: +49 241 9809418-0, Fax: -9
Unternehmenssitz: Aachen, Amtsgericht Aachen: HRB19989
Geschäftsführer: Markus Vervier
