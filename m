Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59E420986
	for <e@80x24.org>; Sun,  9 Oct 2016 09:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbcJIJEG (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 05:04:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:54921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752787AbcJIJEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 05:04:05 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lx8vJ-1anVQh2Aaf-016dB8; Sun, 09 Oct 2016 10:57:22
 +0200
Date:   Sun, 9 Oct 2016 10:57:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the
 script
In-Reply-To: <5ed8aaea-9fbe-11b0-49b7-1b42567d4918@kdbg.org>
Message-ID: <alpine.DEB.2.20.1610091054490.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de> <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de> <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609121019290.129229@virtualbox> <xmqqr38p3z1i.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610061459390.35196@virtualbox> <5ed8aaea-9fbe-11b0-49b7-1b42567d4918@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nvQUNwu6605Z2kik28YDCOe4JIDhRDl4MamyBtIs00LK8mRPXrA
 AUvlnKEVaMkWwns5BplR9WY9kV7SV19vtPTfz5XGk4lOg+3ar7q9rFLigYCtON4Lt/TdelG
 B9FubqDlO99Botso1Y/5KNTuOmB4U51m7/feZkPOaMMAJ3UrlVCtgmG8jxK6Qvn1NxXDNuR
 UrCof8z1A0NiLYVLKvrbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fejcEk4ZZJ8=:n2Q6EKl67/INE+Xm2Jx6DV
 cNmCbsokj4hLoMi3lOFL9BIq09eukUWTCre29DB5xdDOqdNAOWs8+91bL3WDV1zgEig5ZfhUP
 JzoVaRcOks1R9xo/NOQUPU9fxgoG06Ii95nGNeJG7SEKcRfhK63nFfT8k24Z7Cwl3TkMAmeIh
 PvK+LdFpYaO6bzKeAcnjFzKgQbUWrVeFV8vrC7Tej7q5K4JlazmlEOtEtwE///de8HgPBI+LB
 OOzfThQZTE1PEc2SVUVLyYa7XJI8hktlJkKSvoPVmHjNvlr1Rx5m4KArecoQxrhS8ZHDYMyuJ
 AK9zQYbVWCwhf0Gc2XkcBea7ncOWvJtsQ0te71ISKVvwsVGdhPOERp116yWosvEmuxtr9jYgK
 Wtqcz9mOdkauf3Ptqk4p1wOoYJszgi0JWVlkOQDky+7CqGly6YaalHypjMlgzPdaI0WS1jTKU
 UqUzuadwTBH1EUt1V0bkvWLUuKRMU984DcL21Xa6MvUv1Zr5wH0ZKYPlkrBCE5O/laIcQibwj
 ju9ZCkx1bmSwiKfQLfII0wLpM3uzq/0p9kIOl3zPhRDr0i16NflJlhMHRh7PQ1e61VIzNzI/p
 5kTwxZ1q9gAW5Emc/pqDfEbMCYhMbpHznpBb9oUiFSRtVZZXrkdJWkWMc1lGc56xGN2E2s0jp
 uKeOhoFSqXYqbBlbmGNTSxfNMcX4qEoqPRWsI4n641zr3GuV5qCpv1GOrPdvykPAlGrrWLGMm
 mslOH4myywP88+SWEnRxU+ci1saRI7k6/a2cY0W8Zmxd6QMoXqlUhcQSxxGBVpBMdHlrTP47o
 8MTlJRr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 6 Oct 2016, Johannes Sixt wrote:

> [PATCH] sequencer: strip CR from the end of exec insns
> 
> It is not unheard of that editors on Windows write CRLF even if the file
> originally had only LF. This is particularly awkward for exec lines of a
> rebase -i todo sheet. Take for example the insn "exec echo": The shell
> script parser (either of the sequencer or of the shell that is invoked,
> I do not know) splits at the LF and leaves the CR attached to "echo",
> which leads to the unknown command "echo\r".
> 
> Work it around by stripping CR before the command specified with exec is
> passed to the shell.
> 
> This happens to fix t9903.14 and .15 in my environment: the insn sheet
> constructed here contains CRLF thanks to MSYS1's bash cleverness.

Good point. I decided to do it at a different level, though:
parse_insn_line() should already receive the line without trailing
end-of-line markers (this was already the case for LF-only todo scripts).

I reused your commit message and touched it up a bit, hope you don't mind!

Ciao,
Dscho
