X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Grzegorz Kulewski <kangur@polcom.net>
Subject: starting completly new repository
Date: Sat, 25 Mar 2006 22:06:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603252148550.14361@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Sat, 25 Mar 2006 21:07:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at alpha
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1FNFya-00069k-Ii for gcvg-git@gmane.org; Sat, 25 Mar
 2006 22:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751351AbWCYVGu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Mar 2006
 16:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWCYVGt
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 16:06:49 -0500
Received: from alpha.polcom.net ([83.143.162.52]:57067 "EHLO
 alpha.polcom.net") by vger.kernel.org with ESMTP id S1751351AbWCYVGs (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 16:06:48 -0500
Received: from localhost (localhost [127.0.0.1]) by alpha.polcom.net
 (Postfix) with ESMTP id 533271D053 for <git@vger.kernel.org>; Sat, 25 Mar
 2006 22:06:46 +0100 (CET)
Received: from alpha.polcom.net ([127.0.0.1]) by localhost (alpha
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 02117-15 for
 <git@vger.kernel.org>; Sat, 25 Mar 2006 22:06:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by alpha.polcom.net
 (Postfix) with ESMTP id 2F89E1A8B3 for <git@vger.kernel.org>; Sat, 25 Mar
 2006 22:06:42 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

First sorry if it is anwsered somewhere in the docs, but I am just 
(slowly) learning how to use git and reading the documentation. Any 
pointers to some article or tutorial that anwsers my questions will be 
appreciated.

What I am trying to do is to construct several repositories for the 
following work order:

1. There is some remote repo that is the main repository (call it main). 
It lives in some server and geneerally only one or two persons can push 
into it. All others can only pull from it.

2. Everybody has his own repo derived from main and she/he can make 
patches and send it to everybody else. One person is responsible for 
taking the patches and pushing them into main.

I need this set up fast and want to know how to do it. What I tried is 
basically:

(on the server)
mkdir main
git-init-db
touch .git/git-daemon-export-ok

(on my computer)
git-clone git://host/main main

But it looks like I must first do some commit on the server? But I can not 
make empty commit just to have things started? Or maybe there is some 
other way...

Also I wonder if I can do push over git protocol or I must use real ssh 
account on the server? This is not clear from the docs... At least not for 
me. How should I set up my repo (on my computer) to be able to push 
commits into main repo?

Also what should I set up additionally? How can I easily set author name 
and email for each repo? What is the difference between author and 
commiter and how should I set this up here?

Is there any documentation about git config file? Can I set author name, 
email and preffered editor in it or must I use environment?

Is there some irc channel for asking dumb questions as above and having 
them anwsered fast or should I use this mailing list?


Thanks in advance,

Grzegorz Kulewski
