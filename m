Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C375BC433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 08:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGKIBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGKIBO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 04:01:14 -0400
X-Greylist: delayed 3769 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 01:01:12 PDT
Received: from ns29.pws-dns.net (ns29.pws-dns.net [176.9.29.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277C010B7
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=alirezaarabi.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GzN2mh+1cw0IOYtCBTvUcTlAo7K9nFgmOJOrqesb/no=; b=iuphRDorQxZfhro2Eg9yQShBKt
        Hy4g27/JljJm1zKVgho7T6AtiDrNdyPpoCWp/KQO5w6cHqbBxI6HYsVM3w36AZ6R7f+479zoknqak
        445oypwKpTsze3IDee5Oba4P4aHnkbzeNuAEsz7GZH6vxPckGW3dWLEHwLUgOD5/6/9HTIwLf8Azb
        S7JeBFy/ws6oOX7xkB952Ohzg/SmAXQQEb4upZSSvJnfQ+s7+1IxFmlGcn8SsXbIX8dXkuscHP7Jc
        zZ2xmn/0otdWEHGWXY6uwsEHIVwlgjWTNaTMhSU7fTahDf/xMwUzdyndYbi3GvaOU62wMEECEGHE/
        Fsg1nSMg==;
Received: from [::1] (port=47930 helo=dena.pws-dns.net)
        by dena.pws-dns.net with esmtpa (Exim 4.95)
        (envelope-from <me@alirezaarabi.com>)
        id 1oAnN7-0001kn-Gr
        for git@vger.kernel.org;
        Mon, 11 Jul 2022 11:28:21 +0430
MIME-Version: 1.0
Date:   Mon, 11 Jul 2022 11:28:21 +0430
From:   me@alirezaarabi.com
To:     git@vger.kernel.org
Subject: Suggestion for 'git add' CLI
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <84b593cf1bacc4541a7a4ca24a5e98fa@alirezaarabi.com>
X-Sender: me@alirezaarabi.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - dena.pws-dns.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - alirezaarabi.com
X-Get-Message-Sender-Via: dena.pws-dns.net: authenticated_id: me@alirezaarabi.com
X-Authenticated-Sender: dena.pws-dns.net: me@alirezaarabi.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi there, I have a suggestion about git CLI.when I use 'git add -A' or 
'git add --all' it stages all of my files but when I use git add 
<file_name> it adds the file name to the stage, not all files. but when 
I use ' git add <file_name> --all ' it also works and adds all the files 
to the stage. I think it's better to provide a warning for this 
situation. thank you.
