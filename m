From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk strangeness..
Date: Tue, 28 Mar 2006 17:18:06 +1100
Message-ID: <17448.54558.865097.519248@cargo.ozlabs.ibm.com>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	<7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 08:18:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO7X1-00049J-HN
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 08:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWC1GSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 01:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWC1GSQ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 01:18:16 -0500
Received: from ozlabs.org ([203.10.76.45]:16012 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932112AbWC1GSQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 01:18:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 21E5F67A06; Tue, 28 Mar 2006 17:18:15 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18111>

> > Would it be possible to put the '-' in only for the last child that
> > has that parent?
> 
> Not trivially.  We do not keep track of who are children of a
> commit.

Hmmm... how does the --topo-order logic ensure that parents are shown
after all of their children?  Essentially I want that logic applied to
the boundary parent commits as well as the requested commits.

The other thing is that if git-rev-list can actually list those
boundary parents, complete with the whole commit message if --header
is given, then that will save gitk from having to do a git-cat-file to
get that information.

Paul.
