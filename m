X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: egit/jgit wishlist
Date: Mon, 4 Dec 2006 22:47:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612042235270.14187@alpha.polcom.net>
References: <20061204172836.GB6011@spearce.org> <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net>
 <20061204182902.GG6011@spearce.org> <457490EE.30606@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Mon, 4 Dec 2006 21:48:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457490EE.30606@midwinter.com>
X-Virus-Scanned: amavisd-new at alpha
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33257>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLfV-00046y-US for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967391AbWLDVsH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967399AbWLDVsG
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:48:06 -0500
Received: from alpha.polcom.net ([83.143.162.52]:58906 "EHLO
 alpha.polcom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S967391AbWLDVsE (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 16:48:04 -0500
Received: from localhost (localhost [127.0.0.1]) by alpha.polcom.net
 (Postfix) with ESMTP id BFB243AF7; Mon,  4 Dec 2006 22:47:59 +0100 (CET)
Received: from alpha.polcom.net ([127.0.0.1]) by localhost (alpha
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 09561-05; Mon,  4 Dec
 2006 22:47:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by alpha.polcom.net
 (Postfix) with ESMTP id A667DA1F; Mon,  4 Dec 2006 22:47:55 +0100 (CET)
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

On Mon, 4 Dec 2006, Steven Grimm wrote:
> Shawn Pearce wrote:
>>  I personally want to avoid calling external programs
>>  as much as possible here, and that means staying with a 100% pure
>>  Java implementation. 
>
> I think that's exactly the right decision.
>
> One big advantage of doing it this way is that it will be reasonably 
> cross-platform from the start. As soon as you start running external 
> programs, you introduce all the system dependencies of the Git command-line 
> tools, especially acute if you're running some of the non-C porcelain 
> commands (which will then require a working shell or Perl environment to be 
> installed.)
>
> With a wrapper-based implementation, the temptation would probably be pretty 
> great to just leave some stuff implemented as wrappers and not bother porting 
> them, which would potentially kill portability. Insisting on 100% pure Java 
> means that particular temptation is never an issue.

But it will be working (== end user usable) after many months not days.

And please note that Java is not that portable as many people are 
suggesting. Maybe it will change but currently I will bet C + bash + 
perl (+ python?) is more portable than Java. Java (J2SE) is officially 
supported mainly under Windows, Solaris, Linux and maybe Mac. There are 
more ports but unfortunatelly way too many of them are old, buggy, have 
not full library implementations or something like that. Eclipse also 
currently works only under Windows, Linux and Mac.

Can you name one system where Java (J2SE 1.4 or better 1.5) works (fully, 
not sometimes) and where GIT does not work? Does Eclipse work there too 
(or will in say next year)?

Don't get me wrong: I like Java, use it a lot and wish everything best for 
it but it is not the only or main anwser to every problem on this planet. 
:-) Good wrappers are often better at the begining than trying to do 
everything at once from scratch. And they are certainly faster to develop.


Thanks,

Grzegorz Kulewski
