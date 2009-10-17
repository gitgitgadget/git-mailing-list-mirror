From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 23:28:45 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910172320060.9794@reaper.quantumfyre.co.uk>
References: <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk> <20091016143041.GA11821@atjola.homenet> <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk> <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0910161557500.20122@xanadu.home> <alpine.LNX.2.00.0910171606180.6644@reaper.quantumfyre.co.uk> <20091017170421.GA10490@atjola.homenet> <alpine.LNX.2.00.0910171829430.7906@reaper.quantumfyre.co.uk>
 <20091017174843.GA16251@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 18 00:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzHsK-0003q3-2k
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 00:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZJQWfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 18:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbZJQWfc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 18:35:32 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49782 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752440AbZJQWfb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 18:35:31 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B347D693E1
	for <git@vger.kernel.org>; Sat, 17 Oct 2009 23:35:35 +0100 (BST)
Received: (qmail 11693 invoked by uid 103); 17 Oct 2009 23:28:45 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9906. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.036229 secs); 17 Oct 2009 22:28:45 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Oct 2009 23:28:45 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20091017174843.GA16251@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130581>

On Sat, 17 Oct 2009, Bj?rn Steinbrink wrote:

> On 2009.10.17 18:35:38 +0100, Julian Phillips wrote:
>> On Sat, 17 Oct 2009, Bj?rn Steinbrink wrote:
>>> Do you have multiple (annotated) tags for the same commit?
>>
>> Potentially, yes.  Releasing isn't the only thing that requires
>> keeping track of things.  It's even possible that the person
>> creating the newer tag doesn't yet know that a release tag has been
>> applied if the person who applied it hasn't yet pushed it back.
>
> OK, I'd consider that namespace pollution, as things like
> "this-version-sucks" doesn't seem like it show go into public repos, but
> anyway. If your release tags fix into a certain "unique" format, you
> could use describe with --match, like:
> git describe --match 'v[0-9]*'

Well - that only helps if we only ever build the release tags.  Which 
isn't the case.  The other tags are there for similar purposes and also 
should go into the version string - but only when they were the tag 
checked out.

Is it really that unreasonable to want to know exactly what it was that 
was checked out?  It's one of the few things that I miss from Subversion.

-- 
Julian

  ---
printk(KERN_INFO MYNAM ": English readable SCSI-3 strings enabled :-)\n");
         linux-2.6.6/drivers/message/fusion/mptbase.c
