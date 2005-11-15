From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 09:32:34 -0800
Message-ID: <20051115173234.GC3793@reactrix.com>
References: <1132034390.22207.18.camel@dv> <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv> <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net> <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de> <20051115121854.GV30496@pasky.or.cz> <7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net> <1132075295.25640.59.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 18:35:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4gN-0000TZ-4c
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVKORdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVKORdT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:33:19 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:54746 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751459AbVKORdS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 12:33:18 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAFHWa50029759;
	Tue, 15 Nov 2005 09:32:36 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAFHWYp9029756;
	Tue, 15 Nov 2005 09:32:34 -0800
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1132075295.25640.59.camel@dv>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11924>

On Tue, Nov 15, 2005 at 12:21:35PM -0500, Pavel Roskin wrote:

> > Sorry, I must have missed that part.  How does fetch-over-HTTP
> > break with symlinked HEAD?

Symlinks can also be problematic for push-over-HTTP, since there are no
guarantees about the backend on the server (eg. pushing into a
subversion repo with mod_dav_svn.)

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
