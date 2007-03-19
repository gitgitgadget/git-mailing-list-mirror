From: Nicolas Pitre <nico@cam.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 14:35:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 19:35:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTMhI-0002DA-Ox
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 19:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbXCSSfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 14:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbXCSSfG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 14:35:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9392 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030519AbXCSSfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 14:35:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF500K5BYAF7290@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 14:35:04 -0400 (EDT)
In-reply-to: <45FED31B.8070307@midwinter.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42651>

On Mon, 19 Mar 2007, Steven Grimm wrote:

> So to answer your question, in my opinion if 100% guaranteed renames are high
> on your priority list, then Mercurial might be the better option for now. In
> practice, I've found that git's 99+% rename detection has yet to fail on me
> aside from the above directory renaming case, but at the end of the day it
> *is* guessing at your renames after the fact.
> 
> Okay, git gurus, show me no mercy. :)

Well...  the fact that you _still_ use GIT even in the face of a 1% 
probability that it might guess renames wrong (according to your own 
numbers) should mean that you didn't felt switching to Mercurial was 
worth the 100% guarantee for rename identification.

And some will argue that explicit renames are susceptible to user error 
misidentifying the rename too, certainly in the 1% figure of all renames 
if not more.

So maybe, just maybe, at the end of the day getting renames right 100% 
of the time instead of 99% is not such a big thing after all.


Nicolas
