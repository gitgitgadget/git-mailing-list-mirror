Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2991F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHOXoN (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:44:13 -0400
Received: from server65.mylittledatacenter.com ([78.46.58.69]:48582 "EHLO
        server65.mylittledatacenter.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbeHOXoN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Aug 2018 19:44:13 -0400
X-Greylist: delayed 3306 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2018 19:44:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=hadisafari.ir; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PQRYp9t7Szw53HQPrtKmtKJMWbqBo0B9OzLrgNMTlS0=; b=w5zOernaQndnz6jpgLtCW485TS
        OrzAX0olpuEF7HHCoconi62BJaQKEoQk8eiHKhdOzuitg1kE38T5nJ5MBdvv605cFQxDkuwNU3wR7
        nUWbPJpcijQA2PphzuAh5P3meRl64hXL5KLkxglaEy01c/UMGSHlJfjFKqKlomRKJA2mStnBs0XB2
        0ggBWCgHnlJD32QskBttA6195wxwOf3QBx6iK2cK9CgLXbmWl0LHUBnmYc4F9/EhyMKEgkdmofOKt
        S0ILZOd/nhdlJAJiLU0/1pKP3s4OJqaoCAgQ/3nKpg3x53XGYpIy+OLxeuvu1b4yOs5wmQCquii3Z
        h6Qh8PLg==;
Received: from [5.161.104.131] (port=53397 helo=Hadi.local)
        by server65.mylittledatacenter.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <hadi@hadisafari.ir>)
        id 1fq1tC-006Vyv-0a
        for git@vger.kernel.org; Thu, 16 Aug 2018 00:25:30 +0430
To:     git@vger.kernel.org
From:   Hadi Safari <hadi@hadisafari.ir>
Subject: "Changes not staged for commit" after cloning a repo on macOS
Message-ID: <6022fbe8-0e07-f561-5e66-eeb4bc92704d@hadisafari.ir>
Date:   Thu, 16 Aug 2018 00:25:24 +0430
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server65.mylittledatacenter.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - hadisafari.ir
X-Get-Message-Sender-Via: server65.mylittledatacenter.com: authenticated_id: hadi@hadisafari.ir
X-Authenticated-Sender: server65.mylittledatacenter.com: hadi@hadisafari.ir
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

I encountered a strange situation on OS X recently. I cloned a 
repository (https://github.com/kevinxucs/Sublime-Gitignore.git), went to 
folder, and saw "Changes not staged for commit" message for four 
specific files. It happened every time I repeated the procedure. I even 
was able to commit those to the repo.
At first I thought there's something wrong with repo, but I cloned it on 
Ubuntu 16.04 and everything was OK; no "Changes not staged for commit" 
message.

Does anyone have any idea?

Thank you.

Log:

```
$ git clone https://github.com/kevinxucs/Sublime-Gitignore.git
Cloning into 'Sublime-Gitignore'...
remote: Counting objects: 515, done.
remote: Total 515 (delta 0), reused 0 (delta 0), pack-reused 515
Receiving objects: 100% (515/515), 102.14 KiB | 48.00 KiB/s, done.
Resolving deltas: 100% (143/143), done.
$ cd Sublime-Gitignore/
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)

     modified:   boilerplates/Nanoc.gitignore
     modified:   boilerplates/OpenCart.gitignore
     modified:   boilerplates/SASS.gitignore
     modified:   boilerplates/WordPress.gitignore

no changes added to commit (use "git add" and/or "git commit -a")
```

The rest of the log is available at 
https://github.com/kevinxucs/Sublime-Gitignore/issues/6. (I don't want 
this email to become too long.)

-- 
Hadi Safari
http://hadisafari.ir/
