Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB49FC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338C420888
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="OjovOELJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgI3V4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:56:55 -0400
Received: from mout02.posteo.de ([185.67.36.66]:59343 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730544AbgI3V4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:56:54 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A6F1C2400FC
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 23:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1601503012; bh=jLh0q30PTOw5fLOQOtEgh1J8VklatLoftiFD0df2bNY=;
        h=Date:From:To:Cc:Subject:From;
        b=OjovOELJYxh15pBTfiKdzjCr43S+myw6BEJW7/7Po3IMi3zave70+GoVUM6kHr9Vu
         nn2/Pwhjs6tI2Cwx5xYoPtvevIIMJtaKi8qIAksgsqxdo5uNNfSgp/yMY1XKyfD+fJ
         djUFxU/w0pUCOSYbQ4Em4Ufz6xo0iQv80GHt2R4OEr1UnGr5miuOCY5SIBHpI9Z1ZP
         VWDu0y/EDolhAZMahC8EvklaQcaBAZvhC8jK9S0ciaSn8dhEuKOquvsBUqHbNMcTBP
         grmAmluSeZxWcpMvkJlde91oCVIQCGBdcUcuhnWLlN7lH34dmnwdwdH+oI8E11Tg6s
         FWx+DQ5imtJFA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C1qpq1sKFz6tmb;
        Wed, 30 Sep 2020 23:56:50 +0200 (CEST)
Date:   Wed, 30 Sep 2020 23:56:47 +0200
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-completion.bash: stash-show: add --patch-with-stat
Message-ID: <20200930215647.GA19843@HP>
References: <20200928110517.24915-1-avoidr@posteo.de>
 <xmqqh7rhn3nk.fsf@gitster.c.googlers.com>
 <20200929213154.GA18321@HP>
 <xmqqo8lngjze.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8lngjze.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 12:09:09PM -0700, Junio C Hamano wrote:
> Robert Karszniewicz <avoidr@posteo.de> writes:
> > So shall I do a v2 as per your suggestion and replace
> > "--patch-with-stat" with "--patch --stat"?
> 
> I think Denton Liu offered a different suggestion; I didn't look at
> and compare which direction is the better one myself, but an
> approach that keeps the number of manually-maintained list of
> options low is almost always a good approach.

Ok, I understand, then. Will take a look at it.

Thank you.
