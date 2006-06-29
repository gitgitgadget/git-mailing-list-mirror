From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:43:49 -0700
Message-ID: <20060629214349.GA11640@ca-server1.us.oracle.com>
References: <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain> <20060629185335.GA6704@coredump.intra.peff.net> <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain> <20060629195201.GA10786@coredump.intra.peff.net> <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain> <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org> <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain> <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 00:05:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4bs-00052h-Ms
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859AbWF2WCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932830AbWF2VoJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:44:09 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:12184 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932812AbWF2VoG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:06 -0400
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k5TLhpq3010709;
	Thu, 29 Jun 2006 16:43:51 -0500
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k5TLhorA021828
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 15:43:50 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.62)
	(envelope-from <joel.becker@oracle.com>)
	id 1Fw4If-0000os-NV; Thu, 29 Jun 2006 14:43:49 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22917>

On Thu, Jun 29, 2006 at 02:30:11PM -0700, Linus Torvalds wrote:
> However, that is obviously also the dis-advantage, since it means that 
> repacking cannot improve packing. So adding a flag to say "please try to 
> incrementally improve the pack" might well be worth it, even if this new 
> behaviour would be the _default_.

	I nominate "--pack-me-harder".

Joel

-- 

"Behind every successful man there's a lot of unsuccessful years."
        - Bob Brown

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
