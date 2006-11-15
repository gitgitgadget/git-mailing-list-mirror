X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 12:09:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org>  <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
  <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>  <200611151858.51833.andyparkins@gmail.com>
  <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 20:09:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31479>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkR4Q-00045F-2J for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030661AbWKOUJO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030754AbWKOUJO
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:09:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14550 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030661AbWKOUJN (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:09:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFK9BoZ025121
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 12:09:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFK9AsM027852; Wed, 15 Nov
 2006 12:09:10 -0800
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Michael K. Edwards wrote:
> > 
> > But I bet people don't teach it that way. They _start_ by teaching "pull".
> > Right?
> 
> "git fetch" is certainly the right thing for the platform integration
> role

I'm saying that even if you _never_ end up using "git fetch" ever again 
(because in practice you always want to do a "fetch + merge == pull"), 
people who teach others the concepts and usage of git should probably 
start by talking about "git fetch".

Then, when the user says (and he obviously will say this) "but I don't 
want to just fetch the other persons work into some local branch, I want 
to actually get it into _my_ branch", you say "Ahhah!" and talk about how 
"pull" is a shorthand for first fetching and then merging the result into 
the current branch.

See? Once you explain "fetch" to somebody, I can pretty much guarantee 
that they'll explain "pull" to themselves without you having to even work 
at it. And then they'll probably happily use "pull" ever after, and never 
worry about fetch, but now they'll understand the _concepts_.

It's only if you start the other way around that "pull" vs "fetch" vs 
"push" become confusing. If you _start_ by explaining branches (and you 
might use "gitk --all" on a small project as a visualization tool), 
suddenly the concepts aren't all that complicated.

Sure, then you have to remember two words ("pull" vs "fetch"), but I'm 
pretty sure that the thing that makes people confused is not the words 
themselves, but their lack of understanding of the concepts behind them.

