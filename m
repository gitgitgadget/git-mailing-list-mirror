From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-send-pack segfaulting on DebianPPC
Date: Thu, 20 Oct 2005 02:11:10 +0200
Message-ID: <20051020001110.GS30889@pasky.or.cz>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com> <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org> <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com> <20051019223743.GQ30889@pasky.or.cz> <46a038f90510191623k4f1a7267m50d3bbbd6665a2a3@mail.gmail.com> <20051019235208.GR30889@pasky.or.cz> <7v8xwpxdef.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 02:11:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESO1c-0004Jk-NB
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 02:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbVJTALN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbVJTALN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 20:11:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16056 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751655AbVJTALM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 20:11:12 -0400
Received: (qmail 18429 invoked by uid 2001); 20 Oct 2005 02:11:10 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xwpxdef.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10327>

Dear diary, on Thu, Oct 20, 2005 at 02:03:52AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Hmm, what bash version are you using? It's enclosed in
> >
> > 	for tag in *
> >
> > and perhaps your bash misunderstood.
> 
> It probably is your cat not quoting $tag, which you just fixed.
> Martin's repo has a conversion from CVS, with bunch of tags
> whose names are like "Foo **INVALID**" (that's whitespace and
> asterisks).

Eww. Well, I pushed out the fix.

BTW (for anyone reading this), in the near future, I would like to do a
complete quoting review of Cogito, since while I'm trying to be careful
now, it wasn't always so, especially early on. Of course, *I* would also
like to do many other things... *hint* *hint* ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
