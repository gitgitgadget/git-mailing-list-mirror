Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3460C20323
	for <e@80x24.org>; Wed, 15 Mar 2017 07:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbdCOHN5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 03:13:57 -0400
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:55536 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdCOHNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 03:13:08 -0400
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id DC1A4C55D;
        Wed, 15 Mar 2017 08:13:05 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id D74E7100521;
        Wed, 15 Mar 2017 08:13:05 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id BC25A125EAE;
        Wed, 15 Mar 2017 08:13:05 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
Subject: Re: [PATCH] git-status: make porcelain more robust
References: <54df68bd46f7a417e77eb71b636f6f7afd4fce75.1489507239.git.git@drmicha.warpmail.net>
        <xmqq8to7h5tr.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 15 Mar 2017 08:13:05 +0100
In-Reply-To: <xmqq8to7h5tr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 14 Mar 2017 15:05:52 -0700")
Message-ID: <vpqvarbau7y.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> git status provides a porcelain mode for porcelain writers with a
>> supposedly stable (plumbing) interface.
>> 7a76c28ff2 ("status: disable translation when --porcelain is used", 2014-03-20)
>> made sure that ahead/behind info is not translated (i.e. is stable).
>>
>> Make sure that the remaining two strings (initial commit, detached head)
>> are stable, too.
>
> It seems to me that 7a76c28ff2 already missed these strings, and
> their _() markings survive to this day.  Thanks for spotting and
> fixing.

Yep, sounds all right to me. Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
