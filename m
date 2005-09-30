From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix gcc-4 warning in accept() call
Date: Thu, 29 Sep 2005 23:21:35 -0700
Message-ID: <7vvf0j849c.fsf@assigned-by-dhcp.cox.net>
References: <1128027901.24397.57.camel@dv>
	<7vachv9kbq.fsf@assigned-by-dhcp.cox.net> <433CD2E7.5090909@zytor.com>
	<433CD412.8020409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 08:22:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELEH9-0003d1-A9
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 08:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVI3GVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 02:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVI3GVj
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 02:21:39 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15830 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932291AbVI3GVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 02:21:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930062138.TRNB9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 02:21:38 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433CD412.8020409@zytor.com> (H. Peter Anvin's message of "Thu,
	29 Sep 2005 22:58:42 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9542>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Apparently I'm wrong; socklen_t is unsigned int at least on glibc for 
> i386.  I'll shut up now.

Ah, I should shut up too.  Thanks for checking what we should
use.
