From: Nicolas Pitre <nico@cam.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:10:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810311756160.13034@xanadu.home>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
 <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
 <20081031213114.GA21799@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:12:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2E3-0002P0-Cp
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYJaWLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYJaWLB
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:11:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27158 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbYJaWLA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:11:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M00805IX4TZF1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 18:10:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081031213114.GA21799@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99659>

On Fri, 31 Oct 2008, Pierre Habouzit wrote:

> Git is currently mostly "GPLv2 or later". A BSDish license was
> mentioned, because it's the most permissive one and that nobody cared
> that much, though a LGPL/GPL-with-GCC-exception would probably fly.

I do care.  I think the BSD license is too permissive.  There are really 
nifty pieces of code in Git that I would be really sorry to see go 
proprietary.

> Many of the people needing a library for libgit are probably reading the
> list, I'll let them comment. The kind of license you propose would
> totally suite my needs, and I think, most of the one discussed at
> GitTogether'08 (except for the eclipse people disliking GPL'ed stuff,
> but anyways there was the issue of C code being non pure java anyways,
> so maybe Shawn can comment on that bit, I don't recall the exact
> specifics I must reckon).

Eclipse is Java and that issue is already solved with JGIT which doesn't 
reuse C code from git.

> OT: FWIW I prefer BSDish licenses (even the MIT actually) for libraries
> because I believe that computing is overall better if everyone can use
> the right tool for the task, and I don't want to prevent people from
> using good stuff (I hope I write good stuff ;P) because of the license.

Everybody can and does link against glibc on Linux which is LGPL.  So 
that doesn't affect "usage".

> And I don't care about people don't giving back to me, those are not the
> kind of people who would have given back if it was GPL'ed anyways.
> But I understand this is a completely personal view, and I'm not even
> trying to persuade you :)

Sure, and that's where we differ.  I let you use my code for free, as 
long as you give me back your improvements to it.  This way everybody 
stays honnest.  I think this is Linus' view as well which he often 
resume as "tit for tat".


Nicolas
