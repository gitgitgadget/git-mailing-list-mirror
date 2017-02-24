Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9965E201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbdBXXGG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:06:06 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34407 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdBXXGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:06:04 -0500
Received: by mail-lf0-f48.google.com with SMTP id k202so1006244lfe.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=26FiLMdsbquHdxag1xImBesyf6beVHp7sqI3aMReeq8=;
        b=GBFiwyrQz+1G6IVzRgAZlYOXNJ7wBi2WdlIHWXUx2uPJWyc6XNf/7gCxL2+8Ks6RF5
         Le3RCEF3mKD3UI1UMTgrzfJv1uzoYtjk5M9Z4XBXN7O2PNKAqrUE2i9OHMr0XPGHvHVb
         +PC7r851TKmODqM/Ri37YZzL+2jKNnqXr6NnRJH0j3Xt8igm91EYqghCWjvEf/Rgbl17
         S+BDe/0N2lmID+Q9tncSbSHErf5e+dy1aTUZ6OP5lVCZqIVHWgJXxdESFciHhOae4QtN
         oA1ku3TYU1+yu2uoaqQ09ksvKM+VeQEGiCHfkaSRClMA5zTsvBNg1QsDRub+mxsevAyh
         W1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=26FiLMdsbquHdxag1xImBesyf6beVHp7sqI3aMReeq8=;
        b=lS1nOB4ImTRM8cmK4nxXzvEsAxI4LYocyw1iE+sP6E3yX1rXYnGGMmQ2juEsVG1QVy
         PLT3hwIwipUd8DDxEaiKOJkLL5adYO5PoDIbSMPid9QFHFsmGMKUO72FU6mh67d9UBVd
         lDZuEeKsUCY3Pd+chkIsqIis1MVkupxxNpmT5qVTTxfnIAhXDrOSJ93gFfx3YClkicXk
         KG8HPeGuhYWeBPloEchxtSeGkd5eGqQB/DLDb6+LESkjgE9uM3fOcL4r4aLY9kZFfzJ1
         kXtduFC2c34QuTojgzjnR2lvh7jlDfC6G9QRLikCQnlOa/kRjZrg9XJmUD21sX4hzeKQ
         S8Fg==
X-Gm-Message-State: AMke39kplfZEcENyIWNIzdgrp4uQzmgGOTc5nMvJ4elkhYcnJ+bVVu0GLplvsVG8XtSeKA==
X-Received: by 10.25.159.16 with SMTP id i16mr1516970lfe.54.1487977541332;
        Fri, 24 Feb 2017 15:05:41 -0800 (PST)
Received: from [192.168.1.26] (acuy7.neoplus.adsl.tpnet.pl. [83.11.104.7])
        by smtp.googlemail.com with ESMTPSA id c76sm455268ljd.44.2017.02.24.15.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 15:05:40 -0800 (PST)
Subject: Re: SHA1 collisions found
To:     Santiago Torres <santiago@nyu.edu>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224225350.xb7rudyhowmsqdbc@LykOS.localdomain>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e0ad3c81-aa2c-2eea-eb9e-17591b6b592c@gmail.com>
Date:   Sat, 25 Feb 2017 00:05:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170224225350.xb7rudyhowmsqdbc@LykOS.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.02.2017 o 23:53, Santiago Torres pisze:
> On Fri, Feb 24, 2017 at 11:47:46PM +0100, Jakub Narębski wrote:
>>
>> I have just read on ArsTechnica[1] that while Git repository could be
>> corrupted (though this would require attackers to spend great amount
>> of resources creating their own collision, while as said elsewhere
>> in this thread allegedly easy to detect), putting two proof-of-concept
>> different PDFs with same size and SHA-1 actually *breaks* Subversion.
>> Repository can become corrupt, and stop accepting new commits.  
> 
> From what I understood in the thread[1], it was the combination of svn +
> git-svn together. I think Arstechnica may be a little bit
> sensationalistic here.
 
> [1] https://bugs.webkit.org/show_bug.cgi?id=168774#c27

Thanks for the link.  It looks like the problem was with svn itself
(couldn't checkout, couldn't sync), but repository is recovered now,
though not protected against the problem occurring again.

Well, anyone with Subversion installed (so not me) can check it
for himself/herself... though better do this with separate svnroot.


Note that the breakage was an accident, trying to add test case
for SHA-1 collision in WebKit cache.
 
Best regards,
-- 
Jakub Narębski
