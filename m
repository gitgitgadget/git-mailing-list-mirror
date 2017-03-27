Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DD51FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 20:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdC0UMV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 27 Mar 2017 16:12:21 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54032 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbdC0UMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 16:12:20 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 419BE2003DE;
        Mon, 27 Mar 2017 22:12:17 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
Date:   Mon, 27 Mar 2017 22:12:16 +0200
Message-ID: <7770933.gyQYXQhLOc@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <xmqqshlz4pfs.fsf@gitster.mtv.corp.google.com>
References: <20170312200248.3610-1-jn.avila@free.fr> <4046320.m2qk9b67WH@cayenne> <xmqqshlz4pfs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le dimanche 26 mars 2017, 15:56:55 CEST Junio C Hamano a écrit :
> Jean-Noël AVILA <jn.avila@free.fr> writes:
> > ... So I would
> > think the other way around: for those interested in translated the
> > documentation, some script would allow to checkout the git project inside
> > the gitman-l10n project (like a kind of library).
> > 
> > This would be mainly transparent for the git developers.
> 
> As long as the resulting layout would help all groups (1) developers
> who do not worry about documentation l10n (2) documentation i18n
> coordinator and transltors (3) those who build and ship binary
> packages, I personally am OK either way.
> 
> Having said that, I am not sure if I understand your "translators do
> not have a fixed version of git.git to work with and po4a cannot
> work well" as a real concern.  Wouldn't the l10n of documentation
> use a similar workflow as used for the translation of in-code
> strings we do in po/?  Namely, *.pot files are *NOT* updated by
> individual translators by picking up a random version of git.git and
> running xgettext.  Instead, i18n coordinator is the only person who
> runs xgettext to update *.pot for the upcoming release of Git being
> prepared, and then translators work off of that *.pot file.  Which
> means they do not have to worry about in-code strings that gets
> updated in the meantime; instead they work on a stable known
> snapshot of *.pot and wait for the next sync with i18n coordinator
> whose running of xgettext would update *.pot files with updated
> in-code strings.  Doesn't that workflow apply equally well for the
> documentation l10n?

Theoretically, this workflow should apply to the documentation, so that a 
version of the documentation can be cut at each release of git. I still have 
to convince po4a not to update the *.pot and *.po files each time it is run, 
while at the same time allow translators to produce the output file for 
proofreading.


