Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63489C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AFD64F64
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhCIURv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:17:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:35845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCIURU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615321035;
        bh=xAsk0zI36xTvuB5gG1Ya4P1n/FspSLWNAOKQ45bQvII=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KT+oIGLXk0TxOwAZzOn8gpXGnVX4NEF/Mwb/KrP3LJCUV2g1TpYDnVowLu2MA42e4
         x0uZaHbx22iViiaNiQvl1Co/hfOxhF3xjs9DDi+h9QpYHegcqTBfDw0N0yYclcHGgk
         ZkgjciliH26TehCXe7rfcu9ZJLmRhrzL60C/P/Fk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.185.139] ([89.1.215.248]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1lNHAG2B87-005Kk1; Tue, 09
 Mar 2021 21:17:15 +0100
Date:   Tue, 9 Mar 2021 15:40:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.31.0-rc2
In-Reply-To: <xmqqblbs19uf.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2103091537530.50@tvgsbejvaqbjf.bet>
References: <xmqqblbs19uf.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p9woW0xEzsLDEA5uxMUkEL2sw/NR2f1UyuTshRvWXCgR5a1FT7z
 1bPHn3C1r9g4Dfpv+3ShbVSFUoQZyLD04a9QQI0G1WgiopGub/LDGlZzUoqL/MTQ7PRKjtJ
 kD3tlMj53l1VTBWLvz09ypsFsVTBn21t7rd7sivRv4aj0u4YQy61hkPFU/hxsLw0+m8tLym
 NX/djMlTTk6KVGBipTbKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PW5Alzb0pWI=:Tdlj+EvYWbOzCLZJ4XX18Y
 tjoLL4A3uU2BOeqv2DgqIGxPGTrnErEVgXCvmATv8Md9uwyhlQ9WmotBgKdMdz3Bfl1XwTNaD
 cUClDtW7MXGzzORGVvAWnykpSvzKIFBXC/6baipw/wFKiZ3V5tsWRL4EsIgk9f45amXFlHGoX
 36rrMT6zxqJNfsUHHoc4c1XNnmPFzE8Hle8zgcdpTXkFA6tJvqkWjq26BphR0/H2T0fUDJ4sy
 Itr3+3kfVgAgAOuoMBVU0QrYKXLvMqyz8/rLpLQuTJwQE4B9/e/oKoq3ZdJGV/qGC7qwGF46W
 dx5ixCES5QVTo5LQvTqS84SELFvKckYzg6TLZphIpIUssRP2r8o3QHpIOdmp90JimphFud4CX
 VNDn2CXJcJF2ZybvlMyMAGz1HDKRgm2+oPP5krgMCNeDHC6pCIyZTT/1pCfewAtpeYYMSe7VN
 3NT4d0sYdzeH4Wp+4++w8p+17sTaY0Zbi8fjIOzA4V5WfORlG9FvdkUWJ5hmOtfKdb55L+yIq
 Hv+Lj4GCXWvZ04VJTy70bNLeA3B4rQmx43NMODXYJomDWa84G3BCM7IbwB3v83G0+aPHffjjh
 L3WoKFtkKsLtHYkXTNvm6LzVhtSHDgLMKb/Ab7lnmZdCtEbYpDWEEAbIQYE28JIfbaJ4VYbYC
 pTzvJcge/ZN2KBBrLZ6BLcD0loG20rghLN2ddXJHhyQB0xf4YXmgZopoP/fN/TOsvzd+9Iwdr
 d3XTdcMw4C5ZkiTuBjhpecu26o+Da3KON0rHCebC262GhWa43zzNdL3vNxVjiJvoXB5SxIBCA
 8N2vYWjpMCy0weBBUJY5L4ApBz6Z5pQ8snEVELXyU5CyIz5iD4OXzMESzRsIceFGttNfLA8sx
 4jkhoS8pCHAIGaw1If8F1mHpdvniP5nx75Wgn68Os=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 9 Mar 2021, Junio C Hamano wrote:

> A release candidate Git v2.31.0-rc2 is now available for testing at
> the usual places.

For the record: I already have a PR up in the Git for Windows project with
a tentative Git for Windows release candidate:
https://github.com/git-for-windows/git/pull/3098

For now, I need to take a break, and I plan on finishing this up tomorrow.

Ciao,
Johannes
