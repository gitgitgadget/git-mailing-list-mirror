From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 00:18:48 -0500
Message-ID: <20060119051848.GA8121@trixie.casa.cgf.cx>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com> <7vvewi2typ.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 06:18:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzSCC-0006HB-KU
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 06:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWASFSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 00:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWASFSu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 00:18:50 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:50911 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161017AbWASFSt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 00:18:49 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 147974A84BC; Thu, 19 Jan 2006 00:18:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvewi2typ.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14887>

On Tue, Jan 17, 2006 at 05:41:34PM -0800, Junio C Hamano wrote:
>Alex Riesen <raa.lkml@gmail.com> writes:
>>Probably another one windows quirk, or just the moon phases, but I have
>>to make damn sure it sleeps long enough.
>
>IIRC, DOS file timestamps have 2 seconds granularity, so sleeping for
>one second might not be enough to begin with.  Also I run my cygwin
>test on sufficiently slow machine, so that may explain why I have not
>notice the problem ;-).

Cygwin really does sleep a second if you tell it to, but on FAT
filesystems, you're right, the granularity something like 2 seconds.

cgf
