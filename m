From: Pavel Roskin <proski@gnu.org>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Fri, 28 Jul 2006 22:10:12 -0400
Message-ID: <1154139012.3154.38.camel@dv>
References: <20060728063620.GD30783@spearce.org>
	 <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx>
	 <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net>
	 <slrnecjeru.bou.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 04:10:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6eHY-0001Be-IJ
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 04:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWG2CKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 22:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWG2CKV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 22:10:21 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:58838 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161184AbWG2CKV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 22:10:21 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G6eHU-0004dU-4n
	for git@vger.kernel.org; Fri, 28 Jul 2006 22:10:20 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1G6eHM-0006Bp-Ag; Fri, 28 Jul 2006 22:10:12 -0400
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
In-Reply-To: <slrnecjeru.bou.Peter.B.Baumann@xp.machine.xx>
X-Mailer: Evolution 2.7.4 (2.7.4-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24408>

On Fri, 2006-07-28 at 09:23 +0200, Peter Baumann wrote:
> >> *** glibc detected *** double free or corruption (!prev): 0x080933b0 ***
> >> /usr/bin/git-clone: line 29: 10712 Aborted                 git-http-fetch -v
> >> -a -w "$tname" "$name" "$1/"
> >
> > I'm not getting that.  I hope you are just using an obsolete version of git.
> 
> Not _that_ old, me thinks. I'm using the debian unstable version.

I tried to reproduce it but couldn't.  I tried valgrind (3.2.0 and
current) on two architectures, I tried _FORTIFY_SOURCE=2 to no avail -
it just won't crash or report anything suspicious.  It's the current
master branch of git.

So, it's up to you to debug it.

-- 
Regards,
Pavel Roskin
