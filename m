From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Fix warnings on PowerPC - use C99 printf format if
	available
Date: Wed, 10 Jan 2007 01:24:43 -0500
Message-ID: <20070110012443.xixagu9e5s04wwss@webmail.spamcop.net>
References: <20070110040710.7403.74668.stgit@localhost.localdomain>
	<7vk5zvfobp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 07:31:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Wzg-0000Rp-UT
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 07:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbXAJGbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 01:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbXAJGbY
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 01:31:24 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:55885 "HELO
	mailgate.cesmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932542AbXAJGbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 01:31:23 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 01:31:23 EST
Received: (qmail 5058 invoked from network); 10 Jan 2007 06:24:43 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 10 Jan 2007 06:24:43 -0000
Received: (qmail 29481 invoked by uid 99); 10 Jan 2007 06:24:43 -0000
Received: from c-71-230-131-166.hsd1.pa.comcast.net
	(c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Wed, 10 Jan 2007 01:24:43 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk5zvfobp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36479>

Quoting Junio C Hamano <junkio@cox.net>:

> Pavel Roskin <proski@gnu.org> writes:
>
> > Signed-off-by: Pavel Roskin <proski@gnu.org>
>
> This needs a better subject.  I do not see anything PowerPC specific...

Indeed, it happens on i386 as well (but not on x86_64).  OK, the subject should
be:

Fix warnings in sha1_file.c - use C99 printf format if available

--
Regards,
Pavel Roskin
