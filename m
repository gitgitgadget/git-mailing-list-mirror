Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218A820248
	for <e@80x24.org>; Thu, 28 Mar 2019 09:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfC1JF5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 05:05:57 -0400
Received: from insw.cz ([83.167.247.81]:41278 "EHLO insw.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfC1JF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 05:05:57 -0400
Received: from localhost (insw.cz [127.0.0.1])
        by insw.cz (Postfix) with ESMTP id 8D0A1DA4E646
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 10:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553763954; bh=ls92k724B4TDIf2PzdrZdxSu6jCgQ8K36xQI1fMjzTI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D50S8q6sNmW0ngxM2aaY29CLh0ONA3wc2XFg8Bf/8MO2Fxt5XhrqpTSVvLxyJuxkx
         /GS3O5AxxWlMDgXIptFFB6Hbmx6Pydj+SNsRFeHzC2CyYhRUZfTPn1BxYi3jVnumHH
         Jnw45oZ7JlRERkNj3bTLY2x+mHo949axiB1MaNmo=
X-Virus-Scanned: Debian amavisd-new at server
Authentication-Results: insw.cz (amavisd-new); dkim=pass (1024-bit key)
        header.d=bena.rocks
Received: from insw.cz ([127.0.0.1])
        by localhost (insw.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wbdL4Q9v8EYP for <git@vger.kernel.org>;
        Thu, 28 Mar 2019 10:05:48 +0100 (CET)
Received: from MacBook.local (83-167-247-37.static.masterinter.net [83.167.247.37])
        by insw.cz (Postfix) with ESMTPSA id 6563CDA4E62B;
        Thu, 28 Mar 2019 10:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553763947; bh=ls92k724B4TDIf2PzdrZdxSu6jCgQ8K36xQI1fMjzTI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GSy5Zk9OXDEAW6nR/0AnTNc2U85R65kERtbyTaes/I4D+a+7rcNDnRE3mYuj5ZMZB
         cvz6ksEvu9U5uf4zoQmlPib52/fXn4eEnVzMxVwohBb6VvJlLDw5B2MkO8sLL1PQDg
         l+2kv6q8wWrPtDK5wyT538JJgrZOQi/oU/F4Y3cA=
Subject: Re: Unable to change remote url of origin
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
References: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks>
 <87ef6sb102.fsf@igel.home>
From:   Petr Bena <petr@bena.rocks>
Message-ID: <9b48cd30-8e61-3c0e-292f-ac22c6d3b27d@bena.rocks>
Date:   Thu, 28 Mar 2019 10:05:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <87ef6sb102.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/03/2019 19:55, Andreas Schwab wrote:
> Do you have a URL rewrite rule (url.*.insteadof)?
>
> Andreas.
>
I don't know. How do I figure that out? There is nothing like this in my 
~/.ssh/config
