Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8290FC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 06:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67905610C7
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 06:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1Gkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 02:40:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46643 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1Gks (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 02:40:48 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLRDv-1mO2es359P-00IRJC; Thu, 28 Oct 2021 08:38:05 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id F39431E01E7;
        Thu, 28 Oct 2021 06:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r3DyAzF121lh; Thu, 28 Oct 2021 08:38:04 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (24-usr-pf-main.vpn.it.cetitec.com [10.8.5.24])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 97DC41E01E6;
        Thu, 28 Oct 2021 08:38:04 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 28 Oct 2021 08:38:04 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Remove negation from the merge option "--no-verify"
Message-ID: <YXpFTJTo0pKhM7xG@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4k92w7do.fsf@gitster.g>
X-Provags-ID: V03:K1:/vl2OMAhvjplTpO7QHOsG/87I0gT56LMDknnSVTGtzn2kdc8Q3m
 XMrEmQw9qSf2PD0iv5xVxDaCDNnjYDeXKXHoGe3eHM44YxvkHCsz8MQ+bXb2ojejz+HzH1q
 UMCAuEGfkf62qeED2EAgggO2JsSvwuIIr8ZOzm/41q+vsO6NSf1saUNEabi1O/bi7cCeEIO
 dQDNnkEfCv6tdWd9Cr2yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M7f9+t3IPTo=:+ZabgeFj0q5oJe2lZrEzE3
 jPT6amsONG1qtQ8HIaGZw26TDnwUUtBQPN1Pc/E4CaWXDZLML3JHbNKNcd0Tz7osA4aiy3loI
 YCEd7rMo7uDsv5XtklOurdgAhX6XCBYLnMKQap0VPqNeECBWVJl4UbOvEyoAzoX7qjJNPgFbk
 Acu25Q/iYMGscldrB7mw8UHpiYViK2l0fzX2nzcLEY/Iv8vQqKxXzqcBRn1vgouXeducmjEN5
 sErsx3vWW5FPVGOwEgU8vX5H2WidZHyH1tJADWn4/A3+IaEHUzs07xJA230yQEd86wwvJUy86
 wdxURCPpUY/fuOK0RnKhNDDV8RqNWO/IIfHug+sNCaqd4b1MoQbYNof4l5s3JUIHfIwxNQ2eU
 vQT+Z/uPqLvumt8A2dysvm4aJhpxzZXYKXfSiLmQARKtkE6ZWFUQQu7pceFpMk4RMmM8cnBbE
 j8dil8EGGHHsLjutudAmTliBJ27Z2Pi5Bj0rXkkxWIijEKG4BEo8aT04agkJrBPwRjkBYbKKJ
 PPfyjgKGIXZKazTujuC2cc1jxt8OUpR++k5abO4ZPSZfGZq7AATTGTkP5ArUQo8dGrb/wAYN4
 FDGIM6dycbvtBZpxtQ6vZ6fB62gV7uzeRwspw7bJSU7w0bA4hV8ocU1BTExDSaVdryNm+hRID
 5Lp2zmGGWqPbk2o2VzIW5SJdizuB3Y2XaoY18Buo3mensLiluomEROs9zqWtCl1Oo8k960KDK
 pCfHyfAQCWAfVoXz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Wed, Oct 27, 2021 22:16:35 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > From: Alex Riesen <raa.lkml@gmail.com>
> >
> > This allows re-enabling hooks disabled by an earlier "--no-verify"
> > in command-line and makes the interface more consistent.
> >
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> >
> > ---
> >
> > This one is on top of "[PATCH] Fix "commit-msg" hook unexpectedly called for
> > "git pull --no-verify" (http://public-inbox.org/git/YXfwanz3MynCLDmn@pflmari/).
> > Which is a bit awkward. Should I resend as series?
> 
> Don't we need to do this at the root cause command "git commit"?

The commit preparing code in builtin/merge.c does not seem to use the code
from builtin/commit.c, so it does not look like a direct cause of that effect
in "git merge". But...

> It is documented to take "--no-verify" but not "--verify" to countermand an
> earlier "--no-verify" on the command line.

This particular peculiarity in implementation of "--[no-]verify" does look
like it has root-caused everything :)

> And yes, I agree that we shouldn't introduce an awkwardness in one
> step of the series and fix it in another step of the same series.

I think I better resend everything as a single patch then.

