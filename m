From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Expected Behavior?
Date: Tue, 8 Nov 2005 23:53:20 +0100
Message-ID: <20051108225320.GB4805@c165.ib.student.liu.se>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <7v7jbig6m7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 23:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZcLF-0004lM-1K
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 23:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbVKHWxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 17:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbVKHWxW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 17:53:22 -0500
Received: from [85.8.31.11] ([85.8.31.11]:53903 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965278AbVKHWxV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 17:53:21 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 272D640FF; Wed,  9 Nov 2005 00:01:44 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZcLA-0001Yo-00; Tue, 08 Nov 2005 23:53:20 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jbig6m7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11364>

On Tue, Nov 08, 2005 at 01:41:20PM -0800, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > Jon: You could try to this merge with the recursive merge strategy
> > (git merge -s recursive 'merge message' master dev) If you do, you
> > _should_ get something like:
> >
> >     CONFLICT (add/add): File file3 added non-identically in both
> >     branches. Adding as file3_master and file3_dev instead.
> >
> > You will then end up with file3_master and file3_dev in your working
> > tree, which corresponds to file3 in the master branch and file3 in the
> > dev branch, respectively.
> 
> Oops, I missed that part.  This is unsafe in theory, if you
> could overwrite existing file3_master or file3_dev.  Does that
> matter in practice?
> 

It wont overwrite any existing files. If there is a file named
'file3_master' then the new file will be named 'file3_master_1' and if
that file also exists the new file will be named 'file3_master_2', and
so on.

- Fredrik
