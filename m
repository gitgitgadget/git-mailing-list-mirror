Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E845020248
	for <e@80x24.org>; Fri, 12 Apr 2019 13:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDLNhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 09:37:12 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:19727 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfDLNhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 09:37:12 -0400
Date:   Fri, 12 Apr 2019 13:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1555076229;
        bh=2EsAR6jNTUbLPld3U19OdDJaPGgn6feZ0s+i6MG8UYQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=xRlfTo2YWIE67TWR77UXkMaLuL6WcroZXA+XAJFnvH/fxBbL4/g1o77w2K/YrbMR+
         TqbEB/zpe3BB2/DQjZFymUVXT1X+USpm41SVIw2SB0i2G0JS3OdSZJU4JUIBxDH1J6
         dFStar5AFYjY29PgLNdCIHnfi5LU69m2pV67tf58=
To:     Junio C Hamano <gitster@pobox.com>
From:   Ron <ronazek@protonmail.com>
Cc:     "git\\@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Ron <ronazek@protonmail.com>
Subject: Re: Git merge should report an actual syntax error when a semicolon is used instead of space for specifying multiple branches
Message-ID: <NVqJoDneX4bKnXsESFmcKt_7jDQE8Wk9l_F9rkNcnplXgV8TVjfbaMIhKfZ2v9BwJrJ2QJYcq-E6UdshPdhKttO4bIUGdsbs0zZUPNwQvUY=@protonmail.com>
In-Reply-To: <xmqqsgunya8j.fsf@gitster-ct.c.googlers.com>
References: <fQ_n3UAoz-yQ8MMCgPLhVDqkMCqpXQ2Dk34IZgksKIQ1B3Sig_T70nPI5mI0z9z2A5ZLdk5ooUYnAJelV-7eMNrnCr4V73Rz87pP1arR8WA=@protonmail.com>
 <xmqqsgunya8j.fsf@gitster-ct.c.googlers.com>
Feedback-ID: RMis9b9KHKlvsb8KKkeurfBt3UTu5TN-1L1t5jXjkqXfFdr8BIyQs5Ws7O_ywm8jXx2U-EI3XDzu_Y-JlzMpfw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> wrote:

> I do not know what "git fetch" uses semicolon for here. Care to
> elaborate?

Those were all typos, I meant colon, two dots. Sorry.


