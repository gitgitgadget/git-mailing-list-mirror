From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 06:30:40 -0800
Message-ID: <7vlkymph4f.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
	<7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 15:33:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emu8E-0001rk-8o
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 15:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVLOOan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 09:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVLOOan
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 09:30:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:29842 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750702AbVLOOam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 09:30:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215142946.EMD20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 09:29:46 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
	(Alex Riesen's message of "Thu, 15 Dec 2005 11:16:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13695>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 12/15/05, Junio C Hamano <junkio@cox.net> wrote:
>
>> >
>> > $ git pull . ref1 HEAD (notice the space!)
>>
>> If you were too used to git merge, you would have wrote
>> HEAD before ref1, so that does not sound plausible ;-).
>
> no, that I have remembered. What I constantly forget is the
> space-vs-colon difference.

That statement sounds as if "git pull . ref1:HEAD" makes some
sense and you typed it without colon by mistake.  But it does
not make any sense to me; I am puzzled ... what are you trying
to achieve with "git pull . ref1:HEAD"?

The patch from Johannes feels right but I haven't had caffeine
yet, so..
