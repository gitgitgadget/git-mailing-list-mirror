From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH-RFC] Rewrite ls-tree to behave more like "/bin/ls -a"
Date: Sun, 29 May 2005 11:44:22 -0700
Message-ID: <7vhdgloos9.fsf@assigned-by-dhcp.cox.net>
References: <20050527120851.GA11823@port.evillabs.net>
	<7vmzqgzg8a.fsf@assigned-by-dhcp.cox.net>
	<1117221986.11542.29.camel@jmcmullan.timesys>
	<7v1x7syqkm.fsf@assigned-by-dhcp.cox.net>
	<7vll5zygn1.fsf_-_@assigned-by-dhcp.cox.net>
	<1117317729.11542.32.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 20:43:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSjk-00020N-7Z
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVE2Soe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVE2Soe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:44:34 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:28858 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261320AbVE2SoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 14:44:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529184422.OLCZ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 14:44:22 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1117317729.11542.32.camel@jmcmullan.timesys> (Jason McMullan's
 message of "Sat, 28 May 2005 18:02:08 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JM" == Jason McMullan <jason.mcmullan@timesys.com> writes:

JM> On Sat, 2005-05-28 at 00:05 -0700, Junio C Hamano wrote:

>> - Unlike the old ls-tree behaviour that used paths arguments to
>> restrict output (not that it worked as intended---as pointed
>> out in the mailing list discussion, it was quite incoherent),
>> this rewrite uses paths arguments to specify what to show.
>> ...

JM> This behavior pattern is very agreeable. I'll take it!

Glad to know we are in agreement.

BTW, long after finishing the rewrite, I realized that all of
the problems you raised did not exist in the very original
version of ls-tree, but were bugs in _your_ patch that added the
paths restriction.  I was merely cleaning up your mess for you
without knowing what I was doing. ;-) Not that I do not like
what the resulting code does, though.

I am not going to re-submit this to Linus right now, since he
seems to be quiet here and spending more time and attention to
the kernel, which is what I want to see.  When Linus starts
pulling in update for GIT, and if you see this one not applied
to his tree, please remind him.

