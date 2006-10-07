From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: using quotemeta
Date: Fri, 06 Oct 2006 22:08:03 -0700
Message-ID: <7vr6xkzpak.fsf@assigned-by-dhcp.cox.net>
References: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com>
	<200610022250.32029.jnareb@gmail.com>
	<7vven1syg0.fsf@assigned-by-dhcp.cox.net>
	<200610061438.50965.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 07:08:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW4Q1-0005Em-Lv
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 07:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWJGFIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 01:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWJGFIJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 01:08:09 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49339 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751707AbWJGFIH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 01:08:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007050805.MYNY26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 01:08:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XH861V00a1kojtg0000000
	Sat, 07 Oct 2006 01:08:07 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610061438.50965.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 6 Oct 2006 14:38:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28454>

Jakub Narebski <jnareb@gmail.com> writes:

> I'd rather add (and use) separate subroutine for quoting/escaping
> values in HTTP headers, or to be more exact for the filename part
> of HTTP header "Content-Disposition:". This way if we decide to
> not replace all characters outside US-ASCII in suggested filename
> to save with '?', but only qoublequote '"' and linefeed '\n' characters,
> or even implement RFC 2047 to do the encoding (of course if browsers
> can read it), we could do this in one place. 

Sounds sane.  quote_filename?
