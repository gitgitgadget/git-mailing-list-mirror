Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E0BC433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 17:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiI2RvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiI2RvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 13:51:13 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 10:51:10 PDT
Received: from horde.mon-net.org (horde.mon-net.org [62.220.131.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B16113D
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 10:51:09 -0700 (PDT)
Received: by horde.mon-net.org (Postfix, from userid 33)
        id 40768183C69; Thu, 29 Sep 2022 19:45:55 +0200 (CEST)
Received: from 212-147-28-203.fix.access.vtx.ch
 (212-147-28-203.fix.access.vtx.ch [212.147.28.203]) by horde.mon-net.org
 (Horde Framework) with HTTPS; Thu, 29 Sep 2022 17:45:55 +0000
Date:   Thu, 29 Sep 2022 17:45:55 +0000
Message-ID: <20220929174555.Horde.GxbsiD55796RgkXu89v-Gc6@horde.mon-net.org>
From:   Jesus Zen =?utf-8?b?RHJvw69k?= <contact2022@engrenage.ch>
To:     git@vger.kernel.org
Subject: feature request - file ordering in `git status`
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

untracked files in `git status` are shown in order of

[0-9]
[A-Z]
[a-z]

it would be nice to have flags to change this behaviour, to:

- ignore case
- sort by date (most recent first... most important and should be the default
   IMHO)

[System Info]
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.59-gentoo-x86_64 #1 SMP Wed Aug 31 09:27:53 CEST 2022 x86_64
compiler info: gnuc: 11.3
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

-- 
The e-mail address used as "sender" is a temporary e-mail address. If  
you feel you need to keep contact with me for more than a few weeks or  
months, please request a permanent, personal e-mail address to which  
to send your messages.

This email and any attachments to it may be confidential and are  
intended solely for the use of the individual to whom it is addressed  
(indicated by the account details in the subject line). Please notify  
the sender immediately by e-mail if you have received this e-mail by  
mistake and immediately delete this e-mail from your system. E-mail  
transmission cannot be guaranteed to be secure or error-free as  
information could be intercepted, corrupted, lost, destroyed, arrive  
late or incomplete, or contain viruses. The sender therefore does not  
accept liability for any errors or omissions in the contents of this  
message, which arise as a result of e-mail transmission.
