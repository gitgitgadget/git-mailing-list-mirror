Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F292C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562C120704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 15:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgDYPjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:39:07 -0400
Received: from relay.secumail.de ([212.11.224.34]:42055 "EHLO
        relay.secumail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgDYPjH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 11:39:07 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Apr 2020 11:39:07 EDT
Received: from sprizz4-2953.local (p2E542407.dip0.t-ipconnect.de [46.84.36.7])
        (authenticated bits=0)
        by relay.secumail.de (8.15.2/8.15.2/Debian-10) with ESMTPSA id 03PFVFvg020489
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 25 Apr 2020 17:31:16 +0200
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at relay.secumail.de
To:     git@vger.kernel.org
From:   Dirk <dirk@ed4u.de>
Subject: Problem with empty lines in .git-credentials
Message-ID: <ad80aa0d-3a35-6d7e-7958-b3520e16c855@ed4u.de>
Date:   Sat, 25 Apr 2020 17:31:10 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060111
 Thunderbird/1.5 Mnenhy/0.6.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everybody,

I am using  latest ubuntu patch git 1:2.17.1-1ubuntu0.7:

It seems empty lines in .git-credentials files are now misinterpreted as
bad urls. Removing an empty line in this file removed the problem for me
(see my answer in https://stackoverflow.com/a/61420852/5005936).

Maybe you should review one of the latest patches. I propose to ignore empty
lines or maybe also ignore comment lines starting with #.

Thank you very much
Dirk

