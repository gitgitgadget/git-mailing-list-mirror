From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 09:33:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511150931010.3945@g5.osdl.org>
References: <1132034390.22207.18.camel@dv>  <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
 <1132042427.3512.50.camel@dv>  <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net> 
 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20051115121854.GV30496@pasky.or.cz>  <7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net>
 <1132075295.25640.59.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 18:37:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4hX-0000wX-M7
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVKOReO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVKOReO
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:34:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751457AbVKOReM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 12:34:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAFHXjnO022123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 09:33:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAFHXi6D010214;
	Tue, 15 Nov 2005 09:33:44 -0800
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1132075295.25640.59.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11925>



On Tue, 15 Nov 2005, Pavel Roskin wrote:
> 
> With symlinks, cogito doesn't know which branch it is fetching if the
> branch is not explicitly specified.
> 
> The old behavior was to fetch the "master" branch by default.
> Currently, cogito uses HEAD, but it cannot read the symlink, it can only
> read the SHA1. 

Hmm? Why not just use "git-symbolic-ref HEAD" to figure it out? That works 
with both symlinks and symrefs (and indeed, was added for that reason).

		Linus
