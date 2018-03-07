Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F167B1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbeCGWG4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:06:56 -0500
Received: from mail.netzguerilla.net ([217.11.57.120]:55375 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933251AbeCGWGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:06:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 69A9D100019;
        Wed,  7 Mar 2018 23:06:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([IPv6:2a00:1828:2000:612::25])
        by localhost (sal.netzguerilla.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id Gv-ZmAk_ahLK; Wed,  7 Mar 2018 23:06:53 +0100 (CET)
Received: from [IPv6:2003:dd:ff29:a301:1c94:69ca:ad13:165a] (p200300DDFF29A3011C9469CAAD13165A.dip0.t-ipconnect.de [IPv6:2003:dd:ff29:a301:1c94:69ca:ad13:165a])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 0ACEE100012;
        Wed,  7 Mar 2018 23:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1520460413;
        bh=ChToORyThJR2Lvyh0WwNy53wH29TKM54CoXta8AjWss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KTflPAzH9NFwo0vmRaENHkib07pZ1D1TWqhgj56BnsSIdMdkAZg2R3AwS0b8Px372
         xFQ/BtbMgwxPJa6vRKwoRAnk56WFwXOWXJlZKojV5GgwGtKGTuIDuYhLEUyD4isTSO
         mxlKZy0JFJ5A5B79Sgs4KoZX88RYaE6Tr+GhXNvpZKhdzuRIjCS3fQXkpJHvZziDPc
         eXxcmm8rifK5LTi9ky4n1sjyECx29APR9Vimt3waCU9PEc9VEdldHN0t3mwG98qguw
         tTBCrod2MYdvdSi4DN75pCH3YZDBXNS1nfvm5Lfe2vcaZorBoz8c5cj4zkENlVlvKX
         Mo6gTnxNSJO7A==
Subject: Re: man gittutorial: patch proposal
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
References: <d34357b0-45a4-d22b-9a53-1a376addbd53@projektwerkstatt.de>
 <20180305232531.GH28067@aiede.svl.corp.google.com>
From:   kalle <kalle@projektwerkstatt.de>
Message-ID: <add4c7a8-eeda-6388-e417-7b24bde397e4@projektwerkstatt.de>
Date:   Wed, 7 Mar 2018 23:06:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180305232531.GH28067@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hello.
1.I understood, that verbose commands are quoted in ` ' or ' '. While
the points I changed are not verbose commands. Therefore I didn't see
any sense in them. Because of the different quoting ways (e.g. `merge`),
I thought that someone didn't understand the quoting concept. But it
could also be me...

2.yes please. I will read this section.

kalle

Am 06.03.2018 um 00:25 schrieb Jonathan Nieder:
> Hi,
> 
> kalle wrote:
> 
>> see attachment.
> 
> Thanks for writing.  A few questions:
> 
>  1. Can you say a little more about the rationale for this change?
>     E.g. is the current formatting sending a confusing message?  Is the
>     current formatting intending to use '' as quotes and using italics
>     instead?  If so, should this use "" to fix it?
> 
>  2. May we forge your sign-off? See the section "Certify your work"
>     in Documentation/SubmittingPatches for more about what this means.
> 
> Thanks,
> Jonathan
> 
