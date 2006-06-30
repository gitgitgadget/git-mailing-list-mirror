From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH/RFH] Racy GIT (part #3)
Date: Fri, 30 Jun 2006 09:43:00 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060630074300.GA1643@informatik.uni-freiburg.de>
References: <7v7j2zpr6k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:43:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDed-0006Zy-V3
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWF3HnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWF3HnE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:43:04 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:25571 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751248AbWF3HnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:43:03 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FwDeY-00063Z-F3; Fri, 30 Jun 2006 09:43:02 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k5U7h1K0002243;
	Fri, 30 Jun 2006 09:43:01 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k5U7h0EF002242;
	Fri, 30 Jun 2006 09:43:00 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7j2zpr6k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22967>

Hello,

Junio C Hamano wrote:
> Does everybody have "cp -p" to preserve the file timestamps on
> his/her platform?  I am assuming this is safe (it is in POSIX),
> but please raise hand if that is not a case for you.
Solaris[1] has two different "cp"s[2].

 From cp(1):
	[...] [/usr/bin/cp] does not fail if unable to preserve extended
	attributes, modification and access time, or permission modes.

	[...] [/usr/xpg4/bin/cp] does not fail if unable to preserve
	extended attributes.  If unable to duplicate the modification
	and access time or the permission modes, cp prints a diagnostic
	message to stderr and return a non-zero exit status.


There is yet an other difference when -@ is specified.  The complete man
page can be found at docs.sun.com[2].

Best regards
Uwe

[1] in my case Solaris 10 = SunOS 5.10 and Solaris 9 = SunOS 5.9
[2] http://docs.sun.com/app/docs/doc/816-5165/6mbb0m9dm?a=view

-- 
Uwe Zeisberger

http://www.google.com/search?q=0+degree+Celsius+in+kelvin
