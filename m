Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B5CC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57462207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 18:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="ZdQXlGtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgFPS7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:59:11 -0400
Received: from huan9.mail.rambler.ru ([81.19.78.8]:44230 "EHLO
        huan9.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgFPS7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 14:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=ny3CwqZBmQKJdrxflQKSUgRXYRLlLGaC3gRFnKol0IU=; b=ZdQXlGtc/e9EtkySugC+WlxVo1
        pRB/jBHxj9S2/6KTe6t9kWInwfA1P4VMLX6uQF5Mg8y9uFfs3RoGpvoQX2buVAPku5cTmS5lBS9+k
        Uy7uLLeZAAVhIjqJbt3ybcjU6hq95ztQRfkUi/CbUIRPe+WFsrxhC4ARPQsfdDYdfUik=;
Received: from [UNAVAILABLE] ([194.190.114.28]:60146 helo=localhost)
        by huan9.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlGnc-0000RB-V6
        for git@vger.kernel.org; Tue, 16 Jun 2020 21:59:09 +0300
Date:   Tue, 16 Jun 2020 22:00:50 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616190044.GB27441@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
 <20200616134449.1c27cf7c@mydesk.domain.cxm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616134449.1c27cf7c@mydesk.domain.cxm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 01:44:49PM -0400, Steve Litt wrote:
> Makes perfect sense to me. No reasonable person can argue against
> giving individual repository owners the ability to *easily* call their
> "primary" branch anything they want.

This is great. But

> This flame war plus the publicity it generated lets everybody know that
> someday, whether in 1 month or 5 years, the default will be something
> other than "master", so they'll start changing their software and
> scripts to accommodate a variable instead of a hardcode, so when the
> change happens, there will be minimal software disruption and minimal
> hurt feelings.

this is not. Damn. Did you see what people say here? Why are you even
forcing people to do this? Just stay "master" as a default and everyone
will be happy. 

-- 
Олег Неманов (Oleg Nemanov)
