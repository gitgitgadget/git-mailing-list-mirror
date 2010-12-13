From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: developing a modified Linux-style workflow
Date: Mon, 13 Dec 2010 10:15:16 -0600
Message-ID: <ie5grt$au2$1@dough.gmane.org>
References: <7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 17:16:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSB4T-0002WE-7d
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 17:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835Ab0LMQQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 11:16:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:56566 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757576Ab0LMQQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 11:16:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSB4K-0002Sy-T9
	for git@vger.kernel.org; Mon, 13 Dec 2010 17:16:08 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 17:16:08 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 17:16:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Response
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163561>

"Hans-Christoph Steiner" <hans@at.or.at> wrote in message 
news:7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at...
>
> Hey all,
>
> (and my second post on this list...)
>
> I've gotten pretty good at git, and its helping me already with  managing 
> the very odd workflows I have with the software I work a lot  on called Pd 
> (http://puredata.info).  My role in Pd development is  like a Linux 
> lieutenant.
>
> I also the main dev for an app called Pd-extended, which is based on  Pd. 
> Now I'm stuck trying to figure out how to use git to match my  current 
> workflow for Pd-extended, which is a kind of long-lived  branch, almost 
> like a friendly fork.  So its kind of close to the  Linux workflow with me 
> as a lieutenant, but not quite.
>
> What makes it tricky is that I make releases directly from my repo  that 
> are widely used.  So my repo is both lieutenant and dictator at  the same 
> time.  So that's where I am stumped.  I want to be able to  rebase and 
> push to a public repo, but that would be stupid.  So there  has got to be 
> another way.
>
> .hc
>
I don't think pushing to a public repo is stupid.  You could create a bare 
repo with a Pd branch and Pd-extended branch that contain the production 
versions of Pd and Pd-extended.  The main reason our shop chose git is 
because it allows us to easily have multiple concurrent versions of 
production by having a branch for each of our custom versions.  These 
versions eventually get merged together into a major release, but in the 
meantime they are longlived branches representing the productional 
customized system for each major customer.

*If* you end up merging Pd and Pd-extended at some point, then you could 
have another branch for that, e.g. master or Pd-master or whatever.  BTW, 
you do not have to use master as the representative of your final merged 
work so don't think that is the way you HAVE to do it.  It's just the 
default, and a common practice for systems with a single version of 
production.  Master can become vestigial or secondary, if you choose to 
create a new branch called Pd-master, etc. to represent your eventual merges 
of Pd and Pd-extended.


v/r,
Neal 
