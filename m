From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 1/3] Fix probing for already installed Error.pm
Date: Fri, 30 Jun 2006 14:08:11 -0400
Message-ID: <1151690891.11093.0.camel@dv>
References: <20060630050923.701.37665.stgit@dv.roinet.com>
	 <7vfyhnksqf.fsf@assigned-by-dhcp.cox.net>
	 <7vbqsbks69.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 20:08:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwNPn-0000nj-9Z
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 20:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWF3SIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 14:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932984AbWF3SIY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 14:08:24 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:18875 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932126AbWF3SIX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 14:08:23 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FwNPi-00068K-F4
	for git@vger.kernel.org; Fri, 30 Jun 2006 14:08:22 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FwNPX-0000Ss-TV; Fri, 30 Jun 2006 14:08:11 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqsbks69.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.3 (2.7.3-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23008>

On Fri, 2006-06-30 at 00:40 -0700, Junio C Hamano wrote:
> > It is trying to see if we need to install the Error.pm we ship
> > just in case the system does not have Error.pm available.  But
> > this script is run in perl/ directory where we have that private
> > copy of Error.pm, so "require Error" always succeeds, eh, at
> > least after you fixed the above syntax error X-<.

Nice catch!  Thank you for fixing it.

-- 
Regards,
Pavel Roskin
