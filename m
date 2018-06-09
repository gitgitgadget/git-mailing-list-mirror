Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3281F403
	for <e@80x24.org>; Sat,  9 Jun 2018 19:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeFITLX (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 15:11:23 -0400
Received: from zimbra.linuxprofi.at ([93.83.54.199]:47726 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbeFITLW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 15:11:22 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 15:11:22 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.linuxprofi.at (Postfix) with ESMTP id 2F4AB2A37D8
        for <git@vger.kernel.org>; Sat,  9 Jun 2018 21:02:00 +0200 (CEST)
Received: from zimbra.linuxprofi.at ([127.0.0.1])
        by localhost (zimbra.linuxprofi.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cHL6cMjUSz7f for <git@vger.kernel.org>;
        Sat,  9 Jun 2018 21:01:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.linuxprofi.at (Postfix) with ESMTP id E0D772A37E0
        for <git@vger.kernel.org>; Sat,  9 Jun 2018 21:01:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.linuxprofi.at
Received: from zimbra.linuxprofi.at ([127.0.0.1])
        by localhost (zimbra.linuxprofi.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O7LTObW6Fc9V for <git@vger.kernel.org>;
        Sat,  9 Jun 2018 21:01:59 +0200 (CEST)
Received: from localhost (178.165.129.234.wireless.dyn.drei.com [178.165.129.234])
        by zimbra.linuxprofi.at (Postfix) with ESMTPSA id AA2F02A37D8
        for <git@vger.kernel.org>; Sat,  9 Jun 2018 21:01:59 +0200 (CEST)
Date:   Sat, 9 Jun 2018 21:01:54 +0200
From:   Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph@boehmwalder.at>
To:     git@vger.kernel.org
Subject: Why is there no force pull?
Message-ID: <20180609190154.yl4ig6dxfihgm5qi@christoph-lap>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Since this is a use case that actually comes up quite often in
day-to-day use, especially among git beginners, I was wondering: is
there a specific reason why a command like "fetch changes from remote,
overwriting everything in my current working directory including all
commits I've made" doesn't exist? Now, I'm quite aware that something
like

    $ git fetch origin/branch
    $ git reset --hard origin/branch

will do the trick just fine, but (like I mentioned, especially for
beginners) this kind of seems like a crook. Why not have a single
command for accomplishing this? Afterall we do have a `--force` flag on
`git push`, which practically does the same thing in reverse.

Just reaching out to get some input on this, as it seems like a quite
curious inconsistency to me.

--
Regards,
Christoph
