Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523F51FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 12:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbdDRMbt convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 18 Apr 2017 08:31:49 -0400
Received: from faui13mail.informatik.uni-erlangen.de ([131.188.43.54]:52720
        "EHLO faui13mail.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752784AbdDRMbs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Apr 2017 08:31:48 -0400
X-Greylist: delayed 2672 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Apr 2017 08:31:48 EDT
Received: by faui13mail.informatik.uni-erlangen.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2 (FreeBSD))
        (envelope-from <egger@cs.fau.de>)
        id 1d0RbH-0003HZ-1G
        for git@vger.kernel.org; Tue, 18 Apr 2017 11:47:15 +0000
From:   Christoph Egger <egger@cs.fau.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: GIT_EXEC_PATH
Message-Id: <A351EA5C-734D-4833-821F-1B5AA49895BF@cs.fau.de>
Date:   Tue, 18 Apr 2017 13:47:14 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Concerning $GIT_EXEC_PATH .. is that supposed to be a $PATh like variable? as in can it have more than one path (colon-separated)? I have currently two directories there (one with a git-annex installation, one with the normal git stuff) and it seems to mostly work. However git-sh-setup is unhappy:

> % git pull --rebase
> /opt/local/libexec/git-core/git-sh-setup: line 46: /opt/local/libexec/git-core:/Applications/git-annex.app/Contents/MacOS//git-sh-i18n: No such file or directory

  Christoph
