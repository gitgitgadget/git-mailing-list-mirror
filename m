From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 18:40:45 +0200
Message-ID: <20060505164045.GA27689@pasky.or.cz>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505062236.GA4544@c165.ib.student.liu.se> <20060505092332.GY27689@pasky.or.cz> <7vejz8241m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 18:39:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc3L8-0008Ht-9u
	for gcvg-git@gmane.org; Fri, 05 May 2006 18:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWEEQjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 12:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWEEQjf
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 12:39:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8888 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751628AbWEEQje (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 12:39:34 -0400
Received: (qmail 30494 invoked by uid 2001); 5 May 2006 18:40:45 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejz8241m.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19617>

Dear diary, on Fri, May 05, 2006 at 11:51:01AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > But the non-obviously important part here to note is that the branch B
> > merely "corrects a typo on a comment somewhere" - the latest versions in
> > branch A and branch B are always compared for renames, therefore if
> > branch A renamed the file and branch B sums up to some larger-scale
> > changes in the file, it still won't be merged properly.
> 
> I probably am guilty of starting this misinformation, but the
> code does not compare the latest in A and B for rename
> detection; it compares (O, A) and (O, B).

Where O = LCA(A,B) (modulo recursiveness)? Yes, that is what I meant to
say but I phrased it wrong, sorry.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
