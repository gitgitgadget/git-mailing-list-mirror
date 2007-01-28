From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 13:06:00 -0800
Message-ID: <7vveiqdfpj.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
	<7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 22:06:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBHE1-0000so-Jz
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 22:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbXA1VGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 16:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbXA1VGF
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 16:06:05 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51358 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857AbXA1VGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 16:06:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128210601.CQLQ18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 16:06:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gl521W00g1kojtg0000000; Sun, 28 Jan 2007 16:05:03 -0500
In-Reply-To: <Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 28 Jan 2007 11:57:33 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38050>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 28 Jan 2007, Junio C Hamano wrote:
> ...
>> I was hoping to take a look at Shawn's git-gui and also perhaps
>> looking into adding blame --incremental support to gitk myself
>> when I have time, but unfortunately my day-job deadline is
>> spilling into this weekend.
>
> I think the nice thing about the new "git-blame --incremental" is that it 
> allows people who really don't know (or care) anything at all about git 
> internals to do the viewer. So you shouldn't need to care.
>
> So I don't think you should do it, we should encourage others (who may not 
> be comfy with writing hard-core C that touches subtle internal git issues) 
> to just do it.

Good points.

I won't, although I've added fixed-up version of Jeff's as an
example under contrib/ -- I hope Jeff does not mind.

> ...
> I think it would be nice if the *dirty* lines would actually get blamed to 
> a fake commit (SHA-1 "00000000..") that is the "current working tree. 
> ...
> No?

Yeah.  That sounds sensible.
