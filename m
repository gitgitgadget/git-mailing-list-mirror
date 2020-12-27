Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F7C433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4EE22838
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 22:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL0WaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 17:30:07 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55512 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgL0WaG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 17:30:06 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kteXV-0052lO-Ox; Sun, 27 Dec 2020 15:29:25 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kteXU-00FtcP-OP; Sun, 27 Dec 2020 15:29:25 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 76BA212805F3;
        Sun, 27 Dec 2020 15:29:24 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t01RF7s1DD-9; Sun, 27 Dec 2020 15:29:24 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id E1D2E128058D;
        Sun, 27 Dec 2020 15:29:23 -0700 (MST)
Date:   Sun, 27 Dec 2020 15:29:22 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <20201227222922.GA509599@ellen>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201227205835.502556-1-seth@eseth.com>
 <20201227205835.502556-2-seth@eseth.com>
 <xmqq1rfarji5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rfarji5.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1kteXU-00FtcP-OP;;;mid=<20201227222922.GA509599@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH v6 1/2] mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 27, 2020 at 02:06:58PM -0800, Junio C Hamano wrote:
> Missing Sign-off as a relayer.

I haven't come across that in the docs on contributing to Git and my
Google searches aren't helping. Do you mind pointing me to what to add?

> These do not seem to be taken from the version that has been
> improved by reviwer comments after v3.

Whoops! Thanks for the catch. Seems I fished the wrong version out of my
email. Created a new v7 based off the correct v5.

