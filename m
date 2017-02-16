Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E232E1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932655AbdBPQlg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 11:41:36 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:48397 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932386AbdBPQlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 11:41:35 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id A4A67C554;
        Thu, 16 Feb 2017 17:41:32 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 9E71A100494;
        Thu, 16 Feb 2017 17:41:32 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 991A160457;
        Thu, 16 Feb 2017 16:58:28 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 0/4 v4] WIP: allow "-" as a shorthand for "previous branch"
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
Date:   Thu, 16 Feb 2017 17:41:32 +0100
In-Reply-To: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Thu, 16 Feb 2017 15:14:10 +0000")
Message-ID: <vpqa89mnl4z.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> This is as per our discussion[1]. The patches and commit messages are based on
> Junio's patches that were posted as a reply to
> <20170212184132.12375-1-gitster@pobox.com>.
>
> As per Matthieu's comments, I have updated the tests, but there is still one
> thing that is not working: log -@{yesterday} or log -@{2.days.ago}

Note that I did not request that these things work, just that they seem
to be relevant tests: IMHO it's OK to reject them, but for example we
don't want them to segfault. And having a test is a good hint that you
thought about what could happen and to document it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
