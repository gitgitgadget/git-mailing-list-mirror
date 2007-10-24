From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Wed, 24 Oct 2007 17:20:25 -0400
Message-ID: <20071024212025.GM29830@fieldses.org>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 24 23:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikney-0006rz-Mv
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 23:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbXJXVUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 17:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbXJXVUc
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 17:20:32 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33026 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754019AbXJXVUa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 17:20:30 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IkneM-00048W-0R; Wed, 24 Oct 2007 17:20:26 -0400
Content-Disposition: inline
In-Reply-To: <471FB3D0.4040800@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62242>

On Wed, Oct 24, 2007 at 11:06:24PM +0200, Andreas Ericsson wrote:
> J. Bruce Fields wrote:
>> On Wed, Oct 24, 2007 at 10:12:29PM +0200, Steffen Prohaska wrote:
>>> On Oct 24, 2007, at 9:48 PM, J. Bruce Fields wrote:
>>>
>>>>> I want git pull to work like git push.
>>>> That strikes me as a less complete solution, since it only helps in the
>>>> case where the other branches all happen to be unmodified locally (hence
>>>> can be fast-forwarded).  In other cases the "git push" will still emit a
>>>> spurious error.
>>> Well, but then there's something you should really think
>>> about.
>> Perhaps, but not necessarily; you may have some branches with local
>> changes that you're content to leave unpushed (and un-updated).
>
> Sure, but that won't change. The only thing I'm proposing is that
> local copies of remote branches are automatically fast-forwarded
> on every pull, but only if
>
> * the branch has no modifications what so ever
> * the branch is set up to auto-merge with the particular branch
> fetched from the particular remote
>
> I really don't see any downsides what so ever with this. Those
> of you who do, please enlighten me.

The downsides are that it makes the behavior of pull slightly more
complicated, and that it changes long-established default behavior of a
major subcommand.  (Those aren't huge disadvantages, but they are
disadvantages.)

>
>> 	- the user has one or more unmodified copies of remote branches
>> 	  lying around, and
>
> Extremely common case for a large group of users.

OK, but that was one part of a four-"and" clause.  I don't see any
absolute clincher here, but on balance I think the disadvantages win
out.

--b.
