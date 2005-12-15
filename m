From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH 5/11] git-applypatch: Usage string clean-up, emit usage string at incorrect invocation
Date: Thu, 15 Dec 2005 20:55:28 +0100
Message-ID: <20051215195528.GA14388@c165.ib.student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se> <11345130311492-git-send-email-freku045@student.liu.se> <7vfyow45l2.fsf@assigned-by-dhcp.cox.net> <20051214144542.0a509e3e.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, freku045@student.liu.se,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 21:00:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmzCa-0002n7-09
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 20:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVLOTzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbVLOTzf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 14:55:35 -0500
Received: from [85.8.31.11] ([85.8.31.11]:49109 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751004AbVLOTzf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 14:55:35 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 9719640FD; Thu, 15 Dec 2005 21:06:03 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EmzCK-0003lr-00; Thu, 15 Dec 2005 20:55:28 +0100
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051214144542.0a509e3e.tihirvon@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13709>

On Wed, Dec 14, 2005 at 02:45:42PM +0200, Timo Hirvonen wrote:
> On Tue, 13 Dec 2005 21:20:57 -0800
> Junio C Hamano <junkio@cox.net> wrote:
> 
> > freku045@student.liu.se writes:
> > 
> > >  . git-sh-setup
> > >  
> > > +[[ "$#" = "3" || "$#" = "4" ]] || usage
> > > +
> > 
> > I do not see much advantage to use [[...]] construct here.
> 
> [[ ]] is bashishm. Does not work with ash.
> 
> 
> test $# -ge 3 && test $# -le 4 || usage
> 
> You don't need to quote $# because it is always defined (and always
> non-negative integer).  You can't unset or set it.

Thanks. I guess this is what happens when you try to learn sh
programming from the bash manpage. :)

- Fredrik
