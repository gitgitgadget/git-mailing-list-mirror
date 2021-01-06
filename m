Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478CC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEDC2313E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbhAFWCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:02:36 -0500
Received: from mailscanner.iro.umontreal.ca ([132.204.25.50]:46629 "EHLO
        mailscanner.iro.umontreal.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbhAFWCg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jan 2021 17:02:36 -0500
Received: from pmg2.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
        by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 6235C807E8;
        Wed,  6 Jan 2021 17:01:55 -0500 (EST)
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
        by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 1D94280381;
        Wed,  6 Jan 2021 17:01:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
        s=mail; t=1609970514;
        bh=cbMpEhWneN6k+ytmuNfXQTHLZgl1qcP8NcU0m/2u368=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Oj47SjzIpj8E1hxnadyvzBDVGjxrns4ioq4DUY9v9e/gSMT4CVmEqt8dZBGjVY60e
         n/Fa680+sm0sq9E2NUTH3okbR+pl+Qkqu4sZWAvFSm3aZpPrIBw5xRg8XwNXZzsafW
         85JqM0rkWWrPz3OnTANRnGmSoMUPMvYSsXaSpEo7l3JIiAykRiv50mwL+yLHYX2R59
         HPhShg1yrycUgujilXfV0DeoibYg7rRCx1mMesVAKycNucAqcpnHAcphalbLbO+y1c
         CxIrCXH25X6BPOlJ5PvViW84cfKBEWdv/+AoLozdR4wRq2a7o56GMP+M879e/WtZtc
         V4Zug0Bx6GaLg==
Received: from alfajor (unknown [45.72.224.181])
        by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id C11DC120229;
        Wed,  6 Jan 2021 17:01:53 -0500 (EST)
From:   Stefan Monnier <monnier@iro.umontreal.ca>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
Message-ID: <jwvv9c9rakf.fsf-monnier+Inbox@gnu.org>
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        <xmqq1rexrbz1.fsf@gitster.c.googlers.com>
Date:   Wed, 06 Jan 2021 17:01:52 -0500
In-Reply-To: <xmqq1rexrbz1.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 Jan 2021 13:29:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yes, a need to have multiple unrelated line of histories in a single
> repository may not be there, even though a desire to do so might
> exist.  What is done with these unrelated histories that record
> unrelated contents [*1*]?

For the record, my use cases are basically subtrees of the project
stashed in submodules instead of being kept as subdirectories in the
main branch (the purpose being to be able to easily share&sync those
subtrees between different projects).


        Stefan

