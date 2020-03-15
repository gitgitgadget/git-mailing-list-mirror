Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE4C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A02205C9
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 09:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgCOJqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:46:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50542 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgCOJqj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 05:46:39 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48gF1J5KZYz1rmgR;
        Sun, 15 Mar 2020 10:45:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48gF1J54WYz1qqkW;
        Sun, 15 Mar 2020 10:45:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Vgb3wsxIisiV; Sun, 15 Mar 2020 10:45:56 +0100 (CET)
X-Auth-Info: b1rKaSY80T9yXMc2DMjeViU0rc5OGAUL9+OTHFXb9tKoTgpzwx0BWOYSnTiOMYp1
Received: from igel.home (ppp-46-244-167-146.dynamic.mnet-online.de [46.244.167.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 15 Mar 2020 10:45:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id D47512C1003; Sun, 15 Mar 2020 10:45:54 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Why am I on Master instead of my branch
References: <CAH8yC8=FZrDmHBSk=GFZd08Ovk4zffyB7KEOoyUpAPLYi_xUeA@mail.gmail.com>
X-Yow:  I want you to organize my PASTRY trays...  my TEA-TINS are gleaming in
 formation like a ROW of DRUM MAJORETTES --
 please don't be FURIOUS with me --
Date:   Sun, 15 Mar 2020 10:45:54 +0100
In-Reply-To: <CAH8yC8=FZrDmHBSk=GFZd08Ovk4zffyB7KEOoyUpAPLYi_xUeA@mail.gmail.com>
        (Jeffrey Walton's message of "Sat, 14 Mar 2020 21:54:00 -0400")
Message-ID: <875zf654tp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 14 2020, Jeffrey Walton wrote:

> How am I on master when I checked out cmake-inno-setup-COVERAGE?

Try `git reflog HEAD' to see if you can find some hints.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
