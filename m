Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE0CCA47E
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiFCSQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346928AbiFCSN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:13:58 -0400
Received: from mnementh.co.uk (mail.mnementh.co.uk [IPv6:2a07:4580:b0d:4f0::c573])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681172ED7B
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mnementh.co.uk; s=exim; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WYPlA1hH0joxYwbiJEc5/Y4JpRW/CgytbQ139r33qLo=; b=MWSv0LvnlfzsT80MU7ica5q4bl
        aHuRapqUbvjfhmF5xENCmQE8rnSqtAV6pfqjgocfvG2smK74mco1FJxfEK8hRsH77NLm56Jm79wXt
        9Rw7DkgcWSyHSYo6HL620O4BiXqp5Ytr063v3Rwfw/hVuWjJDLCkqcffDC2S+q/DRphpf3A8a1dAO
        UPMT8w0J5ERUpCEAARGdG7DKd2RYiWj3hAxdRZmS3HjPnySd3ledJ0eQytr06ydaOUolQochIzQYX
        LAzKNGA7XK7N61m8EFPtYKEm+f2mpyxBPApo4tRHE2EBlHxnwPVIl0ZapgTPm4PNWDa56YW1XEC6t
        bo2vgJ0w==;
Received: from 115.24.187.81.in-addr.arpa ([81.187.24.115] helo=[192.168.1.64])
        by mnementh.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git-ian@mnementh.co.uk>)
        id 1nxBdP-009VXu-V5; Fri, 03 Jun 2022 19:02:55 +0100
Message-ID: <d3689677-8a9a-a324-1a3a-2dab9f9390ba@mnementh.co.uk>
Date:   Fri, 3 Jun 2022 19:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: AW: BUG report: git-gui does not show commit message templates
Content-Language: en-GB
To:     stefan.naewe@atlas-elektronik.com, git-ian@mnementh.co.uk,
        git@vger.kernel.org
References: <870137b1-9134-5791-d9fa-4826687e0781@mnementh.co.uk>
 <dfec506780af46639ed67be364cd43cb@atlas-elektronik.com>
From:   Ian Molton <git-ian@mnementh.co.uk>
In-Reply-To: <dfec506780af46639ed67be364cd43cb@atlas-elektronik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 15:36, stefan.naewe@atlas-elektronik.com wrote:
>>
>> Hi,
>>
>> Please CC: me in replies, I'm not a list member.
>>
>> I've just found that git-gui does not show commit templates.
>>
>> I've checked and found this commit:
>> 627c87f84c157885d587125cf0c73591a0e3ee7a
>>
>> which suggests to me that the issue should have been fixed, but it clearly has not.
>>
>> I've removed git-gui from the system (Ubuntu package), and compiled the latest
>> mainline git-gui (as of today), and the problem remains.
> 
> It seems that git gui wants to load the template file from (or relative to) the .git directory.

Hi,

I tried copying the file into .git/ and ~/ but it still did not pick it up.

-Ian
