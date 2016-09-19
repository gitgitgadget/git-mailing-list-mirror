Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C14A2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 16:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbcISQQv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 12:16:51 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:50120 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbcISQQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 12:16:48 -0400
Received: from PhilipOakley ([92.22.33.116])
        by smtp.talktalk.net with SMTP
        id m1FObM0sMcpskm1FObad4a; Mon, 19 Sep 2016 17:16:46 +0100
X-Originating-IP: [92.22.33.116]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=7PoCAWDTb98b1EGiAsJI/w==:117
 a=7PoCAWDTb98b1EGiAsJI/w==:17 a=8nJEP1OIZ-IA:10 a=oyJryGUDAAAA:8
 a=5rxgeBVgAAAA:8 a=1WaDvLUbEPLEJBMl_LAA:9 a=wPNLvfGTeEIA:10
 a=jviETkYY7X6vd3vjkJu2:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <3999677D12354A3CB2035E932353981A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Paul Williamson" <paul.williamson@mediamiser.com>,
        <git@vger.kernel.org>
References: <YQXPR01MB0023CDCFA27BDD4959B4F9B19EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
Subject: Re: Switching branches not working in a cloned repo
Date:   Mon, 19 Sep 2016 17:16:48 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDxETgKkn1WlxVPRWSYl5LxRuBB5xKp4cj+osgBalWSIhjkbUlhKVo1aejYU4COhMaEJadSID1S1s9pMLttlHamxPmvx0T/NKRG7yEoEDrNi+QzthR7/
 oZt4x2AlA4NQ6olXgw2AP6FrdiAxSPYncdis7QfWTBtSmJWyeb0Yh8I11I7BxMTaM8qatThm9k2rKAhZ0Y4fvapwENRcE1DRF1c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Paul Williamson" <paul.williamson@mediamiser.com>
> Hi,
>
> We use git extensively on a number of repos. Recently, we have had a 
> problem with one of them. This repo has a 'web_dev' branch. For copies of 
> the repo cloned before a certain (recent but unidentified) time, we could 
> 'git checkout' between master and web_dev and everything would be normal.
>
> However, now if we clone the repo, we can no longer do 'git checkout 
> web_dev'. Git doesn't complain, in fact there is no feedback and we are 
> still in the master branch. Running 'git branch -r' still shows the branch 
> as existing at origin.

Have you tried `git ls-remote` ?

The `branch -r` just lists the local 'rtb's (IIUC).

It could be someone has accidently pruned or deleted that branch at the 
remote.

What version are you (they) on?

>
> If we try 'git branch web_dev' we then see web_dev listed locally and can 
> switch to it BUT on closer inspection we realise that this action has 
> created a new branch off master.
>
> The first time we saw this was under Bash on Windows, so we thought maybe 
> it was a beta problem, but a) other repos work as expected under that 
> environment, and b) under cygwin, pulling the same repo to a new directory 
> alongside an older copy shows that the problem occurs with the new clone, 
> but not the one that that was cloned longer ago.
>
> Also in this situation, there are no local outstanding code changes that 
> might cause problems switching branches. This occurs right from a cleanly 
> cloned repo.
>
> It seems something has gone wrong with this repo, and we don't know what. 
> It's a tough problem to google, and I was not able to search the gmane 
> archives (DNS errors).

Gmane had to quit. Try http://public-inbox.org/git (see the help link)

>
> Any idea how to investigate?
>
> Thanks,
> Paul
--
philip 

