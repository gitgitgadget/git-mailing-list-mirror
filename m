Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6904B200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 07:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbcL2H6n (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 02:58:43 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33562 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbcL2H6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 02:58:43 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3tq26S4BzMz3hjQZ;
        Thu, 29 Dec 2016 08:58:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3tq26S3pxKzvkKH;
        Thu, 29 Dec 2016 08:58:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id ThuJeY6zBk3o; Thu, 29 Dec 2016 08:58:39 +0100 (CET)
X-Auth-Info: XMptR6XjRwQCNDtfDeBmIihlfxCi3nO2iMoqN560hpNifAHb1VbpV0hvgrw5kvE+
Received: from linux.local (ppp-88-217-0-226.dynamic.mnet-online.de [88.217.0.226])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Thu, 29 Dec 2016 08:58:39 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
        id DBCE11E546A; Thu, 29 Dec 2016 08:58:37 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3] am: add am.signoff add config variable
References: <20161228225544.16388-1-ehabkost@redhat.com>
X-Yow:  On the other hand, life can be an endless parade of TRANSSEXUAL
 QUILTING BEES aboard a cruise ship to DISNEYWORLD
 if only we let it!!
Date:   Thu, 29 Dec 2016 08:58:36 +0100
In-Reply-To: <20161228225544.16388-1-ehabkost@redhat.com> (Eduardo Habkost's
        message of "Wed, 28 Dec 2016 20:55:44 -0200")
Message-ID: <m2wpejb1zn.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 28 2016, Eduardo Habkost <ehabkost@redhat.com> wrote:

> @@ -32,10 +32,12 @@ OPTIONS
>  	If you supply directories, they will be treated as Maildirs.
>  
>  -s::
> ---signoff::
> +--[no-]-signoff::

That's one dash too much.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
