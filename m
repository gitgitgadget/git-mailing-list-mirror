From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 19:13:30 -0800
Message-ID: <7virutcmjp.fsf@assigned-by-dhcp.cox.net>
References: <1132034390.22207.18.camel@dv>
	<7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	<1132042427.3512.50.camel@dv>
	<7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	<7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051115121854.GV30496@pasky.or.cz> <1132074375.25640.47.camel@dv>
	<7vy83plqlr.fsf@assigned-by-dhcp.cox.net>
	<1132106171.18941.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Pavel Roskin <proski@gnu.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 04:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcDjr-00009l-Ut
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVKPDNd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 22:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVKPDNd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:13:33 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57735 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965196AbVKPDNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 22:13:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116031240.ZAJV17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 22:12:40 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <1132106171.18941.2.camel@dv> (Pavel Roskin's message of "Tue, 15
	Nov 2005 20:56:11 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11997>

Pavel Roskin <proski@gnu.org> writes:

>> I am in favor of that.  Something like this, perhaps:
>> 
>> 	core.filemode = 1 # trustworthy
>>         core.usesymlink = 0 # new style 
>
> Thanks for implemented this.

Thank from me, too, Johannes.
