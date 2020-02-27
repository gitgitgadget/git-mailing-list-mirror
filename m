Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DE3C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1957E246A9
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="QalKWLU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgB0Rju (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:39:50 -0500
Received: from web0081.zxcs.nl ([185.104.29.10]:37650 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgB0Rju (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 12:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LLPyCoSVN/fXI0Kw2Ei0rLXbO+3PdOZ+R3C5I8AbPV8=; b=QalKWLU8HZ433KOZq76zWztV7S
        3+ZjnuCm9jVbY7Jbx7WcgXhwOLT7mswp9H+xWIONh4lTrms5biEQEuKJW+b3m08QDWD11LLTN1Ud6
        F8q4vz6RYQMdSkfgd8vaeDeoCxKRZyFHYyv7Z++44fIUzlCjgkK2RwN7Uwy6fEwU8N/nTXDtUE7w7
        3Hd9fUiuKCdcFF4jZWVeKKCL3tV/va+fQFmVzWaKxmVkwbYRo/LZoNv4LjNvc3CaqDuvGjSXQPrzY
        M0WkJQvnUxBHUzWqZemRPhRWbdANVI3U2qOKLEK5wL6C3B0WuYrTK1hTc5L9jHhUOPUHOlOq8NltV
        uCPgmNbQ==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:48636 helo=mail-slave03.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1j7N8S-003mPi-OV; Thu, 27 Feb 2020 18:39:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Feb 2020 18:39:44 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-remote: don't use '-h' for options
In-Reply-To: <xmqqa754gger.fsf@gitster-ct.c.googlers.com>
References: <b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl>
 <20200227130833.GA10339@danh.dev>
 <03985e4099e82f04709d5ea9ca2a56a6@pascalroeleven.nl>
 <xmqqa754gger.fsf@gitster-ct.c.googlers.com>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <74969200f4dd2993eece8308a72546c3@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-02-27 17:10, Junio C Hamano wrote:
> Yeah, I tend to agree that documentation could be better.
> 
> You may think that nobody would ask your opinion, but proposing a
> change by sending a patch often makes you heard around here ;-)
> 
> Thanks.

Well, that's good to know :)

> Subject: [PATCH] Documentation: clarify that `-h` alone stands for 
> `help`

Although I still don't quite agree with the inner workings of this 
command (but I understand the choice because of 
backwards-compatibility), this extra documentation will definitely 
eliminate confusion.
