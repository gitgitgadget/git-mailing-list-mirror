Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E12420193
	for <e@80x24.org>; Fri, 28 Oct 2016 06:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbcJ1GC5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 02:02:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47060 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755928AbcJ1GC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 02:02:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u9S62kfl019352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 28 Oct 2016 08:02:46 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9S62lKA016926;
        Fri, 28 Oct 2016 08:02:47 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v15 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
        <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 28 Oct 2016 08:02:46 +0200
In-Reply-To: <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 27 Oct 2016 09:59:52 -0700")
Message-ID: <vpqtwbxgge1.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 28 Oct 2016 08:02:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9S62kfl019352
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1478239369.58755@g10GImXmIIqfU3B4tm/JkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Cc'ed those who touched either "git-bisect.sh" or "builtin/bisect-helper.c"
> in our relatively recent past.
>
> Does any of you (and others on the list) have time and inclination
> to review this series?

Unfortunately, I have essentially zero-bandwidth to do that in the near
future :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
