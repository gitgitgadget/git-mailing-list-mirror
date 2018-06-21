Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660791F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeFUOgI (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:36:08 -0400
Received: from mail.vm.ouaza.com ([212.83.178.2]:55241 "EHLO mail.vm.ouaza.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932960AbeFUOgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:36:07 -0400
Received: from x260-buxy.home.ouaza.com (133-218-190-109.isp.overthebox.ovh [109.190.218.133])
        by mail.vm.ouaza.com (Postfix) with ESMTPSA id ED75F2094E;
        Thu, 21 Jun 2018 16:27:01 +0200 (CEST)
Received: by x260-buxy.home.ouaza.com (Postfix, from userid 1000)
        id CB5C38A2BD8; Thu, 21 Jun 2018 16:27:59 +0200 (CEST)
From:   =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: Two small l10n/i18n patches
Date:   Thu, 21 Jun 2018 16:27:40 +0200
Message-Id: <20180621142742.28575-1-hertzog@debian.org>
X-Mailer: git-send-email 2.18.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.4 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I'm not subscribed, please keep me in CC)

Hello,

I was reviewing the output of "git bisect" with my French locale
and I saw a clear mistake in the French translation (fixed
in the first commit) and I also noticed that the last message
was still in English. After review of the code, it's not a missing
translation, the problem comes down to two strings which
are not marked for translation.

So the second commit marks those strings for translation. But I haven't
checked much further than that. The final string is used in many places
in the test suite and I haven't checked if the locale is properly
hardcoded in the test suite.

In any case, "make test" is still working after those two commits.

Thank you for considering my patches. I leave it tho the regular
translators to add translations for the newly added strings.


