From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 13:28:22 -0500
Message-ID: <20060119182822.GA32022@trixie.casa.cgf.cx>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com> <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net> <20060118185229.GA3001@steel.home> <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net> <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 19:33:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeWI-0002rP-3A
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWASS2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWASS2X
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:28:23 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:42166 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1030281AbWASS2X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 13:28:23 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id A6E5B5A8006; Thu, 19 Jan 2006 13:28:22 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14926>

On Thu, Jan 19, 2006 at 04:01:19PM +0100, Alex Riesen wrote:
>On 1/19/06, Junio C Hamano <junkio@cox.net> wrote:
>> By the way, if you have an access to git on cygwin with FAT,
>> could you test your patch ($SECONDS) and then i-num patch (the
>> machine with cygwin I can borrow has only NTFS) please?
>
>Works if sleep is for 2 secs (I completely forgot about that stupid
>FAT granularity!)
>st_ino is always the same (it is a hash of pathname).
>Christopher, how is that supposed to work with hardlinks? (NTFS has
>hardlinks, BTW)

There is OS support hardlinks work on NTFS/NT but not on FAT*
"filesystems" or Windows 9x variants.  Hardlink support on Cygwin
mirrors this.

cgf
