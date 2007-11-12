From: Andreas Ericsson <ae@op5.se>
Subject: Re: Deprecate git-fetch-pack?
Date: Mon, 12 Nov 2007 11:15:49 +0100
Message-ID: <473827D5.2070908@op5.se>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> <7v4pftip42.fsf@gitster.siamese.dyndns.org> <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com> <Pine.LNX.4.64.0711111103240.4362@racer.site> <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org> <20071111222117.GA7392@thunk.org> <7vabpkbebj.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711112247350.4362@racer.site> <20071111235819.GB7392@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:16:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWKz-0000La-0G
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396AbXKLKQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758405AbXKLKQA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:16:00 -0500
Received: from mail.op5.se ([193.201.96.20]:36203 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758365AbXKLKPy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:15:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A581E1F08755;
	Mon, 12 Nov 2007 11:15:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QmOCO8jRKf2G; Mon, 12 Nov 2007 11:15:51 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7BCD91F08754;
	Mon, 12 Nov 2007 11:15:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071111235819.GB7392@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64592>

Theodore Tso wrote:
> On Sun, Nov 11, 2007 at 10:50:26PM +0000, Johannes Schindelin wrote:
>> I beg to differ.  The biggest problem with a new user seeing all those 
>> completions is that this user is scared.
> 
> Well, if we introduce the new user only to "git subcomand", and the
> documentation is relatively gentle, I would suspect would solve most
> of the problem.  Note BTW, that if your thesis is true, "git help -a"
> (which is recommended in the last line of output by "git help") should
> cause the typical new user to faint dead away.  :-)
> 
> Some other areas that would be worth fixing, in terms of user usability.
> 
> 1) The references to the tutorial, everyday git, etc., don't actually
> have working references in the git man page.  (i.e., what you see when
> you run the command "man git").   It would be nice if that were fixed.
> 
> 2) The command which are displayed by "git help" should use some
> serious rethinking.  Ideally, it would be nice if the output fit in a
> single 24-line terminal window.   Some candidates for removal:
> 
>        a) prune: "git prune" definitely doesn't deserve to be on the
>        front and center as displayed by "git help".  Maybe replace it
>        with "gc", but now that we have gc.auto, I'm not sure it's
>        worth it at all.
> 

prune is definitely scary, and users don't need to know about it until
they've worked with git for quite some time.

>        b) revert:  Is that really that common of a command?
> 

I think I've used it once ;-)

>        c) show-branch: The output is terrifying without explanation
> 

Indeed. I still don't grok it fully. I tend to use gitk/qgit and some
brainpower to obtain the same result.


> There are other commands I'm not so sure about, but it is worth
> flagging them.  One way that might be helpful is to group the commands
> into subcommands, much like gdb does, so you could do something like
> "git help other-repos" (where all commands that involve interacting
> with other repositories are summarized), and so on.
> 

Ack on that. I suggested it a while back and it appears many liked the
idea. I'm really bad at writing docs though, so it's one of those things
I've been putting off for "some other day".


>> But yes, I was only proposing to deprecate all usage of git-<bla> in the 
>> documentation.
> 
> I agree that de-emphasizing git-<blah> isn't a bad thing.  But I think
> we need to look at the big picture here, since "git help" is often one
> of the first things a new user might try (and obviously very few git
> developers look at it, or "prune" probably would have been removed
> from git help a long time ago :-), and the last thing that git help
> suggests (and so therefore it will very visible to the newbie user),
> is "git help -a" --- and that displays every single git command under
> creation, porcelain or plumbing, in one gigantic sorted list.  
> 
> Oops, so much for first impressions.  :-)
> 

I agree. Culling the list output by "git help -a" to only show the
porcelain commands would definitely be worthwhile. I'm not sure if it's
worth having a way of showing every installed git command at all (I
know I've never used it anyway).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
