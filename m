Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5489D1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 08:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGFICW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 04:02:22 -0400
Received: from goliath.siemens.de ([192.35.17.28]:42069 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbeGFICN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 04:02:13 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w6681ods012777
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 10:01:51 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6681nje017965;
        Fri, 6 Jul 2018 10:01:49 +0200
Date:   Fri, 6 Jul 2018 10:01:48 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/8] X509 (gpgsm) commit signing support
Message-ID: <20180706100148.7b878808@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180706011834.GD7697@genre.crustytoothpaste.net>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <20180706011834.GD7697@genre.crustytoothpaste.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fri, 6 Jul 2018 01:18:35 +0000
schrieb "brian m. carlson" <sandals@crustytoothpaste.net>:

> On Tue, Jul 03, 2018 at 02:38:12PM +0200, Henning Schild wrote:
> > This series adds support for signing commits with gpgsm.
> > 
> > The first two patches are cleanups of gpg-interface, while the next
> > four prepare for the introduction of the actual feature in patch 7.
> > Finally patch 8 extends the testsuite to cover the new feature.
> > 
> > This series can be seen as a follow up of a series that appeared
> > under the name "gpg-interface: Multiple signing tools" in april
> > 2018 [1]. After that series was not merged i decided to get my
> > patches ready. The original series aimed at being generic for any
> > sort of signing tool, while this series just introduced the X509
> > variant of gpg. (gpgsm) I collected authors and reviewers of that
> > first series and already put them on cc.  
> 
> Overall, I think this is heading in a good direction.  I left a few
> comments, but it seemed pretty sane.

Thanks, i hope others think so too and that will eventually get merged.

Henning
