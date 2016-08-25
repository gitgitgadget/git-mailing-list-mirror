Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2742018E
	for <e@80x24.org>; Thu, 25 Aug 2016 13:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933427AbcHYNQw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 09:16:52 -0400
Received: from smtp98.iad3a.emailsrvr.com ([173.203.187.98]:33287 "EHLO
        smtp98.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754479AbcHYNQv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Aug 2016 09:16:51 -0400
Received: from smtp21.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp21.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id E232B404A4
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 09:16:50 -0400 (EDT)
X-Auth-ID: edg@greenberg.org
Received: by smtp21.relay.iad3a.emailsrvr.com (Authenticated sender: edg-AT-greenberg.org) with ESMTPSA id CB591404AA
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 09:16:50 -0400 (EDT)
X-Sender-Id: edg@greenberg.org
Received: from arthur.edgreenberg.net (cpe-69-204-130-58.nycap.res.rr.com [69.204.130.58])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.7);
        Thu, 25 Aug 2016 09:16:50 -0400
To:     git@vger.kernel.org
From:   Ed Greenberg <edg@greenberg.org>
Subject: git push origin BRANCHNAME question
Message-ID: <6c4fbb7d-6f67-b454-2b4b-9f5fbeffae9b@greenberg.org>
Date:   Thu, 25 Aug 2016 09:16:50 -0400
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

