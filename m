From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 22:01:38 -0700
Message-ID: <20060806050138.GN23246@ca-server1.us.oracle.com>
References: <20060805031418.GA11102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 07:02:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9alu-0001Cj-4g
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 07:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWHFFBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 01:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWHFFBv
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 01:01:51 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:57815 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932244AbWHFFBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 01:01:50 -0400
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k7651k73024573;
	Sat, 5 Aug 2006 23:01:46 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k7651jff031153
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Sat, 5 Aug 2006 23:01:46 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.62)
	(envelope-from <joel.becker@oracle.com>)
	id 1G9ale-0004lt-Fi; Sat, 05 Aug 2006 22:01:40 -0700
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060805031418.GA11102@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24964>

On Fri, Aug 04, 2006 at 11:14:19PM -0400, Jeff King wrote:
> The git-status output can sometimes be very verbose, making it difficult to
> quickly see whether your files are updated in the index. This adds 4 levels
> of colorizing to the status output:
>   - general header (defaults to normal white)
>   - updated but not committed (defaults to green)
>   - changed but not updated (defaults to red)
>   - untracked files (defaults to red)

Please do one of two things:
1) Add code to discover a terminal is white-on-black and use bright colors
or
2) Default this to off.

I like the idea of colors, but the colors most people use in
black-on-white terminals are invisible on my screen.  colorls has the
same problem.

Joel

-- 

"What no boss of a programmer can ever understand is that a programmer
 is working when he's staring out of the window"
	- With apologies to Burton Rascoe


Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
