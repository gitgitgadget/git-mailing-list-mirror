From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Tue, 15 Aug 2006 00:45:56 -0700
Message-ID: <7vr6zi8mrv.fsf@assigned-by-dhcp.cox.net>
References: <20060814075305.GH21963@mellanox.co.il>
	<20060814175523.GC16821@mellanox.co.il>
	<7vk65bdm9f.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0608150040m422e695fl68650dad6b692533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 09:46:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCtch-0000FU-DW
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 09:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWHOHqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 03:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWHOHqA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 03:46:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:7852 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965280AbWHOHp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 03:45:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815074557.XWGC12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Aug 2006 03:45:57 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608150040m422e695fl68650dad6b692533@mail.gmail.com>
	(Alex Riesen's message of "Tue, 15 Aug 2006 09:40:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25443>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 8/14/06, Junio C Hamano <junkio@cox.net> wrote:
>>  - when dealing with the refspecs from the shorthand
>>    (.git/remotes), the one on the first "Pull: " line is for
>>    merge and everything else is not.
>
> What happens if you have _many_ refspecs in a "Pull:"-line?

You should be able to make octopus -- I designed it that way on
purpose, but I haven't used that (mis)-"feature" for quite a
while, so it might have got broken along the way ;-).
