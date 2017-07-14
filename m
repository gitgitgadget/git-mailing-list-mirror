Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C146C20357
	for <e@80x24.org>; Fri, 14 Jul 2017 13:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbdGNN3w (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 09:29:52 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54072 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbdGNN3w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 09:29:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3x8D7f1qwRz1qtx2;
        Fri, 14 Jul 2017 15:29:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3x8D7f0LR9z3jgY4;
        Fri, 14 Jul 2017 15:29:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id JzEJF-yCvl7z; Fri, 14 Jul 2017 15:29:48 +0200 (CEST)
X-Auth-Info: sSxjkHnNXkwWY6vyKF7bh1bqTPiTj2Sz8T8O1PxmvK6qCrLHgHf8OU0GKbm8pFaQ
Received: from igel.home (ppp-88-217-24-38.dynamic.mnet-online.de [88.217.24.38])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 14 Jul 2017 15:29:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 777C72C2637; Fri, 14 Jul 2017 15:29:47 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Elliot Chandler <worldpeacehaven@gmail.com>,
        Lutz Roeder <lutz.noreply@gmail.com>, peff@peff.net,
        git@vger.kernel.org
Subject: Re: Git on macOS shows committed files as untracked
References: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
        <914898a3-24da-403a-8e1c-e90b53df46a9@web.de>
        <CAHVrscDg8bc-CYm6dSJFgdPSv1vJ0=AC0s3y26CHctKkYAvJyA@mail.gmail.com>
        <8b5fc22c-4d65-d34a-a84c-c913f454c771@web.de>
X-Yow:  When you said ``HEAVILY FORESTED'' it reminded me of an overdue
 CLEANING BILL..  Don't you SEE?  O'Grogan SWALLOWED a VALUABLE
 COIN COLLECTION and HAD to murder the ONLY MAN who KNEW!!
Date:   Fri, 14 Jul 2017 15:29:47 +0200
In-Reply-To: <8b5fc22c-4d65-d34a-a84c-c913f454c771@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 14 Jul 2017 14:35:52
 +0200")
Message-ID: <87vamvf8ok.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 14 2017, Torsten Bögershausen <tboegi@web.de> wrote:

> (Please no top-posting)
> On 14/07/17 11:45, Elliot Chandler wrote:
>> For what it's worth, the file looks normal in Gentoo GNU/Linux (name
>> appears "ḋἲ╓εﮯ𒑏○╓Ӳ" and it seems to work like any other directory).
>>
> Thanks for testing -
> Normal and Normal ;-)
> For me the 6th code point does look strange
> The "box" with 04142F:

This is actually 1244f (CUNEIFORM NUMERIC SIGN ONE BAN2).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
