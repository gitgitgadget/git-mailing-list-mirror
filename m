From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 13:40:55 +0000
Message-ID: <20081120134055.GB6023@codelibre.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net> <86iqqizgng.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39nR-0002c5-3E
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbYKTNk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbYKTNk6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:40:58 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:42958 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbYKTNk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:40:57 -0500
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id 185FA18852; Thu, 20 Nov 2008 13:40:55 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <86iqqizgng.fsf@blue.stonehenge.com>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 13:26:52 up 13 days,  1:44,  3 users,  load average: 0.01,
	0.11, 0.09
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101429>

On Thu, Nov 20, 2008 at 05:11:15AM -0800, Randal L. Schwartz wrote:
> >>>>> "Roger" == Roger Leigh <rleigh@codelibre.net> writes:
> 
> Roger> Except in this case I'm storing the content of *tarballs* (along with
> Roger> pristine-tar).  I'm committing exactly what's in the tarball with
> Roger> no changes (this is a requirement).  I can't change the source prior
> Roger> to commit.
> 
> If you're not doing distributed source code development, why are you using
> git?  It's hard to be angry at a screwdriver for not pounding in nails
> properly.

Err, it *is* being used for distributed development... of Debian
packaging.  We track upstream releases on one branch, merge this
periodically onto the master branch containing the Debian packaging
infrastructure, and also have other bits such as a
continually-rebased patches branch to generate quilt patch series
from.  I think you'll find we do actually need to use git.

> Sounds like you want rsync or something.

I think not!  Perhaps if you read my original mail, you might
understand the reasoning behind this (whether you consider that
valid reasoning or not is another matter).


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
