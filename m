Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B53C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CE62074D
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="VikkuUAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIEShv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:37:51 -0400
Received: from out1.migadu.com ([91.121.223.63]:54826 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgIEShv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 14:37:51 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1599331068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=5kwX2eDBxmrfkMJIiZ0W126Lwk9qv6ld1fL4wVD9LIs=;
        b=VikkuUATYnPhfAe/tfqptALUi7VFRbnhcBxk+jJlTIyaqjzzTlxmEljDaa//5U0UOG4ddM
        iXfoMaHKs/W1ZH1ERqEpDQS1+Pa1JHiJqwAiEuEaEe78pYyTdzeMF1t73E+9bZqX3SryGo
        4HnoNWttuEmliQkZ9ZZP8PyrEz/J1jE=
Content-Type: text/plain; charset=UTF-8
Cc:     "Thomas Sullivan" <tom@msbit.com.au>, <git@vger.kernel.org>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>
Subject: Re: git add intent-to-add then git add patch no longer allows edit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Phillip Wood" <phillip.wood123@gmail.com>,
        <phillip.wood@dunelm.org.uk>, "Junio C Hamano" <gitster@pobox.com>
Date:   Sat, 05 Sep 2020 14:36:14 -0400
Message-Id: <C5FNIIPY4D4O.1NCAXB8BEBF4Z@ziyou.local>
In-Reply-To: <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Sep 4, 2020 at 6:05 AM EDT, Phillip Wood wrote:
> Thanks, it was really good to get a change of scene. The patch below
> fixes the hunk editing for new files in the C version of `add -p` if
> anyone wants to try it out. I haven't looked at fixing the perl
> version yet - dscho what are your plans for switching over to the C
> version?

No issues with this patch thus far - I'll continue running with it until
it gets picked up. Thanks!
