From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Expected Behavior?
Date: Wed, 9 Nov 2005 09:19:06 +0100
Message-ID: <20051109081906.GA4960@c165.ib.student.liu.se>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <7v7jbig6m7.fsf@assigned-by-dhcp.cox.net> <20051108225320.GB4805@c165.ib.student.liu.se> <7vmzkenzcx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 09:20:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZlAp-0001p9-KL
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 09:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbVKIITN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 03:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbVKIITN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 03:19:13 -0500
Received: from [85.8.31.11] ([85.8.31.11]:7568 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965308AbVKIITM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 03:19:12 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 3867D40FF; Wed,  9 Nov 2005 09:27:31 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZlAg-0001LF-00; Wed, 09 Nov 2005 09:19:06 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzkenzcx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11390>

On Tue, Nov 08, 2005 at 09:50:54PM -0800, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> >> Oops, I missed that part.  This is unsafe in theory, if you
> >> could overwrite existing file3_master or file3_dev.  Does that
> >> matter in practice?
> >
> > It wont overwrite any existing files. If there is a file named
> > 'file3_master' then the new file will be named 'file3_master_1' and if
> > that file also exists the new file will be named 'file3_master_2', and
> > so on.
> 
> Another thing to watch out is that a branch name could have a
> slash in it.  It might make more sense to just name the heads file3~2
> or file3~3 (with as many ~s repeated to avoid name clashes) like
> Pasky does.
> 

Oups, I haven't thought about that. I kind of like the idea that you
can see the branch name in the file names though. How about replacing
any slashes in the branch names with underscores? So the branch
'foo/bar' will give rise to files with suffixes like '_foo_bar' and
'_foo_bar_<number>'.

- Fredrik
