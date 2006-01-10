From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: undoing changes with git-checkout -f
Date: Mon, 9 Jan 2006 20:55:33 -0800
Message-ID: <20060110045533.GO18439@ca-server1.us.oracle.com>
References: <43C2D2C4.2010904@cc.jyu.fi> <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lamikr <lamikr@cc.jyu.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 05:57:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwBYE-0005Iu-2g
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 05:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWAJEzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 23:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWAJEzn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 23:55:43 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:45465 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750702AbWAJEzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 23:55:42 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k0A4tXHx022194;
	Mon, 9 Jan 2006 21:55:33 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A4tWti004511;
	Mon, 9 Jan 2006 21:55:32 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A4tW23004503
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Jan 2006 21:55:32 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1EwBXh-000783-7x; Mon, 09 Jan 2006 20:55:33 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14405>

On Mon, Jan 09, 2006 at 01:46:38PM -0800, Junio C Hamano wrote:
> Please do not use rsync:// transport if possible (mvista might
> only pubilsh via rsync:// and not git://, so it may not be your
> fault).

	Can we teach the git:// fetch program to use CONNECT over HTTP
proxies?  rsync can do this, but git:// cannot, so firewalls that block
9418 mean we use rsync://
	I'm mostly offline this week or I'd take a stab at it.

Joel

-- 

"We will have to repent in this generation not merely for the
 vitriolic words and actions of the bad people, but for the 
 appalling silence of the good people."
	- Rev. Dr. Martin Luther King, Jr.

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
