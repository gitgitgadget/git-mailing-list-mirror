Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8594BC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 15:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJKPwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJKPwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 11:52:06 -0400
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB63BF40
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 08:49:51 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by wilbur.contactoffice.com (Postfix) with ESMTP id B2C052D51;
        Tue, 11 Oct 2022 17:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665503389;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=Message-ID:Date:MIME-Version:From:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=401; bh=HmeHnovVcyRmP0fOTy0vUx73/d4ZxkHQAs8ATFIlm2s=;
        b=MsrB+3l0KMLUWpXeLVcA3z0CwwzkigMXVLiT/ydo68KN9XCtzxJfw2dXyxswKN52
        CjiGjgyijRP8ZMHKYm21EMD5GV905KtylBqzHqV8i2JoSwHQo9dYAGtvOBr/iQ2ld1R
        nzd63JfW/2j91rcPif46RDhNlcL1dleARxSJJL8K73YdGZbCPdT5h5IL7GufVGc3tWv
        R/c/l84KQiq12K2vEaJZ1CpQTp7sNqGURJMrZTqUmkYX2ZD5oOa7CqhqINyctsVkrV2
        9YWLKopOvrl9Q6n4Qbjg6qhocsdfkkcuDmtOL0XpcmkyVk6HosR7/HgBpeMSekT8LJv
        FjcXOLJG3g==
Received: by smtp.mailfence.com with ESMTPSA ; Tue, 11 Oct 2022 17:49:47 +0200 (CEST)
Message-ID: <7f62a170-c3cf-0911-5c76-2b2565674189@wired4ever.net>
Date:   Tue, 11 Oct 2022 17:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Sotir Danailov <sndanailov@wired4ever.net>
Subject: Re: [PATCH] docs: git-send-email: difference between ssl and tls
 smtp-encryption
To:     Aaron Schrab <aaron@schrab.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com
References: <20221010172859.13832-1-sndanailov@wired4ever.net>
 <Y0R2AwKuXAVMP5Ma@tapette.crustytoothpaste.net> <xmqq35bvz10b.fsf@gitster.g>
 <Y0S2wyfUF1mZaryi@pug.qqx.org>
Content-Language: en-US
In-Reply-To: <Y0S2wyfUF1mZaryi@pug.qqx.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:378009619
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue 11 Oct 2022 02:20, Aaron Schrab wrote:
> uses port 25 by default, but port 587 is often used as well

Well, I was trying to explain that the script would default to that port.
I like your idea as well, but I'm not sure if it will make things clearer.
I'm making a second version of the patch now. I will try to balance out
all of the ideas into something I feel might be easy to follow.
