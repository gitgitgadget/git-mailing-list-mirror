Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59402C433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3985E20899
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 15:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCPhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:37:10 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11953 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCPhK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 11:37:10 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jrNkS-0005pr-7J; Fri, 03 Jul 2020 16:37:08 +0100
Subject: Re: [PATCH 1/4] submodule: amend extra line feed between callback
 struct and macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-2-shouryashukla.oo@gmail.com>
 <nycvar.QRO.7.76.6.2007031653570.50@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8a36a3cd-02a3-f4fa-7b86-0d4884c88449@iee.email>
Date:   Fri, 3 Jul 2020 16:37:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2007031653570.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Suggestion...

On 03/07/2020 15:57, Johannes Schindelin wrote:
> Maybe a native reader can suggest something that flows a bit easier? I am
> not a native English speaker, but I'd prefer something along those lines:
>
> 	Many `submodule--helper` subcommands follow the convention a
s/convention a/convention that a/    feels nicer for me
> 	struct defines their callback data, and the declaration of said
s/said/that/   maybe.  'said' is a bit too much like 'patent speak', but
otherwise either word is OK.
> 	struct is followed immediately by a macro to use in static
> 	initializers, without any separating empty line.
>
> 	Let's align the `init`, `status` and `sync` subcommands with that
> 	convention.
Nice summary.

Philip
Native Yorkshire speaker, but not that 'literate' ;-)
