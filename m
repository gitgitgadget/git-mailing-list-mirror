Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53FCCA473
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbiFCSWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348139AbiFCSVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:21:42 -0400
Received: from mnementh.co.uk (mail.mnementh.co.uk [IPv6:2a07:4580:b0d:4f0::c573])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12A31394
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mnementh.co.uk; s=exim; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eIPQ5rfj8rkeiEplH/jFUxO5vteyM1HgqZYuDLgeyok=; b=O0o8ROFzsbQ2qtoFLwROavmM8e
        abI0/SUKj0PJ8nncWv+e1EONkBh10Zf28q6w4uWCjklF8yze/18vuEpPMHVxu87uNXm681PZaG27O
        AFZ8ev/XrZ3KwnpulRIBevr9kkvozBNMcMIoe7CgGSps9ntsLJVWbQ1aheL1SuIjzDNDCymErBmE8
        yUL3sdgpdRgcq9VNBB4BkmhA7yQyQAW40RQV55feA68gOvcBx2MR3XIZ99vDYYWPiivqFWiKsL5CI
        niT0Votm9tBEjLkFBsvHZWkPhNdzBXQR2hJDIqHogvQ+7iAikn31Z/qr1RCmVX6fLQTwxHmWVrSWO
        b10d0IyQ==;
Received: from 115.24.187.81.in-addr.arpa ([81.187.24.115] helo=[192.168.1.64])
        by mnementh.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git-ian@mnementh.co.uk>)
        id 1nxBgt-009Va5-8o; Fri, 03 Jun 2022 19:06:30 +0100
Message-ID: <9df6c37e-4c43-7697-0562-c49d4fa5b38f@mnementh.co.uk>
Date:   Fri, 3 Jun 2022 19:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: AW: git log on bare repository fails if the default branch is not
 called master
Content-Language: en-GB
To:     stefan.naewe@atlas-elektronik.com, git-ian@mnementh.co.uk,
        git@vger.kernel.org
References: <a1830e79-9503-3fd9-8c50-a2856206e219@mnementh.co.uk>
 <48bcd99afbca4c73b938c3ed4e104c64@atlas-elektronik.com>
From:   Ian Molton <git-ian@mnementh.co.uk>
In-Reply-To: <48bcd99afbca4c73b938c3ed4e104c64@atlas-elektronik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 15:40, stefan.naewe@atlas-elektronik.com wrote:

> I bet the HEAD file in your bare repository points to refs/heads/master...

Possibly, but why? the only thiong that ever happened to was that I
pushed my code into it, from a repo that used mainline (not master).

Why does a bare repo even have a HEAD file? (genuinely curious). It
seems like it'd be best to create it when it's first pushed to? then
it'd match whatever is used in the pushing repo...

-Ian
