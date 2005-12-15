From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 06:19:52 -0800
Message-ID: <7vu0daphmf.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
	<7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 15:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emtyf-0006UA-Cb
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 15:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVLOOTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 09:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVLOOTy
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 09:19:54 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61169 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750701AbVLOOTx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 09:19:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215141901.YQKG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 09:19:01 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
	(Alex Riesen's message of "Thu, 15 Dec 2005 11:16:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13694>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 12/15/05, Junio C Hamano <junkio@cox.net> wrote:
>> I think the reason why my trial here worked correctly while you
>> had trouble with it is because I have the send-pack fix from
>> Pasky last night.
>
> yes, probably. It cleanups a reference if there was an error, right?

Not really.  send-pack does not have anything to do with this
(it is involved in git-push not git-pull).  Care to see how
yours gets broken when you do "sh -x git-pull.sh . ref1 HEAD"?
If .git/refs/heads/HEAD exists in the first place then I would
understand it would not fail with the error message I quoted,
but the original message from you indicated that "git pull" is
the one that creates the breakage, and I am trying to see how.
