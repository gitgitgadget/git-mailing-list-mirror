From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sat, 20 Oct 2007 10:03:33 +0200
Message-ID: <4719B655.90204@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail .com>	 <Pine.LNX.4.64.0710130130380.25221@racer.site> <1192827476.4522.93.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 10:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij9JO-00084M-6o
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 10:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbXJTIDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 04:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXJTIDk
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 04:03:40 -0400
Received: from mail.op5.se ([193.201.96.20]:46708 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbXJTIDh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 04:03:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DC807173066C;
	Sat, 20 Oct 2007 10:03:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Lmrx-B8sWDm; Sat, 20 Oct 2007 10:03:35 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 7EF4F17305B9;
	Sat, 20 Oct 2007 10:03:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1192827476.4522.93.camel@cacharro.xalalinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61809>

Federico Mena Quintero wrote:
> 
> "Find out why people find git hard to learn and eliminate those barriers
> to entry" is what we do with usability tests e.g. in GNOME.

And what every major corporation who's serious about UI's do. Windows
works the way it does because that's how idiots expect it to work. Sad but
true. If our aim is world domination, we need not cater to the morons, but
we must make it easier for them to start learning on their own.

>  You ask
> people to use your software to accomplish well-defined tasks ("send a
> mail to foo@bar.com", "using the word processor, copy this fancy printed
> layout").  Then, you see how they *expect* your software to work, you
> see in which places it doesn't behave like that, and you fix it.  This
> produces very good results.  For Git in particular this could be things
> like, "Import this project from SVN, fix a bug, commit the patch", or
> "You are a maintainer, merge in these two branches from two
> contributors".
> 

I like it. So much so that I'll see if I can get a non-programmer at work
to do these tasks. Now... to assemble that task-list. Suggestions welcome.

> 
> It's hard to know where to begin :)  Do I need "git-cherry-pick" or
> "git-cherry"?  Why is the "apply a patch" command called "git-am"?  Why
> is it different from "git-apply"?  From "git-applypatch"?  Etc.
> 

I agree completely. It wouldn't be hard to make git-apply figure out if
it's being fed something that 'am' would normally want, and if it's being
fed it inside a git repo. If so, make it work just like 'am'.
git-applypatch was deprecated a long time ago and has already been removed.

Personally, I can't help but think that the numerous times I've heard "oh
gods, that's a lot of commands" should finally mean something. I've started
taking a look at which of them one can bundle together. If we can drop the
porcelainish commands down to ~30 or so, and hide the plumbing from git-<tab>
listings, the initial hurdle people have to jump would be significantly lower.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
