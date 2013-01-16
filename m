From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 23:37:44 +0400
Message-ID: <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
	<20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
	<20130116182156.GB4426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	"Lang, David" <David.Lang@uhn.ca>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvYok-0005nx-1P
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 20:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327Ab3APTiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 14:38:08 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:53892 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab3APTiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 14:38:04 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r0GJbiSG012412;
	Wed, 16 Jan 2013 23:37:45 +0400
In-Reply-To: <20130116182156.GB4426@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213805>

On Wed, 16 Jan 2013 10:21:56 -0800
Jeff King <peff@peff.net> wrote:

Thanks for elaborating on the "origin" -- I intended to write up on its
special status but got distracted and sent my message missing that
bit ;-)

[...]
> > > Ideally we'd prefer to simply create our remote repository on a
> > > drive of one of our local network servers. Is this possible?
> > 
> > Yes, this is possible, but it's not advised to keep such a
> > "reference" repository on an exported networked drive for a number
> > of reasons (both performance and bug-free operation).
> 
> I agree that performance is not ideal (although if you are on a fast
> LAN, it probably would not matter much), but I do not recall any
> specific bugs in that area. Can you elaborate?

This one [1] for instance.  I also recall seing people having other
"mystical" problems with setups like this so I somehow developed an idea
than having a repository on a networked drive is asking for troubles.
Of course, if there are happy users of such setups, I would be glad to
hear as my precautions might well be unfounded for the recent versions
of Git.

1. http://code.google.com/p/msysgit/issues/detail?id=130
