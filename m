Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619AC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2090B61C99
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGGKrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:47:00 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:46370 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230354AbhGGKq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:46:56 -0400
Received: from localhost (avs3.comp.nus.edu.sg [192.168.49.7])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id 5C8541D5FF0;
        Wed,  7 Jul 2021 18:44:13 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.7]) (amavisd-new, port 10024)
        with ESMTP id j2CiZrmzZbBV; Wed,  7 Jul 2021 18:44:02 +0800 (+08)
Received: from mailauth1.comp.nus.edu.sg (mailauth1.comp.nus.edu.sg [192.168.49.3])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Wed,  7 Jul 2021 18:44:02 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth1.comp.nus.edu.sg (Postfix) with ESMTPSA id 051AA60170595;
        Wed,  7 Jul 2021 18:44:00 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     felipe.contreras@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Wed,  7 Jul 2021 18:43:42 +0800
Message-Id: <20210707104342.783609-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <xmqqlf6jla5o.fsf@gitster.g>
References: <xmqqlf6jla5o.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree on this. If for whatever reason a user just wants to have
something handy that can bypass the empty message check globally, they
may no longer be able to do so via a trivial alias if an editor is not
launched. Also, I guess it might be counter-intuitive for an option with
the name --allow-... to force something rather than merely permitting it.

I am trying to prepare the two patches and will send out once it is ready. :P
