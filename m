Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011791F7D2
	for <e@80x24.org>; Sat,  3 Jun 2017 01:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdFCBUn (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 21:20:43 -0400
Received: from renepasing.de ([5.9.148.133]:60724 "EHLO mail.renepasing.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbdFCBUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 21:20:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.renepasing.de (Postfix) with ESMTP id 3A3981001D9A;
        Sat,  3 Jun 2017 03:20:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.renepasing.de
Received: from mail.renepasing.de ([127.0.0.1])
        by localhost (mail.renepasing.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2-gs1cP-uyjG; Sat,  3 Jun 2017 03:20:39 +0200 (CEST)
Received: from [IPv6:2a02:908:1064:9240:224:beff:fe38:eaca] (unknown [IPv6:2a02:908:1064:9240:224:beff:fe38:eaca])
        by mail.renepasing.de (Postfix) with ESMTPSA id 0BD171000559;
        Sat,  3 Jun 2017 03:20:39 +0200 (CEST)
Subject: Re: Wrong gitattributes documentation?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <e7734a23-12b2-8f62-ab5c-c856d59e3010@pasing.net>
 <xmqq8tlax7lm.fsf@gitster.mtv.corp.google.com>
From:   Rene Pasing <rene@pasing.net>
Message-ID: <2dc4c436-0886-ec05-7a4f-e051bbfbc49f@pasing.net>
Date:   Sat, 3 Jun 2017 03:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tlax7lm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2017 02:01 AM, Junio C Hamano wrote:
> Your "/images/*" is the "Otherwise" case, isn't it?

Ok, sorry, didn't read your answer thoroughly enough the first time.

The problem is, when I have an entry in .gitignore like this:
/images

Then git will ignore that whole directory (and all of its subfolders
etc.). Git will just ignore everything in the tree starting with that
pathname.

But when I use the same pattern ('/images') in .gitattributes I would
expect (due to the documentation) that git-lfs will be called for all
files+subfolders+subfolderfiles and even the folder itself (this is what
I understand from 'The rules how the pattern matches paths are the same
as in .gitignore files').

This does not seem to be the case!

Sorry again for the confusion.

