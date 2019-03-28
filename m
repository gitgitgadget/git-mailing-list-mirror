Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23D220248
	for <e@80x24.org>; Thu, 28 Mar 2019 11:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfC1L5R (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 07:57:17 -0400
Received: from insw.cz ([83.167.247.81]:47057 "EHLO insw.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfC1L5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 07:57:17 -0400
Received: from localhost (insw.cz [127.0.0.1])
        by insw.cz (Postfix) with ESMTP id 896B4DA54130
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 12:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553774234; bh=1TuGMqJNM7U8C6oHr5uohKCMAwbBXpHjriLebEYeoBc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=e+SMCq3xoxJyBrjWiIt5qfUO0yhoN49iZll1TQ2wus2v3IyufL/kdblcPSfHH2xyB
         OCYQiF+wS19DsD7ffZd9jg5WCh6Vc/Q32BUx/z/kSv6JrnTxQGSfAE9YiXrBLUPl3c
         NTqkV/URPXrK2UJhEIOstzxPTL1+VnRVuv4oEIzg=
X-Virus-Scanned: Debian amavisd-new at server
Authentication-Results: insw.cz (amavisd-new); dkim=pass (1024-bit key)
        header.d=bena.rocks
Received: from insw.cz ([127.0.0.1])
        by localhost (insw.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LhoA5_-4fWWe for <git@vger.kernel.org>;
        Thu, 28 Mar 2019 12:57:13 +0100 (CET)
Received: from MacBook.local (83-167-247-37.static.masterinter.net [83.167.247.37])
        by insw.cz (Postfix) with ESMTPSA id 44829DA54129;
        Thu, 28 Mar 2019 12:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553774233; bh=1TuGMqJNM7U8C6oHr5uohKCMAwbBXpHjriLebEYeoBc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=JTAD+OoxrS3nTdB2PzAluaOIHbDV3DGHVpFNt6w3CnN+opwRkV7/VRfe9j/LTAyDn
         OermTDFe7ZHY/Mswb8TLXyHu6XSRw7+6FftBmqLGpY8xR0vHPXgCrx0xkdrVpY2K5D
         OUlwz7FQE03lMHtto+QEytKYxPLFZvHoyYkSz5hs=
Subject: Re: Unable to change remote url of origin
From:   Petr Bena <petr@bena.rocks>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
References: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks>
 <87ef6sb102.fsf@igel.home> <9b48cd30-8e61-3c0e-292f-ac22c6d3b27d@bena.rocks>
Message-ID: <0ff79a1b-0c5f-397c-dd68-94234a2a9ac4@bena.rocks>
Date:   Thu, 28 Mar 2019 12:57:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <9b48cd30-8e61-3c0e-292f-ac22c6d3b27d@bena.rocks>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/03/2019 10:05, Petr Bena wrote:
> On 27/03/2019 19:55, Andreas Schwab wrote:
>> Do you have a URL rewrite rule (url.*.insteadof)?
>>
>> Andreas.
>>
> I don't know. How do I figure that out? There is nothing like this in 
> my ~/.ssh/config
Oh you were right I found it in git config --list, removing this from 
.gitconfig fixed the problem, no idea how did it get in there
