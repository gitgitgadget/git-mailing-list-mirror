Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D004A1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 13:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758838AbcHYNbj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 09:31:39 -0400
Received: from smtp154.dfw.emailsrvr.com ([67.192.241.154]:35625 "EHLO
        smtp154.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbcHYNbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 09:31:38 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Aug 2016 09:31:38 EDT
Received: from smtp32.relay.dfw1a.emailsrvr.com (localhost [127.0.0.1])
        by smtp32.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id AAEE9A0366
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 09:24:47 -0400 (EDT)
X-Auth-ID: edg@greenberg.org
Received: by smtp32.relay.dfw1a.emailsrvr.com (Authenticated sender: edg-AT-greenberg.org) with ESMTPSA id 87F4CA0352
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 09:24:47 -0400 (EDT)
X-Sender-Id: edg@greenberg.org
Received: from arthur.edgreenberg.net (cpe-69-204-130-58.nycap.res.rr.com [69.204.130.58])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.7);
        Thu, 25 Aug 2016 09:24:47 -0400
From:   Ed Greenberg <edg@greenberg.org>
Subject: git push origin BRANCHNAME question
To:     git@vger.kernel.org
Message-ID: <372e0def-4602-56f5-d070-967e6a8c10ab@greenberg.org>
Date:   Thu, 25 Aug 2016 09:24:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I understand this from the git-push man page, but I want to make 
sure:

I have two branches, master and develop.

If I am (accidentally) sitting on master, and issue 'git push origin 
develop', does this properly push develop to remote develop, or does it 
push master to remote develop (which seems to be bad, in the most common 
use case.)  ?

Thanks,

Ed


-- 
Ed Greenberg
Glens Falls, NY USA

