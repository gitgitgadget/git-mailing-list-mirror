Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8ACF20248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfBYUyk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Feb 2019 15:54:40 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:1363 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfBYUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:54:40 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 421D0200390;
        Mon, 25 Feb 2019 21:54:35 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Compile error due to po/fr.po on old gettext in v2.21.0
Date:   Mon, 25 Feb 2019 21:54:35 +0100
Message-ID: <2933589.YIuU4JMJIj@cayenne>
In-Reply-To: <874l8rwrh2.fsf@evledraar.gmail.com>
References: <874l8rwrh2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 25 February 2019 21:19:53 CET �var Arnfj�r� Bjarmason wrote:
> On a NetBSD test box I have with msgfmt 0.14.4 v2.21.0 fails to compile.
> 
> I didn't spot this in rc2 because b3225a4183 ("l10n: fr.po v2.21.0 rnd
> 2", 2019-02-13) along with the rest of i18n updates gets pulled in after
> all the RCs.
> 
> I.e. this is because of the comments being parsed (fuzzy comments).
> 
> The 0.14.4 gettext release was back in 2005, so presumably this is due
> to some GPLv3 allergy of NetBSD's. The OS version itself is 7.1,
> released a couple of years ago.
> 

I kept the commented entries as a translation memory, even when they are 
fuzzy.

Would unfuzzying these entries resolve the issue?


