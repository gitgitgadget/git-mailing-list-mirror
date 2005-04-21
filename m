From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 22:08:28 -0700
Message-ID: <7vll7cg1ir.fsf@assigned-by-dhcp.cox.net>
References: <20050420205633.GC19112@pasky.ji.cz>
	<20050420211919.GA20129@kroah.com>
	<20050420215117.GJ19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
	<20050420222815.GM19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
	<Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
	<20050421033526.GA9404@nevyn.them.org>
	<Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
	<20050421042248.GA16002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Jacobowitz <dan@debian.org>, Petr Baudis <pasky@ucw.cz>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 07:04:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOTrg-0001xc-SZ
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 07:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVDUFI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 01:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVDUFI5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 01:08:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53501 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261216AbVDUFI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 01:08:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421050829.BDBH4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Apr 2005 01:08:29 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050421042248.GA16002@redhat.com> (Dave Jones's message of
 "Thu, 21 Apr 2005 00:22:48 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DJ" == Dave Jones <davej@redhat.com> writes:

DJ> I used to do 'bk changes | grep \[AGPGART\] -C3 | head' on a
DJ> regular basis, just to be able to answer 'hey, did cset x
DJ> get into tree y?' questions from users.  which is the
DJ> probably the closest I came to non-paginated usage.

I am bk untainted so I may be misunderstanding what your example
is, but I take that "bk changes" in your example corresponds to
"git log", correct?

Then please read what Linus wrote again.  Your example is
exactly the point Linus is making.  The output from that command
is not going to a tty---it is going to a _pipe_ and more or less
will do exactly (not more or less ;-) the right thing.

