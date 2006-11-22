X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: A documentation to-do list
Date: Wed, 22 Nov 2006 22:31:24 +0200
Message-ID: <4564B39C.2020903@cc.jyu.fi>
References: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com> <Pine.LNX.4.63.0611221044180.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 20:31:35 +0000 (UTC)
Cc: Chris Riddoch <riddochc@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
In-Reply-To: <Pine.LNX.4.63.0611221044180.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32100>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmykg-0003hD-Gs for gcvg-git@gmane.org; Wed, 22 Nov
 2006 21:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757000AbWKVUbX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 15:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757001AbWKVUbX
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 15:31:23 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:17357 "EHLO posti5.jyu.fi") by
 vger.kernel.org with ESMTP id S1756995AbWKVUbW (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 15:31:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by posti5.jyu.fi
 (8.13.6/8.13.6) with ESMTP id kAMKVKKp028033; Wed, 22 Nov 2006 22:31:20 +0200
Received: from posti5.jyu.fi ([127.0.0.1]) by localhost (posti5.jyu.fi
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id H65cxwh4u+jj; Wed, 22
 Nov 2006 22:31:19 +0200 (EET)
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi
 [130.234.182.120]) by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id
 kAMKVI1p028028; Wed, 22 Nov 2006 22:31:19 +0200
Received: from [127.0.0.1] (aragorn2.kortex.jyu.fi [127.0.0.1]) by
 aragorn.kortex.jyu.fi (Postfix) with ESMTP id 9809A4680A2; Wed, 22 Nov 2006
 22:31:24 +0200 (EET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
>
> On Tue, 21 Nov 2006, Chris Riddoch wrote:
>
>   
>> Having decided to take it on myself to improve Git's documentation, I
>> asked on #git if people had particular things they felt I should focus
>> on.
>>     
>
> I have a request, which is not about _what_ to document, but _how_. People 
> often complained about the bad introduction into git, pointing to 
> http://www.selenic.com/mercurial/wiki/index.cgi/QuickStart for a "way 
> better" tutorial.
>   
I agree with this. In addition at least I have always missed official
"home page" as even currently the kernel.org points for example just to

       http://www.kernel.org/pub/software/scm/git/
      
Ok, by clicking the "docs" subfolder one gets to man pages. But man
pages does not specify the basic things like, where is the official git
repository
and how to pull the latest official or development versions from there.
In addition man pages are not the fastest way to get started.
Instead small tutorial for example with a following kind of usage
scenario might be quite useful for many. (I do not know even myself to
step 10 :-)

1) One clones architehture specific git repository
    (for example git-clone
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git)
2) This repository has omap specific things in master branch which is
often synced with main kernel
3) Once omap specific things are working agains the release kernel
(let's say 2.6.16), master is tagged with keys like
       "linux-omap-2.6.16-omap1"
4) User creates "MY_DEV" branch and adds own changes to there
5) User tags the branch with "MY_OMAP1_2_6_16" and releases own
2.6.16-omap1 based kernel
6) Master branch in OMAP is synced with the main kernel which is now
somewhere like 2.6.18-rc5
7) User changes to master branch, pulls the master branch to 2.6.18-rc5
level
8) User switches to MY_DEV branch has pulls it it 2.6.18-rc5 level from
master branch. Fix merge errors and commits them there.
9) Stable team releases bug fix version 2.6.16.25 to own git
10) User wants to release MY_OMAP1_2_6_16_25 version and would like to
use git-pull instead of using patch files
       - How to jump back to tagged version in repository?
       - How to pull the stable team changes here?

Other common issues that comes to my mind are but which are not easy to
find out from the current official
man based documentation:

1) where is the repository and gitweb for git itself. (only man pages
are easy to find out currently from net).
2) how to checkout the latest from there (even announcement emails does
not mention this currently!)
3) how to pull the git repository to newer version when Junio announces
new tar-balls
4) how to change to older tagged version (or to some older non tagged
commit version) and build from there
5) how to create own work branch, commit changes to there and
       a) use git-format-patches to create patch files
       b) automatize the patch sending via emails
       c) use push for sending changes back to master repository
6) what is the difference between origin and master. Can user push
changes to origin or should they always be pushed to master or own branch
7) how to create own repository
8) how to set-up gitweb to show your own git repository
9) how to allow others to pull over http connection from your repository
(this was for example easy, but it is hard to find any documentation
from this)
10) how to allow others to pull over git connection from your repository
(requires git-daemon + touch command with magic keyword)

