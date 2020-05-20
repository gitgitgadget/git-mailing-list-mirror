Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A7C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 10:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF84207D3
	for <git@archiver.kernel.org>; Wed, 20 May 2020 10:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgETKez (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 06:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETKez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 06:34:55 -0400
X-Greylist: delayed 6073 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 May 2020 03:34:54 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF45C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 03:34:54 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49RpzH6nCWz1rvBF;
        Wed, 20 May 2020 12:34:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49RpzH6MQwz1r3l7;
        Wed, 20 May 2020 12:34:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ClwCpDZLGlrp; Wed, 20 May 2020 12:34:51 +0200 (CEST)
X-Auth-Info: JWonFEyBVAftRTvPanDpUA0qIYrZhaMMfdSqtxDl9ubdk2RcDu4kbxtZV6t1/sh9
Received: from igel.home (ppp-46-244-161-158.dynamic.mnet-online.de [46.244.161.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 20 May 2020 12:34:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 6F92C2C0B3F; Wed, 20 May 2020 12:34:50 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
        <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
        <xmqq1roo947y.fsf@gitster.c.googlers.com> <87sgfvq967.fsf@igel.home>
        <20200520100528.GV25173@kitsune.suse.cz>
X-Yow:  HELLO, little boys!   Gimme a MINT TULIP!!  Let's do the BOSSA NOVA!!
Date:   Wed, 20 May 2020 12:34:50 +0200
In-Reply-To: <20200520100528.GV25173@kitsune.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
        message of "Wed, 20 May 2020 12:05:28 +0200")
Message-ID: <87k116rj1x.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 20 2020, Michal Suchánek wrote:

> What git version?

2.26.2

> git 2.26.3

I don't see that anywhere.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
