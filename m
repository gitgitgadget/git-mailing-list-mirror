X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:12:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 03:12:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455BBCE9.4050503@xs4all.nl>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31549>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkXfy-0000eW-2z for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031053AbWKPDM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031066AbWKPDMZ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:12:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3218 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031053AbWKPDMY (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:12:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAG3CKoZ023389
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 19:12:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAG3CJHZ009331; Wed, 15 Nov
 2006 19:12:20 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Han-Wen Nienhuys wrote:

> Linus Torvalds escreveu:
> >  - git itself has now done it that way for the last 18 months, and the
> > fact is, the people _complaining_ are a small subset of the people who
> > actually use git on a daily basis and don't complain.
> 
> 
> that's not a good argument; the set of git users is a small subset of those
> that looked at git, and dismissed it because they couldn't wrap their heads
> around it. 

And I've said this again, and I'll say it once more: that has basically 
_nothing_ to do with whether you spell "pull" as "pull" or "merge".

The reason people have trouble wrapping their heads around git is because 
they have been braindamaged by CVS and SVN, and just don't understand the 
fairly fundamental new concepts and workflow.

That's totally different from then arguing about stupid naming issues.

Peopel seem to believe that changign a few names or doing other totally 
_minimal_ UI changes would somehow magically make things understandable. I 
claim that isn't so at all. The fact is, git is different from CVS and 
SVN, and git _has_ to be different from CVS and SVN. It has to be 
different because the whole model of CVS and SVN is simpyl fundamentally 
BROKEN.

> It's worth trying to get those on board by fixing the annoying
> little issues that have popped up in this thread.

I claim that those "annoying little issues" are totally made up by people 
who had trouble wrapping their minds about git, and then make up reasons 
that have nothing to do with reality for why that might be so.

Let's face it, you could just alias "merge" to "pull", and it wouldn't 
really change ANYTHING. You'd still have to learn the new model. 

