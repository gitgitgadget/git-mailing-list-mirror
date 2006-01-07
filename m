From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Fri, 6 Jan 2006 20:22:21 -0500
Message-ID: <20060107012221.GA7730@mythryan2.michonline.com>
References: <dp3qpb$7uk$1@sea.gmane.org> <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 02:22:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev2nD-0001je-D3
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 02:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWAGBWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 20:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWAGBWs
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 20:22:48 -0500
Received: from mail.autoweb.net ([198.172.237.26]:63129 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932632AbWAGBWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 20:22:47 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Ev2n6-00058r-EI; Fri, 06 Jan 2006 20:22:45 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1Ev2n5-0004db-00; Fri, 06 Jan 2006 20:22:43 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1Ev2mu-0002gP-1m; Fri, 06 Jan 2006 20:22:32 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14235>

On Fri, Jan 06, 2006 at 02:37:27PM -0800, Junio C Hamano wrote:
>
> Since I do not understand what that "g"
> stands for anyway, how about doing something like this instead?

I'm pretty sure the "g" is my fault, indirectly.  When I submitted the
"AUTO_LOCALVERSION" patch to Linux, I prepended a -g to it, so it would
be possible to tell versions based off of a git tree apart from versions
based off of a CVS tree that used md5 to make a short, semi-unique
indicator.  Presumably, a CVS variant would've done something like
-c012345678, etc.

So, it's just a little mnemonic to hint that the extra version string
came from a git tree, as opposed to some other semi-random source. It's
value is rather dubious, overall, though.

-- 

Ryan Anderson
  sometimes Pug Majere
