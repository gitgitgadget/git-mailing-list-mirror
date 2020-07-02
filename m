Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BDC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E8E20702
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="aOsMvcoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgGBTCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:02:00 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.113]:27499 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbgGBTCA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Jul 2020 15:02:00 -0400
X-Greylist: delayed 1432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2020 15:01:59 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id C729043FEC09
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 13:38:05 -0500 (CDT)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id r461jUlHqSxZVr461jV4a9; Thu, 02 Jul 2020 13:38:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r/n4e6K/Mcon4goWeipGyq7+7Wmh1cDTgsBLwJZKT1Y=; b=aOsMvcoZnMzX3VV83YZ1QnE1z5
        OTq8qLjIkPcs8ABPqyOTCb6U+IiDjr9Svr1ZrqIsBbPAM6ZQM2ZwbbkWIK4nrVzCnRA1OeQWyQTXc
        BHEtf4y3j5waLlK397PnySCCT;
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:56270 helo=pdslaptop.home)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <paul@mad-scientist.net>)
        id 1jr460-00166T-VR; Thu, 02 Jul 2020 12:38:05 -0600
Message-ID: <03bd4b4e9b172c4ee6cb44653bb9c5b26df76445.camel@mad-scientist.net>
Subject: Re: Is git compliant with GDPR?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jakub Trzebiatowski <cubuspl42.1@gmail.com>,
        Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org, Matthew Horowitz <mhorowitz@pdinc.us>
Date:   Thu, 02 Jul 2020 14:38:03 -0400
In-Reply-To: <CAAF2pWb8Namk1rpm4==PUrq4ft9fp4eD=t9WyMLv56dPZuGk2g@mail.gmail.com>
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>
         <0e9801d6508d$c1f55560$45e00020$@pdinc.us>
         <CAAF2pWb8Namk1rpm4==PUrq4ft9fp4eD=t9WyMLv56dPZuGk2g@mail.gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 98.118.0.140
X-Source-L: No
X-Exim-ID: 1jr460-00166T-VR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-98-118-0-140.bstnma.fios.verizon.net (pdslaptop.home) [98.118.0.140]:56270
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2020-07-02 at 19:06 +0200, Jakub Trzebiatowski wrote:
> But you said that git itself (as a software) doesn't fall under GDPR,
> and that's the only thing I'm not sure about. I was wondering if
> someone with a deeper understanding of GDPR would tell my _why_. 
> Because when interpreting the law literally, it sounds like it does.

You might be interested in reading the conversation that was had on
this list the last time this subject was raised, in 2018:

https://public-inbox.org/git/5587534.o6tcmYBVvN@mfick-lnx/T/

I can't say whether it will satisfy you or not.

