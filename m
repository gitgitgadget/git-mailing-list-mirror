Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44761F404
	for <e@80x24.org>; Wed,  7 Feb 2018 16:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbeBGQwt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 11:52:49 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:50482 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754622AbeBGQws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 11:52:48 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3zc6np5Q3zz1sSw9;
        Wed,  7 Feb 2018 17:52:46 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3zc6np4tvHz1tPg1;
        Wed,  7 Feb 2018 17:52:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id r4_Q34uyz8rF; Wed,  7 Feb 2018 17:52:45 +0100 (CET)
X-Auth-Info: aOmL/5NySADmKVNsyipP2g+0va6LXnB0cm2DSkiCIyd2fqUbVOzHJA0t56sUuRU8
Received: from localhost (ppp-188-174-155-246.dynamic.mnet-online.de [188.174.155.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  7 Feb 2018 17:52:45 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 528632C1343; Wed,  7 Feb 2018 17:52:45 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Salvatore Bonaccorso'" <carnil@debian.org>,
        <889680@bugs.debian.org>, <git@vger.kernel.org>
Subject: Re: git: CVE-2018-1000021: client prints server sent ANSI escape codes to the terminal, allowing for unverified messages to potentially execute arbitrary commands
References: <151785928011.30076.5964248840190566119.reportbug@eldamar.local>
        <20180205204312.GB104086@aiede.svl.corp.google.com>
        <00b601d39f9d$7a40b820$6ec22860$@nexbridge.com>
X-Yow:  Put FIVE DOZEN red GIRDLES in each CIRCULAR OPENING!!
Date:   Wed, 07 Feb 2018 17:52:45 +0100
In-Reply-To: <00b601d39f9d$7a40b820$6ec22860$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 6 Feb 2018 17:54:37 -0500")
Message-ID: <871shwpwrm.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 06 2018, "Randall S. Becker" <rsbecker@nexbridge.com> wrote:

> What I don't know - and it's not explicitly in the CVE - is just how many
> other terminal types with similar vulnerabilities are out there, but I'm
> suspecting it's larger than one would guess - mostly, it seems like this
> particular sequence is intended to be used for writing status line output
> (line 25?) instead of sticking it in a prompt. This can be used prettifies a
> lengthy bash prompt to display the current branch and repository at the
> bottom of the screen instead of in the inline prompt, but that's the user's
> choice and not something git has to deal with. There were some green-screen
> terminals with other weird ESC sequences back in the day that could really
> get into trouble with this, including loading/executing programs in terminal
> memory via output - really. I'm sure it seemed like a good idea at the time,
> but I can see how it could have been used for evil.

Do you also want to block "+++AT"?  :-)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
