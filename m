From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-merge-recursive: documentation and implementation notes
Date: Sat, 12 Nov 2005 22:03:06 +0100
Message-ID: <20051112210306.GG30496@pasky.or.cz>
References: <20051112203457.GA5234@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 22:03:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb2Wo-0001ei-2b
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 22:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVKLVDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 16:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVKLVDK
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 16:03:10 -0500
Received: from w241.dkm.cz ([62.24.88.241]:24803 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964801AbVKLVDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 16:03:09 -0500
Received: (qmail 15189 invoked by uid 2001); 12 Nov 2005 22:03:06 +0100
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20051112203457.GA5234@c165.ib.student.liu.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11707>

  Hi,

Dear diary, on Sat, Nov 12, 2005 at 09:34:57PM CET, I got a letter
where Fredrik Kuivinen <freku045@student.liu.se> said that...
> Lets assume there is a merge conflict when we merge B and C in the
> criss-cross case above. Then both D and E must resolve this
> conflict. If they have done it in the same way we wont get a merge
> conflict at M, if they have resolved it differently we will get a
> merge conflict. In the first case there is no merge conflict at M, in
> the second case the user has to pick which one of the two different
> resolutions she wants.
> 
> Note that the algorithm will happily write non-clean merge results to
> the object database during the "merge common ancestors" stage. Hence,
> when we are merging B and C "internally" we will _not_ ask the user to
> resolve any eventual merge conflicts.

  I find this part somewhat unclear. So how does the user pick which of
the two different resolution she wants if we will not ask the user to
resolve any conflicts?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
