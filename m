From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 10:59:49 -0800
Message-ID: <20051114185949.GE20749@ca-server1.us.oracle.com>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz> <20051114181958.GD20749@ca-server1.us.oracle.com> <Pine.LNX.4.64.0511141027380.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 20:05:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbjYm-0004Vo-TZ
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 20:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVKNTAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 14:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVKNTAF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 14:00:05 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:9854 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751239AbVKNTAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 14:00:04 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id jAEIxpuw024586;
	Mon, 14 Nov 2005 11:59:51 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jAEIxo8T005181;
	Mon, 14 Nov 2005 11:59:50 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jAEIxnmJ005153
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 14 Nov 2005 11:59:50 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1EbjYT-0008F7-R8; Mon, 14 Nov 2005 10:59:49 -0800
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511141027380.3263@g5.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11838>

On Mon, Nov 14, 2005 at 10:39:26AM -0800, Linus Torvalds wrote:
> > 	${i# and ${i% are POSIX, iirc.
> 
> They may be in POSIX, but they sure as h*ll aren't portable.

	By POSIX I meant POSIX shell, which is ksh.  That's available on
just about all modern non-free Unices, and we all know bash and zsh are
compatible with it.
	But I had no intention of arguing how portable POSIX is, I was
just trying to describe the minimum breadth of support.  My personal
experience is that these particular variable forms have worked on Linux,
Solaris, AIX, Ultrix, IRIX, and the BSDs for, I dunno, eight to ten
years or so.
	That said, $(echo | sed), or `echo | sed` for even more
backwards portability (I bet $() is about as portable as ${i%}), can be
used to replace the ${i%} forms.

Joel

-- 

"I always thought the hardest questions were those I could not answer.
 Now I know they are the ones I can never ask."
			- Charlie Watkins

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
