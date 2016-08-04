Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D3320193
	for <e@80x24.org>; Thu,  4 Aug 2016 15:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbcHDPQk (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:16:40 -0400
Received: from smtp66.iad3a.emailsrvr.com ([173.203.187.66]:45586 "EHLO
	smtp66.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756395AbcHDPQj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2016 11:16:39 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Aug 2016 11:16:39 EDT
Received: from smtp17.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
	by smtp17.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 5C96AA03D8
	for <git@vger.kernel.org>; Thu,  4 Aug 2016 11:08:35 -0400 (EDT)
X-Auth-ID: edg@greenberg.org
Received: by smtp17.relay.iad3a.emailsrvr.com (Authenticated sender: edg-AT-greenberg.org) with ESMTPSA id 4725EA037E
	for <git@vger.kernel.org>; Thu,  4 Aug 2016 11:08:35 -0400 (EDT)
X-Sender-Id: edg@greenberg.org
Received: from arthur.edgreenberg.net (cpe-69-204-130-58.nycap.res.rr.com [69.204.130.58])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Thu, 04 Aug 2016 11:08:35 -0400
To:	git@vger.kernel.org
From:	Ed Greenberg <edg@greenberg.org>
Subject: Problem with two copies of same branch diverging
Message-ID: <0aab65de-21a3-eb48-c5b0-3e36d924348a@greenberg.org>
Date:	Thu, 4 Aug 2016 11:08:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi, Thanks for reading my question.

I have two copies of code checked out at the same branch. Desktop and 
remote server.

I use an IDE that automatically SFTP transfers each save from the 
desktop to the remote server, so I can run my changes on the server 
environment.

At the end of the session, I commit the code on my desktop, do a git 
push to the repo.

When I look at the server, the code there is identical to what's on my 
desktop box and what I just comitted and pushed, but, of course, git 
status thinks it's all modified and wants me to either commit it or 
stash it.  In fact, doing a git log on the server doesn't show my latest 
push.  So I need to pull the changes, but I can't because I have pending 
stuff.

What's a good git workflow for this save-upload-remote test cycle?

Thanks,

-- 
Ed Greenberg
Glens Falls, NY USA

