From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Wed, 24 Oct 2007 16:33:35 -0400
Message-ID: <20071024203335.GJ29830@fieldses.org>
References: <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 22:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkmvO-0005fK-Ed
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbXJXUdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbXJXUdp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:33:45 -0400
Received: from mail.fieldses.org ([66.93.2.214]:46083 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbXJXUdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:33:44 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ikmv1-0002YU-Af; Wed, 24 Oct 2007 16:33:35 -0400
Content-Disposition: inline
In-Reply-To: <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62236>

On Wed, Oct 24, 2007 at 10:12:29PM +0200, Steffen Prohaska wrote:
> On Oct 24, 2007, at 9:48 PM, J. Bruce Fields wrote:
>
>>
>>> I want git pull to work like git push.
>>
>> That strikes me as a less complete solution, since it only helps in the
>> case where the other branches all happen to be unmodified locally (hence
>> can be fast-forwarded).  In other cases the "git push" will still emit a
>> spurious error.
>
> Well, but then there's something you should really think
> about.

Perhaps, but not necessarily; you may have some branches with local
changes that you're content to leave unpushed (and un-updated).

So the case where this proposal helps is the case where:
	- the user hasn't learned how to name individual branches on the
	  push commandline, or has learned to do so, but wants less
	  typing, and
	- the user has one or more unmodified copies of remote branches
	  lying around, and
	- the user minds being reminded that those copies are out of
	  date, and
	- the user either has no *modified* copies of local branches, or
	  has some but doesn't mind being reminded that they're out of
	  date on each push.

--b.
