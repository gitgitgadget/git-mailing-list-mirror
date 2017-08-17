Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4627220899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbdHQVhI (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:37:08 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:37784 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbdHQVhH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:37:07 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Aug 2017 17:37:07 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 3F950160881;
        Thu, 17 Aug 2017 14:29:49 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TF7iAuOzx7TC; Thu, 17 Aug 2017 14:29:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 209AA16088B;
        Thu, 17 Aug 2017 14:29:48 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o5lwdllzY6hg; Thu, 17 Aug 2017 14:29:48 -0700 (PDT)
Received: from Penguin.CS.UCLA.EDU (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 09520160880;
        Thu, 17 Aug 2017 14:29:48 -0700 (PDT)
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
From:   Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: Inconsistent exit code for `git grep --files-without-match` with
 `--quiet`
Organization: UCLA Computer Science Department
Message-ID: <8ec1ac20-162f-d888-fd14-ea47d7e39a38@cs.ucla.edu>
Date:   Thu, 17 Aug 2017 14:29:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony reported this issue to bug-grep@gnu.org. From what I can see, 
git-grep's behavior is better, so I changed GNU grep to behave like 
git-grep. Please see:

https://debbugs.gnu.org/28105

I hope this saves you folks a little bit of work.

