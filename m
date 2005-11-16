From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 20:56:11 -0500
Message-ID: <1132106171.18941.2.camel@dv>
References: <1132034390.22207.18.camel@dv>
	 <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv>
	 <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051115121854.GV30496@pasky.or.cz> <1132074375.25640.47.camel@dv>
	 <7vy83plqlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 02:57:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcCXZ-0002hl-6C
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 02:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVKPB4r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 20:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVKPB4q
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 20:56:46 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:63678 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965163AbVKPB4q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 20:56:46 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EcCXU-00019V-HM
	for git@vger.kernel.org; Tue, 15 Nov 2005 20:56:44 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EcCWx-0000Rh-N1; Tue, 15 Nov 2005 20:56:11 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy83plqlr.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11988>

On Tue, 2005-11-15 at 10:21 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:

> The voice of reason comes from Pasky; I agree with this.

OK, let's prepare for post-1.0 switchover then.

> I am in favor of that.  Something like this, perhaps:
> 
> 	core.filemode = 1 # trustworthy
>         core.usesymlink = 0 # new style 

Thanks for implemented this.

-- 
Regards,
Pavel Roskin
