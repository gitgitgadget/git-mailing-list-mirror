Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE3A20136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934365AbdBQSoh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:44:37 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:54443 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934074AbdBQSog (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:44:36 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id C77E1C928;
        Fri, 17 Feb 2017 19:44:33 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id BF7221004B5;
        Fri, 17 Feb 2017 19:44:33 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id AC4E9125EAE;
        Fri, 17 Feb 2017 19:44:33 +0100 (CET)
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
Date:   Fri, 17 Feb 2017 19:44:33 +0100
In-Reply-To: <xmqq4lzsu0wo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 17 Feb 2017 10:28:55 -0800")
Message-ID: <vpq7f4owtbi.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johan Hovold <johan@kernel.org> writes:
>
>> That's precisely what the patch I posted earlier in the thread did.
>
> That's good.  I didn't see any patch yet 

It's here:

http://public-inbox.org/git/20170217110642.GD2625@localhost/

but as I explained, this removes a feature suported since several major
releases and we have no idea how many users may use the "mupliple emails
in one field". The approach I proposed does not suffer from this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
