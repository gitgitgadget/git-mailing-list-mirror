From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 22:59:18 -0700
Message-ID: <7v3bo5v9hl.fsf@assigned-by-dhcp.cox.net>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
	<59a6e583050914114054b1564d@mail.gmail.com>
	<Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
	<17192.56103.803096.526568@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0509142029210.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, Wayne Scott <wsc9tt@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 07:59:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG9Fu-0006iX-CY
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 07:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbVIPF7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 01:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbVIPF7X
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 01:59:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58535 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030596AbVIPF7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 01:59:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916055921.HWGZ9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 01:59:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509142029210.26803@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 14 Sep 2005 20:29:50 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8662>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 15 Sep 2005, Paul Mackerras wrote:
>>
>> Linus Torvalds writes:
>> 
>> > Damn, too bad valgrind doesn't work on ppc64, so I can't use it on my main 
>> > machine. It seems to be in development on ppc32, so maybe some day.

FWIW, I think I fixed the leak that patch we reverted was
attempting to fix, and on my i386 box valgrind seems much
happier.
