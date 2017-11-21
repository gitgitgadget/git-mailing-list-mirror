Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4F92036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdKUWGD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:06:03 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:48726 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751339AbdKUWGC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2017 17:06:02 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Nov 2017 17:06:02 EST
Received: from CMOut01 (unknown [10.0.90.82])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 334F21E09C6
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 14:42:23 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by CMOut01 with 
        id cliJ1w00m0QvKlu01liNVd; Tue, 21 Nov 2017 14:42:22 -0700
X-Authority-Analysis: v=2.2 cv=K4VSJ2eI c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=sC3jslCIGhcA:10 a=h9fvwNikAAAA:8 a=NEAV23lmAAAA:8
 a=zfxOeNzCKgb1qnYvX3cA:9 a=QEXdDO2ut3YA:10 a=FtDhlDV5sdB6JbnI9c3R:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PCpbiU4GUI1Ezj+zhY99M/6o4cWcK4LjPdOIxk7Z7UA=; b=bGv59ztE8D7zLnAVnSzn689qxg
        fKfNoLeZJRvpx1u95/zMVY+puvyLbnwZgY/cbk3FXhFHXOmPt9YJcsA0J28BE8eiv8Q1lsFIX0nPQ
        5nF9mdOccp2J/hAbaoso4sYgf;
Received: from [50.226.24.42] (port=37248 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <paul@mad-scientist.net>)
        id 1eHGJ8-000l2Y-J6; Tue, 21 Nov 2017 14:42:18 -0700
Message-ID: <1511300532.7410.19.camel@mad-scientist.net>
Subject: Re: bash script to pull in branch B the changes from parent branch A
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Laetitia Pfaender <laetitia.pfaender@icloud.com>,
        git@vger.kernel.org
Date:   Tue, 21 Nov 2017 16:42:12 -0500
In-Reply-To: <BEFA6451-9A9A-4B44-B067-727136AD39EF@icloud.com>
References: <BEFA6451-9A9A-4B44-B067-727136AD39EF@icloud.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Exim-ID: 1eHGJ8-000l2Y-J6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:37248
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-11-22 at 00:19 +0800, Laetitia Pfaender wrote:
> cd repo-in-branchB
> git branch --set-upstream-to=origin/branchB
> git pull
> 
> git branch --set-upstream-to=origin/branchA
> git pull
> git branch --set-
> upstream-to=origin/branchB
> 
> It does exactly what I want but, as I have
> many children branches B to update, I would like to prompt my
> username and password only once and then makes the script use them in
> all following git requests.

It would be nice if you explained in words exactly what it is you want
to do.

This seems like a lot more work than necessary.  A "git pull" consists
of two steps: first a "git fetch" which is the part that actually goes
out to the remote and pulls all the new content, and then a merge
operation to the remote's version of the current branch.

The "git fetch" is all that needs credentials, and it pulls the entire
contents of the repo including all branches, so you only need to do it
once.

Is there some reason why you can't do the following:

  cd repo
  git fetch (requires you to enter username/password)
  git merge origin/branchB
  git merge origin/branchA

and just continue to merge for each different branch (without re-
running git fetch)?

>  I came to the conclusion that I needed to update my script as
> follow:
> echo “pull from branchB"
> git pull https://$username:$password@g
> ithub.com/myrepo.git heads/branchB
> echo “pull from parent branchA"
> git
> pull https://$username:$password@github.com/myrepo.git heads/branchA
>  I came to the conclusion that I needed to update my script as
> follow:
> echo “pull from branchB"
> git pull https://$username:$password@g
> ithub.com/myrepo.git heads/branchB
> echo “pull from parent branchA"
> git
> pull https://$username:$password@github.com/myrepo.git heads/branchA

Don't know how well this works as I don't use HTTPS remotes very much. 
But note, this will make your username AND password for your GitHub
account visible to anyone one the system who happens to run "ps" while
your pull command is running.
