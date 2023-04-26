Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0EAC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjDZRaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbjDZR3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:29:53 -0400
X-Greylist: delayed 912 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 10:29:46 PDT
Received: from mx8.oobauth.net (mx8.oobauth.net [3.13.76.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006378A4C
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=sftnj.com; s=8D85AC3DAF2842F;
        c=simple/simple; t=1682530180;
        h=reply-to:from:to:subject:date:message-id:mime-version:x-mailer:
        thread-index:x-messagesniffer-identifier:x-gbudb-analysis:
        x-messagesniffer-scan-result:x-messagesniffer-rules:x-declude-sender:
        x-declude-spoolname:x-declude-refid:x-declude-note:x-declude-scan:
        x-declude-tests:x-country-chain:x-declude-code:x-helo:x-identity;
        bh=Uv8KGkp4tEbJoHNWXCq5Y/PqLeUCoUEx5h4Zc8F3jRQ=;
        b=KE/KrYWY/YK33J2dKWjJTX7w0NKDzllwaFA7he8QQj/aeN0AjDb3h37MPQmF2TftyHatd67xjzY
        cw4zwstST6uF81U9FWkqNlZbyJP5F+42IbaS2+R2sSTZiKMtvdCPipTGABo96mwftTbcVhpQtq95e
        XIre6iwRDaQ/d8DuZPBXdbSs0C+gVhxLuZ8D8OrAF1iPNENIUXsgv8w7cAayTgmccXoMIvmeWCVw3
        oyFG8PQpuFE0QchzlM/jIQnVF33aNlKlS51cSO1+1ISw2enMi9NqkDt1FJ7xdFbyL7QEp7C8Wwp8R
        +Ew9kknZfC8dcVZX+ElQjKCzGoPt+lm2YVOA==
Received: from sft51 (ool-2f163dc2.static.optonline.net [47.22.61.194]) by mx8.oobauth.net with SMTP
        (version=Tls12
        cipher=Aes256 bits=256);
   Wed, 26 Apr 2023 13:14:14 -0400
Reply-To: <mbrenner@zerify.com>
From:   <mbrenner@sftnj.com>
To:     <git@vger.kernel.org>
Subject: git-gui (Windows) bug report
Date:   Wed, 26 Apr 2023 13:14:14 -0400
Message-ID: <005601d97862$869fad80$93df0880$@sftnj.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adl4YhXKiWdO3nqRQ1WQR4wTLvAESQ==
Content-Language: en-us
X-MessageSniffer-Identifier: m:\SmarterMail\Spool\proc\work\20356170.eml
X-GBUdb-Analysis: 0, 47.22.61.194, Ugly c=0.487159 p=-1 Source White
X-MessageSniffer-Scan-Result: 0
X-MessageSniffer-Rules: 0-0-0-3379-c
X-Declude-Sender: mbrenner@sftnj.com [47.22.61.194]
X-Declude-Spoolname: 20356170.eml
X-Declude-RefID: 
X-Declude-Note: Scanned by Declude 4.12.11
X-Declude-Scan: Outgoing Score [0] at 13:14:19 on 26 Apr 2023
X-Declude-Tests: Whitelisted
X-Country-Chain: UNITED STATES->destination
X-Declude-Code: e
X-HELO: sft51
X-Identity: 47.22.61.194 | ool-2f163dc2.static.optonline.net | vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git-gui (windows) action "Explore working copy" fails.

What did you do before the bug happened? (Steps to reproduce your issue)
Opened a repository using git-gui (On Windows server 2019)
Selected "Repository" then "Explore working copy"

What did you expect to happen? (Expected behavior)
File Explorer (explorer.exe) should open in the working directory

What happened instead? (Actual behavior)
Error dialog appears with message "Error: explorer.exe not found in PATH"

What's different between what you expected and what actually happened?
Explorer.exe is in the PATH in Windows and running the command displayed in
the detail of the error in GIT-BASH
"exec explorer.exe {C:\Shares\SFT04\G\gitrepo\SCloud2\SCVPortal} &"
yields the desired result. (explorer.exe launches, displaying the working
directory)

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.1.windows.1
cpu: x86_64
built from commit: ceee26d5cac05a3437097b43d034c4ad2e99d571
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 17763
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]


