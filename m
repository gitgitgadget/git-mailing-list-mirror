Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68301C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 09:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiDWJVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiDWJV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 05:21:27 -0400
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Apr 2022 02:18:30 PDT
Received: from hosting01.xaranet.de (hosting01.xaranet.de [192.162.85.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC48DF83
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 02:18:30 -0700 (PDT)
Received: from [192.168.178.20] (p54a37379.dip0.t-ipconnect.de [84.163.115.121])
        by hosting01.xaranet.de (Postfix) with ESMTPSA id 8C837A0DFF
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 11:12:17 +0200 (CEST)
Authentication-Results: hosting01.xaranet.de;
        spf=pass (sender IP is 84.163.115.121) smtp.mailfrom=guy.j@maurel.de smtp.helo=[192.168.178.20]
Received-SPF: pass (hosting01.xaranet.de: connection is authenticated)
Message-ID: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
Date:   Sat, 23 Apr 2022 11:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     git@vger.kernel.org
Content-Language: de-DE
From:   Guy Maurel <guy.j@maurel.de>
Subject: a problem with git describe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <165070513782.31687.8472548236723905393@hosting01.xaranet.de>
X-PPP-Vhost: maurel.de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I am using git version 2.25.1

6-8 weeks ago I don't get any problem.
Now I get :
guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
[sudo] password for guy:
fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)

What is to do?

Thanks for any help
guy
-- 
Guy Maurel
Sebastian-Fischer-Weg 13
89077 Ulm/ Germany
