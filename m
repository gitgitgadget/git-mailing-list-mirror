Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37B01F462
	for <e@80x24.org>; Sun,  9 Jun 2019 15:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfFIPzF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 9 Jun 2019 11:55:05 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:61567 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbfFIPzF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 11:55:05 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 2D82A200402;
        Sun,  9 Jun 2019 17:54:58 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        johannes.schindelin@gmx.de, Todd Zullinger <tmz@pobox.com>,
        timcharper@gmail.com
Cc:     "avila.jn" <avila.jn@gmail.com>
Subject: Inclusion of translated git manpages into the packaging systems
Date:   Sun, 09 Jun 2019 17:47:29 +0200
Message-ID: <1979608.xhrAu3A07H@cayenne>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I took on the task of creating a project for the translation of man-pages at 
https://github.com/jnavila/git-manpages-l10n

Up to now, the translations have started for 3 languages:

* German (2 pages)
* Brazilian Portuguese (6 pages)
* French (11pages)

In order to provide feedback to translators, it's time to have these pages 
included with the distributions of git. Right now the process of compilation 
of the man-pages is still a bit off-tree, because it relies on a recent version 
of po4a (v0.56) which has not yet reached most distros.

I miss expertise in the process of packaging. Depending on the type of 
distribution, the route to packaging might differ (for Mac OS and Windows, 
maybe a direct inclusion, for Linux dists sister packages). That's why I need 
your help to correctly perform this integration.

Thanks in advance,

Jean-Noël 


