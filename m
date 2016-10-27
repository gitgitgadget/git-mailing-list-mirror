Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A2420193
	for <e@80x24.org>; Thu, 27 Oct 2016 16:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941619AbcJ0QFJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 12:05:09 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44786 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936000AbcJ0QFI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 12:05:08 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3t4Wtn277Gz3hjQL;
        Thu, 27 Oct 2016 18:05:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3t4Wtn1dkSzvlV2;
        Thu, 27 Oct 2016 18:05:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id EYBHlhtHl-oW; Thu, 27 Oct 2016 18:05:04 +0200 (CEST)
X-Auth-Info: wW9eGW8sys9cvoO5vW97qqISaSVyS1Mn7dEnafb0YX5/d0ubSYJAWSKvC69rp+IO
Received: from igel.home (ppp-88-217-10-19.dynamic.mnet-online.de [88.217.10.19])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Oct 2016 18:05:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id BBE722C3E3A; Thu, 27 Oct 2016 18:05:03 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset: --unmerge
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
        <CACsJy8D4cT2EV_t6=+XTHxLmjV+NtAE+KgiN3ZiP7JQzvu29oQ@mail.gmail.com>
        <xmqqmvhsc8kn.fsf@gitster.mtv.corp.google.com>
X-Yow:  HELLO, little boys!   Gimme a MINT TULIP!!  Let's do the BOSSA NOVA!!
Date:   Thu, 27 Oct 2016 18:05:03 +0200
In-Reply-To: <xmqqmvhsc8kn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 25 Oct 2016 16:28:24 -0700")
Message-ID: <87d1il3hhs.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 25 2016, Junio C Hamano <gitster@pobox.com> wrote:

> Somebody with a bright idea decided that vc-git-resolve-conflicts
> variable should be on by default in Emacs 25.1 X-<

This is consistent with the behaviour of the other VC backends, where it
isn't even customizable.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
