Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71BA92023D
	for <e@80x24.org>; Wed, 28 Jun 2017 08:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdF1IXG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 04:23:06 -0400
Received: from ser-smtp-vm-1.dakosy.de ([195.244.0.87]:46591 "EHLO
        ser-smtp-vm-1.dakosy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdF1IXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 04:23:04 -0400
Received: from [10.7.2.114] (helo=ser-smtpdak-vm-1.dakosy.de)
        by ser-smtp-vm-1.dakosy.de with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <neuling@dakosy.de>)
        id 1dQ8FV-00014z-Ko; Wed, 28 Jun 2017 10:22:57 +0200
Received: from daktales1.dakosy.de ([10.7.2.20])
        by ser-smtpdak-vm-1.dakosy.de with esmtp (Exim 4.82)
        (envelope-from <neuling@dakosy.de>)
        id 1dQ8FV-0006s5-Dj; Wed, 28 Jun 2017 10:22:57 +0200
In-Reply-To: <xmqqvanh324p.fsf@gitster.mtv.corp.google.com>
References: <OF6AC13578.F02B79FA-ONC125814C.004DD247-C125814C.00500A93@dakosy.de> <xmqqvanh324p.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Bug: Since Git 2.13.2 git rebase autostash doesn't use fast-forward (poor
 performance)
X-KeepSent: 99731898:CA1C41BB-C125814D:002E02EC;
 type=4; name=$KeepSent
Message-ID: <OF99731898.CA1C41BB-ONC125814D.002E02EC-C125814D.002E0B32@dakosy.de>
From:   neuling@dakosy.de
Date:   Wed, 28 Jun 2017 10:22:55 +0200
Content-Type: text/plain; charset="US-ASCII"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Could you see this as suggestion for performance improvement or should I 
send another e-mail for a new task?

Regards,
Mattias


Junio C Hamano <jch2355@gmail.com> schrieb am 27.06.2017 17:02:14:

> Von: Junio C Hamano <gitster@pobox.com>
> An: neuling@dakosy.de
> Kopie: git@vger.kernel.org
> Datum: 27.06.2017 17:02
> Betreff: Re: Bug: Since Git 2.13.2 git rebase autostash doesn't use 
> fast-forward (poor performance)
> Gesendet von: Junio C Hamano <jch2355@gmail.com>
> 
> neuling@dakosy.de writes:
> 
> > since the latest version 2.13.2 "git pull --rebase --autostash" 
doesn't 
> > use a fast forward if possible. 
> 
> This may not be a bug but instead a fix made deliberately.
> 
> cf. http://public-inbox.org/git/
> CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com/
> 
> A deciding excerpt from the thread was:
> 
> > Correctness must trump optimizations
> 
> Patches to further update and resurrect the optimization without
> breaking correctness of course are of course very much welcomed.
> 
> Thanks.

