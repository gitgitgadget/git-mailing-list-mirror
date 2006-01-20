From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 22:35:49 -0500
Message-ID: <20060120033548.GE5090@trixie.casa.cgf.cx>
References: <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net> <20060118185229.GA3001@steel.home> <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net> <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com> <20060119182822.GA32022@trixie.casa.cgf.cx> <20060119221227.GB3601@steel.home> <20060119222553.GB7567@trixie.casa.cgf.cx> <7vbqy78zwy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 20 04:35:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezn48-0004J4-3x
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 04:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161476AbWATDfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 22:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWATDfu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 22:35:50 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:16573 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161476AbWATDft (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 22:35:49 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 4B6754A85B3; Thu, 19 Jan 2006 22:35:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbqy78zwy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14951>

On Thu, Jan 19, 2006 at 05:13:17PM -0800, Junio C Hamano wrote:
>Christopher Faylor <me@cgf.cx> writes:
>>Inodes are only calculated by hashing the path name when the OS lacks
>>the support to provide a "real" inode and in that case there is no hard
>>link support available so it's a non-issue.
>
>Does that mean on such filesystems "mv foo bar" would change the i-num
>of the moved entity?

I just tried this on Windows XP.  On a FAT32 or a NTFS filesystem the
inode is unchanged.  On a FAT filesystem, it changes.  I assume that
means that FAT doesn't support a real file ID.  The only thing I think
anyone would be using FAT for these days is possibly a boot partition.
That's the only reason I have one.  I use to to multi-boot various
flavors of Windows.  It's the lowest common denominator.

>I am not complaining even if that is the case.  I just want to
>understand what it does.

NP.  I complain about this fairly frequently myself.  :-)

cgf
