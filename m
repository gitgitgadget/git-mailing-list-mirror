Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96D320248
	for <e@80x24.org>; Wed, 10 Apr 2019 10:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfDJKqI (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 06:46:08 -0400
Received: from sella4.gpi.it ([89.190.163.252]:56902 "EHLO sella4.gpi.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbfDJKqI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 06:46:08 -0400
Received: from prdzimgpi04.gpi.it (prdmta.gpi.it [192.168.40.36])
        by sella4.gpi.it (Postfix) with ESMTPS id 9832F100070
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 12:45:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by prdzimgpi04.gpi.it (Postfix) with ESMTP id 8A783313237
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 12:45:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at prdzimgpi04.gpi.it
Received: from prdzimgpi04.gpi.it ([127.0.0.1])
        by localhost (prdzimgpi04.gpi.it [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XyNzwynBp5Cz for <git@vger.kernel.org>;
        Wed, 10 Apr 2019 12:45:59 +0200 (CEST)
Received: from prdzimgpi02.gpi.it (prdzimgpi02.gpi.it [10.192.1.151])
        by prdzimgpi04.gpi.it (Postfix) with ESMTP id 6E691313236
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 12:45:59 +0200 (CEST)
Date:   Wed, 10 Apr 2019 12:45:59 +0200 (CEST)
From:   Nicola Farina <nicola.farina@gpi.it>
To:     git <git@vger.kernel.org>
Message-ID: <1509193182.25902858.1554893159368.JavaMail.zimbra@gpi.it>
Subject: Git subtree error on windows 10 with 2.21 version
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - GC73 (Win)/8.8.8_GA_1703)
X-Authenticated-User: nicola.farina@gpi.it
Thread-Index: 9g2yRSZ0MgrYuCgJLhvDcCQekpoE2Q==
Thread-Topic: Git subtree error on windows 10 with 2.21 version
X-GPI-MailScanner-Information: Please contact sat@gpi.it for more information
X-GPI-MailScanner-ID: 9832F100070.AF8E6
X-GPI-MailScanner: Found to be clean
X-GPI-MailScanner-MCPCheck: 
X-GPI-MailScanner-SpamCheck: non spam, SpamAssassin (not cached,
        punteggio=-2.9, necessario 5, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-GPI-MailScanner-From: nicola.farina@gpi.it
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

After upgrading to 2.21 issuing this subtree command:

git subtree push --prefix ouverture Shared-Ouverture master

I get these errors:

C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory

I have installed git choosing the option "use git with bash only"

thanks for any suggestions/help
Nicola
