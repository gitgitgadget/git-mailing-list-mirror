Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A273D208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 10:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdHXKM4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Aug 2017 06:12:56 -0400
Received: from 1.mo64.mail-out.ovh.net ([178.33.109.67]:59118 "EHLO
        1.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdHXKMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 06:12:55 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id B2D8E88C1A;
        Thu, 24 Aug 2017 12:12:53 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 12:12:49 +0200
Subject: Re: sequencer status
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Christian Couder <christian.couder@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
 <CAP8UFD035niTUQTe73RSTE+3u6WX11UpxoqCSrfVP1Qs-fF0gg@mail.gmail.com>
 <vpq4lsxl2r8.fsf@anie.imag.fr>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <851c3796-aee5-4b3f-92a8-308d71356107@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 12:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <vpq4lsxl2r8.fsf@anie.imag.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS2.indiv2.local (172.16.1.2) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 12008003984440289245
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdeggddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 24/08/2017 à 11:43, Matthieu Moy a écrit :
> Christian Couder <christian.couder@gmail.com> writes:
>
>> It is displaying the steps that have already been performed, right?
>> I wonder if people might want more about the current step (but maybe
>> that belongs to `git status`) or perhaps the not yet performed states
>> (and maybe even a way to edit the todo list?)
> Note that 'git status' is already doing this, but shows only 2 items of
> each:
>
> $ git status
> interactive rebase in progress; onto 3772427
> Last commands done (2 commands done):
>    pick a48812c some commit title
>    exec false
> Next commands to do (2 remaining commands):
>    pick 9d7835d some other commit
>    pick c0e0fa8 one more subject
>   (use "git rebase --edit-todo" to view and edit)
> You are currently editing a commit while rebasing branch 'master' on '3772427'.
> ...
>
> The idea was that 2 lines of context is often sufficient, and doesn't
> eat too much screen space so it makes sense to show it by default.
>
> I think it makes sense to have another command that shows the whole
> sequence, but perhaps it could also be just an option for "git status".
>
> Cheers,
>

But this is only for interactive rebase.
It might be worth adding a parameter for this, but I'd also like to see this feature for all rebase/cp/revert

Nicolas

