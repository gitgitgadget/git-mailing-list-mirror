Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE4B1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 16:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfADQyX (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 11:54:23 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:58253 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbfADQyX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 11:54:23 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 3D7382003F3;
        Fri,  4 Jan 2019 17:54:20 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 0/1] i18n: add framework for localizing the manpages
Date:   Fri,  4 Jan 2019 17:54:05 +0100
Message-Id: <20190104165406.22358-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This is a second attempt at providing localized manpages of git in a central way. The first attempt[1] was to include all the changes directly in the main repo. But as Junio made me realize, staying in the main repo would have many drawbacks such as forcing possible translators to follow the workflow of Git and preventing use of third party translation tools such as Weblate.

This solution is to make the manpage localization project standalone. I finally had time to hack po4a to enhance support for specificities of git manpages. This rather light patch is only an adaptation of the Makefile to be able to use the same building rules in the translation repo. The translation repo bases the workflow on a copy of the selected manpages asciidoc source files. You can find it at

https://github.com/jnavila/git-manpages-l10n

Translations can be filled using Weblate at https://hosted.weblate.org/projects/git-manpages/

[1] https://public-inbox.org/git/20170312200248.3610-1-jn.avila@free.fr/

Jean-Noel Avila (1):
  Add optional targets for documentation l10n

 Documentation/Makefile | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.20.1

