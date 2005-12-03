From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] daemon whitelist handling (Re: git pull aborts in 50% of cases)
Date: Sat, 03 Dec 2005 12:20:22 -0800
Message-ID: <7vvey6vsop.fsf@assigned-by-dhcp.cox.net>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
	<43909963.60901@zytor.com>
	<20051202211250.GA11384@mipter.zuzino.mipt.ru>
	<4390B64E.20601@zytor.com>
	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com>
	<7vpsoezf6y.fsf@assigned-by-dhcp.cox.net>
	<7vzmnivuz8.fsf_-_@assigned-by-dhcp.cox.net>
	<4391F4DD.2060002@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 03 21:21:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eids0-0003d9-Vx
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 21:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVLCUUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 15:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVLCUUZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 15:20:25 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59104 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750985AbVLCUUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 15:20:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203202026.PDXE25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 15:20:26 -0500
To: git@vger.kernel.org
In-Reply-To: <4391F4DD.2060002@zytor.com> (H. Peter Anvin's message of "Sat,
	03 Dec 2005 11:41:17 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13166>

"H. Peter Anvin" <hpa@zytor.com> writes:

> At the very least, if you insist on using getcwd() names, you should 
> pre-canonicalize the whitelist, too.

With the current "prefix" rule (and not allowing /ho to match
/home) that sounds possible and sensivle, but that is not nice
in the long run.  We may later want to say "/pub/git/**/*.git"
for example to mean "any subdirectory under /pub/git but the
base directory name must be something ending with '.git'".

Hmm...
