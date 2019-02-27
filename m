Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5475920248
	for <e@80x24.org>; Wed, 27 Feb 2019 17:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfB0R5O convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Feb 2019 12:57:14 -0500
Received: from ec2-18-228-164-192.sa-east-1.compute.amazonaws.com ([18.228.164.192]:57289
        "EHLO projectstore.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfB0R5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 12:57:13 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 12:57:12 EST
Received: from mail.obsigna.com (unknown [189.29.185.66])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by projectstore.net (Postfix) with ESMTPSA id 4675E1E11CF
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 14:50:46 -0300 (-03)
Received: from rolf-mini.obsigna.com (rolf-mini.obsigna.com [192.168.222.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.obsigna.com (Postfix) with ESMTPSA id EE8E21350FB1C
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 14:50:42 -0300 (-03)
From:   "Dr. Rolf Jansen" <rj@obsigna.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: I want to adapt the Integration Manager Workflow in-house
Message-Id: <BEAB7550-F7BB-4AF9-9791-688C1FBE0683@obsigna.com>
Date:   Wed, 27 Feb 2019 14:50:42 -0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

By reading the Git documentation and other resources, I am convinced that the Integration Manager Workflow would be best for continuing with the development on a broader basis of a certain project - this is out of question - I want the IMW.

This project got a few years of history by a single developer using Subversion (a few hundreds of commits and about 100 source files). I managed already to 'git svn clone ...' the whole original SVN history into a bare repository on a dedicated server (FreeBSD), and I called this one "Commons.git". I am able to clone a working copy of it to my development machine, and pushing/pulling does work as expected, also the whole SVN commit history is accessible, so up to this point everything looks fine.

Now, I want to set up the requisites for the Integration Manager Workflow for 2 developers (I expect more to join the project later, however let's start with 2). Now, reading some tutorials, I am stuck already right at the beginning. Some start by setting up empty repositories from the scratch (which does not match my case) in another tutorial I read "1. Fork your existing repository ...", however the actual Git commands, how to "fork" are missed out, and Git does not have a fork command, I can clone something or create branches, though.

Questions:

1)   In order to set up the public developer "Derivate-A.git" and "Derivate-B.git" repositories from the "Commons.git" (blessed) repository, what does forking mean in terms of actual Git commands on the server side?

Would I simply do:
   cd /path/to/the/git-repositories/TheTinyThing
   git clone --bare Commons.git Derivate-A.git
   git clone --bare Commons.git Derivate-B.git

Developer A and developer B then would simply clone respective working copies to their local developer machines and would start working, won't they?

Or would I need to do some sort of branching? In this case please can somebody give a pointers on where (server or client side) and how the branches would be created and perhaps uploaded to the repository server, again in terms of actual Git commands?


2)   Developer A made some changes on his Derivate A, which were already pushed to the respective repo on the server. What does the Integration Manager who knows already about the exact details of the changes need to do in terms of actual Git commands to get the changes pushed or pulled or merged or whatever from "Derivate-A.git" into "Commons.git"?


3)   So, the changes from Developer A which were integrated into "Commons.git" are interesting for Developer B as well. What would the Integration Manager or Developer B need to do in terms of actual Git commands in order to update "Derivate-B.git" with all the changes which made it into "Commons.git" since?

GitHub, GitLab or alike are not an option, so please may I ask to give your advices in terms of plain git commands. We are using Git version 2.21.0 on the FreeBSD server and the developer machines.

Many thanks for any help.

Best regards

Rolf
