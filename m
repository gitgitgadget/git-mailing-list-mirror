From: Andreas Ericsson <ae@op5.se>
Subject: Re: Considering teaching plumbing to users harmful
Date: Fri, 18 Jul 2008 10:19:19 +0200
Message-ID: <48805207.80504@op5.se>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 10:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlDI-0008Su-BN
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 10:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYGRIUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 04:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYGRIUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 04:20:16 -0400
Received: from mail.op5.se ([193.201.96.20]:53272 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbYGRIUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 04:20:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D790824B0040;
	Fri, 18 Jul 2008 10:20:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J4cNHuhlQc-z; Fri, 18 Jul 2008 10:20:32 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.199])
	by mail.op5.se (Postfix) with ESMTP id 59DC124B003C;
	Fri, 18 Jul 2008 10:20:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89008>

Johannes Schindelin wrote:
> Hi,
> 
> there have been a number of occasions where I came across people trying to 
> be helpful and teaching Git newbies a few tricks.
> 
> However, in quite a number of cases, which seem to surge over the last 
> weeks, I see people suggesting the use of rev-parse, ls-tree, rev-list 
> etc.
> 
> Their rationale is invariably "but I found it useful", and they seem to be 
> unable to recognize the puzzlement in the faces of the people they are 
> trying to help.
> 
> Instead they insist that they did nothing wrong.
> 
> I had the pleasure of introducing Git to a few users in the last months 
> and in my opinion, restricting myself to teaching them these commands 
> first helped tremendously:
> 
> - clone, pull, status, add, commit, push, log
> 
> All of these were presented without options, to keep things simple.
> 
> In particular, I refrained from giving them the "-a" option to commit.  
> That seemed to help incredibly with their embracing the index as a natural 
> concept (which it is).
> 
> Often I presented the "pull" and "push" commands _only_ with "origin 
> master" ("origin is where the repository came from, and master is the 
> branch; you will want to use other parameters here after you used Git for 
> a while").
> 
> _After_ they grew comfortable with Git, I taught them a few options here 
> and there, not hiding, but also not promoting the full range of options.
> 
> So the next tricks were
> 
> - log -p, rm, diff, diff --cached, show
> 
> The last one is "show", and with that command, I taught the 
> "<commit>:" and "<commit>:<file>" syntax, too (which some Git old-timers 
> did not know about ;-)
> 

Thanks for the excellent write-up. I wish I'd had this when I did the
introductory courses at my dayjob. With those simple commands, 90%
of the users get access to 90% of the usefulness of git, imo. And,
more importantly, it's enough to get them started right away.


> The pace needed to be adjusted to the users, in my experience, but not the 
> order.
> 
> Now, it makes me really, really sad that Git has a reputation of being 
> complicated, but I regularly hear from _my_ users that they do not 
> understand how that came about.
> 
> Am I the only one who deems teaching plumbing to users ("I like it raw!  
> So I teach it the same way!") harmful?
> 

I wholeheartedly agree. Telling people about "git rev-list" on day one
is probably the single greatest mistake I've ever done wrt git. To the
non-gitizen, it takes some mumbo-jumbo arguments and spits out a long
list of mumbo-jumbo output. Had I started with "git log" instead, it
would have been infinitely easier to explain how each commit has a
totally unique name.

In addition, I'd recommend setting
color.branch=auto
color.diff=auto
color.pager=true
color.status=true
before starting the "course". It makes the learning experience a whole
lot nicer.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
