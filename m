Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF2C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 10:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiESK6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 06:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiESK6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 06:58:13 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 03:57:56 PDT
Received: from mx01.rexx-systems.de (mx01.rexx-systems.de [85.25.89.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DFFAFAFD
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:57:55 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mx01.rexx-systems.de
Received: from [10.0.0.124] (unknown [84.46.96.242])
        by mx01.rexx-systems.de (Postfix) with ESMTPSA id 90CBE16DC500
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:49:06 +0200 (CEST)
Message-ID: <06458e21-bdd3-904a-869f-88a26552d5bb@rexx-systems.de>
Date:   Thu, 19 May 2022 12:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Florian Steenbuck <florian.steenbuck@rexx-systems.de>
Subject: Feature Request: add interactive accept only remove or add changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

can you guys add -at least- in the git add interactive mode

a feature to only accept add or remove changes

or is this too much patch tooling ?

Kind Regards
Florian

Context

I'm today end up in editing about 99 hunks via add -p, which is for the 
confusion about
`@@ +55,4 -52,2 @@`
quite hard if I want to using the self checking behavior of the patch format

But not only that, what I would guess is now days not used anymore in 
patch tooling, it is also
the count of hunks I would end up with understand and need to edit,

so if we exhausted this feature it would be a pleasure to add this not 
only to the interactive mode

This is about a README.md file so it is more an unexpected file for git, 
but I think this is useful with
much longer files that are from my experience are also used in companies
(translation files, historical grown source code, ...)

