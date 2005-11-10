From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 21:34:11 +0100
Message-ID: <20051110203411.GX30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <7v7jbig6m7.fsf@assigned-by-dhcp.cox.net> <20051108225320.GB4805@c165.ib.student.liu.se> <7vmzkenzcx.fsf@assigned-by-dhcp.cox.net> <20051109081906.GA4960@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 21:34:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJ7j-0002L1-8u
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVKJUeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVKJUeQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:34:16 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34015 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932073AbVKJUeP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 15:34:15 -0500
Received: (qmail 32180 invoked by uid 2001); 10 Nov 2005 21:34:11 +0100
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20051109081906.GA4960@c165.ib.student.liu.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11521>

Dear diary, on Wed, Nov 09, 2005 at 09:19:06AM CET, I got a letter
where Fredrik Kuivinen <freku045@student.liu.se> said that...
> On Tue, Nov 08, 2005 at 09:50:54PM -0800, Junio C Hamano wrote:
> > Fredrik Kuivinen <freku045@student.liu.se> writes:
> > 
> > >> Oops, I missed that part.  This is unsafe in theory, if you
> > >> could overwrite existing file3_master or file3_dev.  Does that
> > >> matter in practice?
> > >
> > > It wont overwrite any existing files. If there is a file named
> > > 'file3_master' then the new file will be named 'file3_master_1' and if
> > > that file also exists the new file will be named 'file3_master_2', and
> > > so on.
> > 
> > Another thing to watch out is that a branch name could have a
> > slash in it.  It might make more sense to just name the heads file3~2
> > or file3~3 (with as many ~s repeated to avoid name clashes) like
> > Pasky does.
> > 
> 
> Oups, I haven't thought about that. I kind of like the idea that you
> can see the branch name in the file names though. How about replacing
> any slashes in the branch names with underscores? So the branch
> 'foo/bar' will give rise to files with suffixes like '_foo_bar' and
> '_foo_bar_<number>'.

I like it too. :-)

Now, this would look like file3~master in Cogito (or file3~~master in
case of name conflict, etc.).

Thanks for the idea,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
