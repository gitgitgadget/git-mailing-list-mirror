Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12438201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbdBVOfq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:35:46 -0500
Received: from mylo.jdl.com ([208.123.73.151]:53242 "EHLO mylo.jdl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932827AbdBVOfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:35:40 -0500
X-Greylist: delayed 2130 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Feb 2017 09:35:40 EST
Received: from jdl (helo=mylo)
        by mylo.jdl.com with local-esmtp (Exim 4.82)
        (envelope-from <jdl@jdl.com>)
        id 1cgXSe-0007jp-QI; Wed, 22 Feb 2017 08:00:04 -0600
From:   Jon Loeliger <jdl@jdl.com>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Toolforger <toolforger@durchholz.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
In-reply-to: <xmqqbmtvdj7p.fsf@gitster.mtv.corp.google.com>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org> <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net> <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org> <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net> <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org> <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net> <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com> <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net> <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com> <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com> <CAGZ79ka2S=V1x2fSQq+E-yE0Ao36-4tuTvnD6uXpPXJPLFN3JA@mail.gmail.com> <xmqqbmtvdj7p.fsf@gitster.mtv.corp.google.com>
Comments: In-reply-to Junio C Hamano <gitster@pobox.com>
   message dated "Tue, 21 Feb 2017 18:59:06 -0800."
Date:   Wed, 22 Feb 2017 08:00:04 -0600
Message-Id: <E1cgXSe-0007jp-QI@mylo.jdl.com>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jdl@jdl.com
X-SA-Exim-Scanned: No (on mylo.jdl.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, like, Junio C Hamano said:
> Stefan Beller <sbeller@google.com> writes:
> 
> > Do we want to invent a special value for url.*.insteadOf to mean
> >   "look up in superproject, so I don't have to keep
> >   a copy that may get stale" ?
> 
> My gut feeling is that we should do the selective/filtered include
> Peff mentioned when a repository is known to be used as a submodule
> of somebody else.

Does the management of these submodue-related config values
become easier if, instead of placing them in .config, we
place them in a git/.context file?

jdl

