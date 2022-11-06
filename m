Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE0C4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKFSc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKFSc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 13:32:26 -0500
Received: from mail.cboltz.de (mail.cboltz.de [88.99.101.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1BFAFF
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 10:32:23 -0800 (PST)
X-sprachakt.com-SMTP-Auth: no
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.cboltz.de (Postfix) with ESMTP id 834E95C02A1;
        Sun,  6 Nov 2022 19:32:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail.cboltz.de
Received: from mail.cboltz.de ([127.0.0.1])
        by localhost (mail.cboltz.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oYJNWYEOsXSq; Sun,  6 Nov 2022 19:32:20 +0100 (CET)
Received: from [192.168.178.41] (i59F7FFCC.versanet.de [89.247.255.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.cboltz.de (Postfix) with ESMTPSA;
        Sun,  6 Nov 2022 19:32:20 +0100 (CET)
Message-ID: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org>
Date:   Sun, 6 Nov 2022 19:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     git@vger.kernel.org
Cc:     andreas.stieger@gmx.de, tmz@pobox.com
From:   Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Subject: Re: git can not be built for s390x since update to git-2.38.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



 > Gesendet: Mittwoch, 02. November 2022 um 19:49 Uhr
 > Von: "Todd Zullinger" <tmz@pobox.com>
 > An: "Sarah Julia Kriesch" <sarah.kriesch@opensuse.org>
 > Cc: git@vger.kernel.org, andreas.stieger@gmx.de
 > Betreff: Re: git can not be built for s390x since update to git-2.38.0
 >
 > Sarah Julia Kriesch wrote:
 > > I am one of the zsystems Maintainers (s390x architecture) at 
openSUSE and
 > > git can not be built any more since the update from 2.37.3 to 
2.38.0, and
 > > with 2.38.1 afterwards. We have tried to debug it.
 >
 > I don't know if it's of much help, but for what it's worth
 > 2.38.0 and 2.38.1 been built in Fedora for s390x without
 > issue.  Build logs and artifacts for 2.38.1 can be found
 > here:
 >
 >     https://koji.fedoraproject.org/koji/buildinfo?buildID=2077983
 >
Thank you for the hint, that it is working for Fedora!
I have compared your spec file with ours and found, that you have got a 
BuildRequires for jgit only for s390x.

That has solved the problem. Is there any special reason, that s390x 
needs jgit for git builds?

Best regards,
Sarah
 > --
 > Todd
 >
-- 
Sarah Julia Kriesch
openSUSE
