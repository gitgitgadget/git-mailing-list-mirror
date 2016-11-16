Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167E82042F
	for <e@80x24.org>; Wed, 16 Nov 2016 13:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbcKPNQu (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 08:16:50 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:32819 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbcKPNQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 08:16:48 -0500
Received: by mail-qt0-f177.google.com with SMTP id p16so99755739qta.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JHlQap97rxfQNtkctgw29nrAYVI+muhaHQ13mM9g2Y=;
        b=pRBBv/PJw0zpUa881M83KuGRq2h4C0m38oSDPsciW3Oz8/tBlTVFhKTNG5yzBXPFDH
         BKlTkLHNI1eRzJCOX7yGJTCNbDHjeCJURWBcvGmmO67//FXTP5fnkA1HZkO75qVZL6Nf
         o4OBZ61appofo8myFf1O1dwFuOColiq9QTFLyKQZzCICamxxGUV8x/6AabJebz3tzQ1F
         x7zFF2/YBetYKa/ciKDZuQlRbMr7Ed1bOwLVamZNrNZAkBZRNDQISDBFBWfdaKZcuR3Z
         1heA1KAh3p3NA2bXTi/GQlt6X9mSPQ6lvXTW/xgthgI5mkU3BogdsZVYfN3o8dr8zAnR
         /D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JHlQap97rxfQNtkctgw29nrAYVI+muhaHQ13mM9g2Y=;
        b=kSk21TsISc0GygyRyk1oZjw4Z+/0c5VoxW2wZe1dLDa1NFoVMFU/dhWmD/OvxnbCfv
         6bMU4g8tQxIEXE1+qGtZemHtxDBgtPW4ouNZSIiS5xgzZdwflSEIqekfuK5tVDSuYTqE
         cPjkIzPwBuTKqkITxw6kGMkFfe9/Lq6TmgJ4LW+AcX8Lp8RhrVUsmfChwWIKW5PsJ9aG
         eoHaUacHihzgdJdkhGSZXv+pHwblByxspH7rr1nWN+I2rAJ3ERkOmw2m5mbTWDK85iR/
         cGHZUjz/M8+o5zlSWAnkcy/7IINT/LBmsiK4GoHLNzP6zipaIp4TLty/w1vGwYdnBnDV
         9E+A==
X-Gm-Message-State: ABUngveqCLqlQJB1gxwm3MYmJstBqk1xupcScrE7pM0eJ/6x5ecqTc0YX0SHkBWen6ftsg==
X-Received: by 10.25.209.136 with SMTP id i130mr1067179lfg.1.1479302207428;
        Wed, 16 Nov 2016 05:16:47 -0800 (PST)
Received: from debian (c83-253-195-111.bredband.comhem.se. [83.253.195.111])
        by smtp.gmail.com with ESMTPSA id g12sm2877672lfg.28.2016.11.16.05.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Nov 2016 05:16:45 -0800 (PST)
Received: from iveqy by debian with local (Exim 4.84)
        (envelope-from <iveqy@paksenarrion.iveqy.com>)
        id 1c709y-000163-51; Wed, 16 Nov 2016 14:21:54 +0100
Date:   Wed, 16 Nov 2016 14:21:54 +0100
From:   Fredrik Gustafsson <iveqy@iveqy.com>
To:     Renuka Pampana <prenuka@gmail.com>
Cc:     Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
Subject: Re: Git status takes too long- How to improve the performance of git
Message-ID: <20161116132154.GA18362@paksenarrion.iveqy.com>
References: <1479202392275-7657456.post@n2.nabble.com>
 <20161115102400.GC28860@paksenarrion.iveqy.com>
 <CAEAva_1JAu+kWmk3MZDFK=4CgQB5M+JN8FwzMVr6zKgXTAhdXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAva_1JAu+kWmk3MZDFK=4CgQB5M+JN8FwzMVr6zKgXTAhdXw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 05:13:57PM +0530, Renuka Pampana wrote:
> > On Tue, Nov 15, 2016 at 02:33:12AM -0700, ravalika wrote:
> > > It is an centralized server and git status takes too long
> >
> > A centralized server? How? git is designed to be runned locally. If
> > you're running git on a network file system, the performance will
> > suffer. Could you elaborate on how your environment is setup?
> >
> >
> We have setup main git repository in remote location on Linux server
> And created a git repository in local Linux server, as a reference for the
> remote git repository,
> And update the local git repository for every 15 min in local server
> 
> Users will be able to access the  local git repository through NFS

And each user will have their own copy of the repository locally on
their machine? That is having done a git clone?
> 
> All users will clone the git repository from remote project url  by using
> local git repo as reference
> 
>  For example : git clone --reference ~/gitcaches/reference user@drupal
> :/home/project/drupal.git
> 
> All the users have ssh credentials for the remote server

Why are you using --reference for a 8.9MB big clone?
> 
> 
> What is the best way to implement remote git repo and able to access the
> git repo from other location, without any performance glitches?
> Users should be able to access git repo from different servers and from
> different locations.

The best way is to have it locally cloned. Yes the initial clone will be
expensive but operations after that will be fairly smooth. You do not(!)
want to execute git on one machine and having the repository beeing on
an other machine (for example via a network file system, except git
clone, git fetch, git push, etc.).

> >
> > > How to improve the performance of git status
> > >
> > > Git repo details:
> > >
> > > Size of the .git folder is 8.9MB
> > > Number of commits approx 53838  (git rev-list HEAD --count)
> > > Number of branches -  330
> > > Number of files - 63883
> > > Working tree clone size is 4.3GB
> >
> > .git folder of 8.9 MEGABYTE and working tree of 4.3 GIGABYTE? Is this a
> > typo?
> >
> > All git related information is stored in .git directory of the working
> directory
>   It is 8.9M
> And size of the local workspace is 4.3G

Can you please elaborate on this? How can you store 8.9 MB of data that
will result in a 4.3 G workspace?

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
