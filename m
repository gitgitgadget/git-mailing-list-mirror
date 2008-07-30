From: Kevin Ballard <kevin@sb.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 20:20:45 -0700
Message-ID: <6E45FC6B-B5ED-4A7D-8EBA-66CE0347FFB0@sb.org>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net> <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 05:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO2IK-00021Z-FT
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 05:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbYG3DUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 23:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYG3DUs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 23:20:48 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:34714 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751577AbYG3DUs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 23:20:48 -0400
Received: from [192.168.1.101] (c-76-103-51-229.hsd1.ca.comcast.net [76.103.51.229])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 496EE15D401;
	Tue, 29 Jul 2008 20:20:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90729>

On Jul 29, 2008, at 7:48 PM, Roman Zippel wrote:

> For printk.c look for commit  
> 02630a12c7f72fa294981c8d86e38038781c25b7 and
> try to find it in the graphical outputs.
> Here is a bit better example than Linus gave:
>
> [snip]
>
> Now compare the output of "git-log file1", "git-log --full-history  
> file1"
> and "git-log --full-history --parents file1". You get either both  
> merge
> commits or none, but only one of it is relevant to file1.
>
> The problem is that in practice "git-log --full-history --parents"
> produces way too much information to be useful right away.

Output looks correct to me. And of course --full-history --parents  
gives lots of output - that's what it's for. You seem to believe that  
the appropriate output is, what, to display the initial commit, both  
commits that modified file1, and the first merge, yes? Can you please  
clarify the logic that states that the first merge commit should be  
shown but the second should not?

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
