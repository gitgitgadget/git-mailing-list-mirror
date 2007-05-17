From: david@lang.hm
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 14:00:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705171358070.16479@asgard.lang.hm>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org>
 <alpine.LFD.0.99.0705162309310.24220@xanadu.home> <Pine.LNX.4.64.0705171143350.6410@racer.site>
 <alpine.LFD.0.99.0705170954200.24220@xanadu.home> <20070517200431.GA3079@efreet.light.src>
 <alpine.LFD.0.99.0705171618410.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 17 23:02:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hon6m-0001bG-1K
	for gcvg-git@gmane.org; Thu, 17 May 2007 23:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450AbXEQVB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 17:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756287AbXEQVBz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 17:01:55 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:46837
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbXEQVBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 17:01:54 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l4HL14SF003524;
	Thu, 17 May 2007 14:01:04 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.0.99.0705171618410.24220@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47558>

On Thu, 17 May 2007, Nicolas Pitre wrote:

> On Thu, 17 May 2007, Jan Hudec wrote:
>
>> On Thu, May 17, 2007 at 10:41:37 -0400, Nicolas Pitre wrote:
>>> On Thu, 17 May 2007, Johannes Schindelin wrote:
>>>> On Wed, 16 May 2007, Nicolas Pitre wrote:
>>> And if you have 1) the permission and 2) the CPU power to execute such a
>>> cgi on the server and obviously 3) the knowledge to set it up properly,
>>> then why aren't you running the Git daemon in the first place?  After
>>> all, they both boil down to running git-pack-objects and sending out the
>>> result.  I don't think such a solution really buys much.
>>
>> Yes, it does. I had 2 accounts where I could run CGI, but not separate
>> server, at university while I studied and now I can get the same on friend's
>> server. Neither of them would probably be ok for serving larger busy git
>> repository, but something smaller accessed by several people is OK. I think
>> this is quite common for university students.
>>
>> Of course your suggestion which moves the logic to client-side is a good one,
>> but even the cgi with logic on server side would help in some situations.
>
> You could simply wrap git-bundle within a cgi.  That is certainly easy
> enough.

isn't this (or something very similar) exactly what we want for a smalrt 
fetch via http?

after all, we're completely in control of the client software, and the 
useual reason for HTTP-only access is on the client side rather then the 
server side. so http access that wraps the git protocol in http would make 
life much cleaner for lots of people

there are a few cases where all you have is static web space, but I don't 
think it's worth trying to optimize that too much as you still have the 
safety issues to worry about

David Lang
