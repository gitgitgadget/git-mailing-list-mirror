Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0009E20441
	for <e@80x24.org>; Wed, 28 Dec 2016 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbcL1TIm (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 14:08:42 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:36208 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbcL1TIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 14:08:37 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3tpj174t4hz3hjdF;
        Wed, 28 Dec 2016 20:07:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3tpj174RfTzvkG0;
        Wed, 28 Dec 2016 20:07:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id Z0b1zoe_yzRs; Wed, 28 Dec 2016 20:07:54 +0100 (CET)
X-Auth-Info: fnCFY8ifUp0thU0NAAJ2odYKSZkXeTmr2llbSc3Rlbo57u8KjbB5PRATOYe3f/2x
Received: from igel.home (ppp-88-217-8-223.dynamic.mnet-online.de [88.217.8.223])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 28 Dec 2016 20:07:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 4C3DE2C48A9; Wed, 28 Dec 2016 20:07:54 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
References: <20161228183501.15068-1-ehabkost@redhat.com>
X-Yow:  My BIOLOGICAL ALARM CLOCK just went off..  It has noiseless
 DOZE FUNCTION and full kitchen!!
Date:   Wed, 28 Dec 2016 20:07:54 +0100
In-Reply-To: <20161228183501.15068-1-ehabkost@redhat.com> (Eduardo Habkost's
        message of "Wed, 28 Dec 2016 16:35:01 -0200")
Message-ID: <871swrg9dh.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 28 2016, Eduardo Habkost <ehabkost@redhat.com> wrote:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 12879e402..f22f10d40 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
>  SYNOPSIS
>  --------
>  [verse]
> -'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
> +'git am' [--[no-]signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
>  	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
>  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
>  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
> @@ -32,10 +32,12 @@ OPTIONS
>  	If you supply directories, they will be treated as Maildirs.
>  
>  -s::
> ---signoff::
> +--[no]-signoff::

That should be --[no-]signoff, as in the synopsis.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
