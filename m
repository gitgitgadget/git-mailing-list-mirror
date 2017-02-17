Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5063E201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 20:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934869AbdBQUUa (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 15:20:30 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:56007 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934090AbdBQUU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 15:20:29 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 3E0FDC8F1;
        Fri, 17 Feb 2017 21:20:26 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 360FA10057B;
        Fri, 17 Feb 2017 21:20:26 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 325E460360;
        Fri, 17 Feb 2017 20:37:22 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
        <20170217110642.GD2625@localhost> <vpq7f4pdkjp.fsf@anie.imag.fr>
        <20170217164241.GE2625@localhost> <vpq4lzs7o0s.fsf@anie.imag.fr>
        <xmqqd1egu1dl.fsf@gitster.mtv.corp.google.com>
        <20170217182326.GA479@localhost>
        <xmqq4lzsu0wo.fsf@gitster.mtv.corp.google.com>
        <vpq7f4owtbi.fsf@anie.imag.fr>
        <xmqqd1egshv1.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Feb 2017 21:20:26 +0100
In-Reply-To: <xmqqd1egshv1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 17 Feb 2017 12:05:38 -0800")
Message-ID: <vpq1suwvab9.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> That approach may still constrain what those in the former camp can
> write in the "cruft" part, like they cannot write comma or semicolon
> as part of the "cruft", no?

Right. Indeed, this may be a problem since the use of "#" for stable
seem to include commit message, and they may contain commas.

So, maybe Johan's patch is better indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
