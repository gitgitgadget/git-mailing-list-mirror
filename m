From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Thu, 27 Jul 2006 21:48:49 -0700
Message-ID: <7vr706mj0u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<200607262039.25155.Josef.Weidendorfer@gmx.de>
	<20060728013038.GH13776@pasky.or.cz>
	<7vvepimoxr.fsf@assigned-by-dhcp.cox.net>
	<20060728025619.GK13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 06:49:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6KHR-0008O9-5u
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 06:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWG1Esx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 00:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWG1Esx
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 00:48:53 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41439 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750841AbWG1Esv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 00:48:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728044850.LHDO6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 00:48:50 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060728025619.GK13776@pasky.or.cz> (Petr Baudis's message of
	"Fri, 28 Jul 2006 04:56:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24364>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Jul 28, 2006 at 04:41:04AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Petr Baudis <pasky@suse.cz> writes:
>> >   (iv) I need git-apply to add/remove to/from index new/gone files,
>> > while at the same time...
>> >
>> >   (v) I want to allow applying of patches to working copy that is not
>> > completely clean, even on top of modified files
>> 
>> You probably should be able to talk me into doing these, but
>> doesn't it already do (iv) and (v)?
>
> Well, at once? I can do (iv) by adding --index but that contradicts (v).
> But maybe I'm missing something.

What should the semantics of such operation be?  Apply to index
on paths that are clean while leave the index entries untouched
for paths that are dirty?  What should happen on renamed paths
that are dirty?
