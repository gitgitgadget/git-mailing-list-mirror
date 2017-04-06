Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DB51FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 14:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934953AbdDFOLk (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 10:11:40 -0400
Received: from meddle.ricozome.net ([213.136.74.197]:45794 "EHLO
        meddle.ricozome.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934646AbdDFOLi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 10:11:38 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Apr 2017 10:11:38 EDT
Received: from [192.168.42.39] (57.17.136.77.rev.sfr.net [77.136.17.57])
        by meddle.ricozome.net (Postfix) with ESMTPSA id 3AF9760A6F
        for <git@vger.kernel.org>; Thu,  6 Apr 2017 16:03:19 +0200 (CEST)
From:   Eric Belhomme <rico-ml@ricozome.net>
Subject: how-to get commit content with pre-receive hook ?
To:     git@vger.kernel.org
Message-ID: <955c152a-b278-ecfd-8bc7-671c3aa81dc6@ricozome.net>
Date:   Thu, 6 Apr 2017 16:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello the list,

Until now I ever had a quite "basic" Git usage, but now I'm working on a 
project based on Git hooks feature.. and I'm a very beginner with Git 
hooks !

My need consist doing a syntax check on submitted files before a 'git 
push'. So the right hook is 'pre-receive' and I'm already able to 
identify the files I want to check using 'git show'.

But I don't know how to get the *content* of the file being submitted to 
run my syntax check rules against it !

I googled but most examples using pre-receive I found are doing sanity 
check on enveloppe but never on actual content of the file !

Could someone here put me on the rails ?

Regards,

-- 
Eric

