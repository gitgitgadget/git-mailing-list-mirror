From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 19:29:54 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311903320.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
 <20110131231210.GD14419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 01:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk488-0003Sa-9v
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 01:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab1BAA3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 19:29:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31786 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1BAA3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 19:29:55 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW00HL2XD74I20@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 19:29:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110131231210.GD14419@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165780>

On Mon, 31 Jan 2011, Jeff King wrote:

> On Mon, Jan 31, 2011 at 04:28:49PM -0500, Nicolas Pitre wrote:
> 
> > So... we do suck at something?  So why not take this opportunity to 
> > shake yourself out of this easy comfort and improve Git as a result on 
> > both front?  :-)
> 
> Yes, we do suck at rename following. The problem is that it is partially
> an implementation issue, and partially a fundamental issue. Obviously
> --follow sucks pretty hard right now, and that could be fixed. Namely it
> follows only a single file, and it interacts very badly with history
> simplification.

This is no excuse not to do proper source tree reorganization.

Telling people not to move files around because Git sucks at tracking 
them is also the wrong answer.

> But even with those things fixed, there will still be annoyances.
> 
> It will still be _slower_ to turn it on all the time, for one[1]. And
> that's due to fundamental design decisions of the git data structure.
> And I'm not knocking those decisions; I think they made the right
> tradeoff. But that doesn't mean we don't pay the cost for that tradeoff.

I agree.  However sitting on our back and resisting a cleanup just 
because our very tool does poorly in that scenario is just like putting 
our heads in the sand and pretend that the problem doesn't exist.  
Better do what most people without internal knowledge of Git would do 
and just clean up the tree, and then benefit from this extraordinary 
opportunity of having this environment right at home where Git 
developers have a much greater incentive to work on this issue and 
improve things.

> And no matter what your model, renames can be annoying. On-going topics
> will have a painful rebase or merge. And people looking at history will
> have to deal with the code-base having different names at different
> points. Yeah, you can say it's all just "content", but the filenames we
> put things in are actually useful.

Of course.  But such is life.  Many projects out there are just like 
that, and facing this situation ourselves will just help us figure out 
ways to make Git even more useful to more people.

> So I don't think it's wrong to say "renames are a pain, and so should
> not be done lightly".

I disagree.  This is like saying: "renames are not well supported, so 
let's avoid them while using Git."  People used to say that of merges 
with CVS.  Are we going to follow suit de facto?  Imagine the Git 
detractors taking our source tree mess to exemplify this Git flaw since 
"Git developers themselves are unwilling to move files around because 
Git sucks at it".

> I do think it's wrong to say "renames can't be
> done"; I just the cost needs to be considered.

Instead, why not saying: "Rename tracking is not as optimal as it could 
be, so let's work it out." ?


Nicolas
