Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A25C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA63760E52
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 17:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhKARdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:33:12 -0400
Received: from omta013.uswest2.a.cloudfilter.net ([35.164.127.236]:48986 "EHLO
        omta013.uswest2.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231892AbhKARdL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Nov 2021 13:33:11 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 13:33:11 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.209])
        by cmsmtp with ESMTP
        id hYY2mtE8Lydxuhb1smiHiP; Mon, 01 Nov 2021 17:23:28 +0000
Received: from thunderbird.smith.home ([68.231.75.33])
        by cmsmtp with ESMTPSA
        id hb1pmO8ynB82Ohb1rm5VwV; Mon, 01 Nov 2021 17:23:28 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.4 cv=K9hBowaI c=1 sm=1 tr=0 ts=61802290
 a=WsxEcZHXDFRvve1sQRspCw==:117 a=WsxEcZHXDFRvve1sQRspCw==:17
 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=3s-vBJz8GoMgv9zTGrsA:9 a=CjuIK1q_8ugA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 231642E00063
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 10:23:25 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: make failure when  building on cygwin.
Date:   Mon, 01 Nov 2021 10:23:25 -0700
Message-ID: <2285333.UEd3U9ABtK@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CMAE-Envelope: MS4xfP0DVf23I+5EgfaXlXtohsgwWYYOS5Ip9oNWMtpjoBPFEo8KNYuJno46bx7um8GZWAPfeACFwblg4ogL692wBRhy/m6i3NKYt7j58TlAW8emwgCReMMr
 nT8/ccmB/Xap3THRsnHHitXvjt4wdILGfY5I/5+pWC9LNKEgTZuuln+81kiYtVnZD4kQYIR3kObxkw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried to build the 2.34.0 version on cygwin and received the following.  I 
am using commit 7e27bd589d328b9da.  the make utility is GNU Make 4.2.1

$  make prefix=/usr/local all html 
GIT_VERSION = 2.34.0.rc0.dirty 
GIT_VERSION = 2.34.0.rc0 
GIT_VERSION = 2.34.0.rc0.dirty 
GIT_VERSION = 2.34.0.rc0 
GIT_VERSION = 2.34.0.rc0.dirty 
GIT_VERSION = 2.34.0.rc0

I broke out of the build and and re-issued the make command at which point the 
code starts to build correctly.

This is just an FYI.



