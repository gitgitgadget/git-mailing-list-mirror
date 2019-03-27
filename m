Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9B920248
	for <e@80x24.org>; Wed, 27 Mar 2019 12:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfC0M5j (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 08:57:39 -0400
Received: from ikke.info ([178.21.113.177]:55732 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0M5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 08:57:39 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id BD6D14400D5; Wed, 27 Mar 2019 13:57:37 +0100 (CET)
Date:   Wed, 27 Mar 2019 13:57:37 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Petr Bena <petr@bena.rocks>
Cc:     git@vger.kernel.org
Subject: Re: Unable to change remote url of origin
Message-ID: <20190327125737.GA20395@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, Petr Bena <petr@bena.rocks>,
        git@vger.kernel.org
References: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 01:25:27PM +0100, Petr Bena wrote:
> Hello,
> 
> I used to change remote URL simply by editing .git/config (which may not be
> most correct way), but out of sudden I am no longer able to do that. So I
> decided to do it the "proper way" but still - to no avail. Here is what I do
> and also it's visible what is wrong:
> 
> # Display remote URL
> 
> petr.bena@MacBook:~/Documents/grumpy$ git remote -v
> origin    git@github.com:grumpy-irc/grumpy (fetch)
> origin    git@github.com:grumpy-irc/grumpy (push)
> 
> #Now change it to HTTPS instead of SSH
> 
> petr.bena@MacBook:~/Documents/grumpy$ git remote set-url origin
> https://github.com/grumpy-irc/grumpy
> 
> # Verify if it has changed
> 
> petr.bena@MacBook:~/Documents/grumpy$ git remote -v
> origin    git@github.com:grumpy-irc/grumpy (fetch)
> origin    git@github.com:grumpy-irc/grumpy (push)
> 
> 
> It's still SSH. What am I doing wrong?
> 
> petr.bena@MacBook:~/Documents/grumpy$ git --version
> git version 2.21.0
> 
> 
> petr.bena@MacBook:~/Documents/grumpy$ cat .git/config
> [core]
>     repositoryformatversion = 0
>     filemode = true
>     bare = false
>     logallrefupdates = true
>     ignorecase = true
>     precomposeunicode = true
> [submodule]
>     active = .
> [remote "origin"]
>     url = https://github.com/grumpy-irc/grumpy
>     fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>     remote = origin
>     merge = refs/heads/master
> [submodule "src/libgp"]
>     url = http://github.com/grumpy-irc/libgp
> [submodule "src/libirc"]
>     url = http://github.com/grumpy-irc/libirc
> [branch "remote_scripts"]
>     remote = origin
>     merge = refs/heads/remote_scripts
> 

Hello Petr,

What does git config --show-origin remoe.origin.url return?

Kind regards, Kevin
