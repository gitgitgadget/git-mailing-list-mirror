From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 20:48:20 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet> <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk> <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 21:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mysr5-0001KM-9M
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 21:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbZJPTwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 15:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbZJPTwl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 15:52:41 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44284 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751464AbZJPTwk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 15:52:40 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4BC9A358B0C
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 20:52:43 +0100 (BST)
Received: (qmail 5365 invoked by uid 103); 16 Oct 2009 20:48:21 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9902. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026192 secs); 16 Oct 2009 19:48:21 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Oct 2009 20:48:20 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130523>

On Fri, 16 Oct 2009, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>>> And such uncommitted changes would be lost in the big "undo the fetch
>>> update" diff. So you'd have to do:
>>> git reset --soft HEAD@{1}
>>> git checkout --merge HEAD@{1}
>>>
>>> to keep them, while updating to the new state of the remote tracking
>>> branch. Not quite intuitive, is it?
>>
>> I don't care what git has to do, I'm talking about the user experience
>
> But Bj?rn is showing two commands the _user_ has to type, iow, the comment
> is about the user experience.

Only Currently.  My point was that _if_ we wanted to support this sort of 
thing, then we can make is simpler to do by providing a simple command for 
the user.

The point I wanted to make was that the decision on what to do should be 
driven by the user's experience - not by the fact that it is easier to 
implement something else.

My interest in this thread is solely that it might provide a mechanism to 
find out which tag was checked out.  So, I'm just chucking in my $0.02 as 
a user.  My suggestions are probably complete rubbish, as I haven't really 
had time to think them through... Sorry.

-- 
Julian

  ---

Look, just gimme some inner peace, or I'll mop the floor with ya!

 		-- Homer Simpson
 		   El Viaje Misterioso de Nuestro Homer
