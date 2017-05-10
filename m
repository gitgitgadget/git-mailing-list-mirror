Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9FEA1FF34
	for <e@80x24.org>; Wed, 10 May 2017 09:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdEJJE1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 10 May 2017 05:04:27 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:20896 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752182AbdEJJE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 05:04:26 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 7A2C4200411;
        Wed, 10 May 2017 11:04:20 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
Date:   Wed, 10 May 2017 11:04:20 +0200
Message-ID: <9774445.E3R3CqpI8C@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <CACBZZX4F2TL-kZj6y=00UTEhC-4VeDLm1EYOe2_eK=hscSdJ4g@mail.gmail.com>
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com> <CACBZZX4F2TL-kZj6y=00UTEhC-4VeDLm1EYOe2_eK=hscSdJ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mercredi 10 mai 2017, 10:08:14 CEST Ævar Arnfjörð Bjarmason a écrit :
> > * ja/doc-l10n (2017-03-20) 3 commits
> >  . SQUASH???
> >  . l10n: add git-add.txt to localized man pages
> >  . l10n: introduce framework for localizing man pages
> >
> >  A proposal to use po4a to localize our manual pages.
> >
> >  Will discard.
> >  Has been stalled for too long.
> 
> Jean-Noel: Need any help with this?
> 

I restarted on this yesterday. The change for git will be reduced to what Junio proposed, that is embedding a repo into /Documentation, with some targets added to Makefile if the directory is present. In the doc l10n repo, a Makefile's target will copy the asciidoc source files from /Documentation into the repo, in order to create a stable base for all the po4a stuff.

This is quite slow as my Makefile-fu is very basic.
