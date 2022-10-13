Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4D1C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 10:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJMKyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMKyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 06:54:37 -0400
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C91510536A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:54:34 -0700 (PDT)
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
        by wilbur.contactoffice.com (Postfix) with ESMTP id D5FEF3413;
        Thu, 13 Oct 2022 12:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665658469;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=Message-ID:Date:MIME-Version:References:Cc:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=684; bh=eHeEzFCxS+ZXnk6RgfzWJzrS6/oWb+Xx1YzDr2XrApU=;
        b=fkGPSVTf6W/GLzqKnBVUDyZZtrvs5FVu9aci7icDfp5rGk7nfj/poD+E5VNaf6ih
        oIqFucBuVnVtos0Cxh17km7n6hI2gqGy6lsNH0Vh2/e8dzYkg1sFNeHJhLFse1Sak/N
        jtc4k+R5kK44UPdRsGj6S1s6TojmLHnALzhOd/iXLkBb3XVBnl6+pQuVb7VZvKgjmVc
        HhlQR4yCNmEbm0Rm2vOPtCwQk3i30HafuL+UjiZeXBEqbQ0Tj/MdSjurD7uKukN/b6b
        7WKrW46Xrm8sM0mseAisEzB3uiBTzFpm6VY9WXq0NpSzynj1PL6xlMkhfY2PM7752dO
        6dDp/kunGg==
Received: by smtp.mailfence.com with ESMTPSA ; Thu, 13 Oct 2022 12:54:27 +0200 (CEST)
Message-ID: <543353ff-981d-9804-3abb-d29caa8300ba@wired4ever.net>
Date:   Thu, 13 Oct 2022 12:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3] docs: git-send-email: difference between ssl and tls
 smtp-encryption
To:     Junio C Hamano <gitster@pobox.com>
References: <20221012150619.12877-1-sndanailov@wired4ever.net>
 <Y0cxPHNZjTqZR5XE@tapette.crustytoothpaste.net> <xmqqy1tkiuye.fsf@gitster.g>
Content-Language: en-US
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, aaron@schrab.com, philipoakley@iee.email
From:   Sotir Danailov <sndanailov@wired4ever.net>
In-Reply-To: <xmqqy1tkiuye.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:378009619
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed 12 Oct 2022 23:38, Junio C Hamano wrote:
> not because it is common to use randomly numbered ports.

Yes, good point! Also I feel the description might become
a bit too bloated if we squeeze in the reference.
Although I'm not against adding it as well, it will make
things a lot clearer for sure.

There's also the issue with the commonly found alternative
port 587, which I feel might be better fixed by making the
script test for it as well if the first default fails.

I don't mind making a v4, but from the responses it seems
there's no need?

Thanks everybody for the input, helping me with the
patches and for the fast responses, I really appreciate it!
