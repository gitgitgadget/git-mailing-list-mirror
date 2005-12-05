From: Junio C Hamano <junkio@cox.net>
Subject: Re: make gitfakemmap standalone to fix linking error in git.c
Date: Mon, 05 Dec 2005 13:49:55 -0800
Message-ID: <7vvey39pto.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	<20051205213612.GA4443@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 22:50:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjODh-0001sN-Fe
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 22:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVLEVt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 16:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVLEVt7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 16:49:59 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13011 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964815AbVLEVt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 16:49:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205214816.NQMQ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 16:48:16 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051205213612.GA4443@steel.home> (Alex Riesen's message of
	"Mon, 5 Dec 2005 22:36:12 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13236>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Mon, Dec 05, 2005 18:40:21 +0100:
>> > Why does it always happen...
>> Because you touched you did not absolutely have to ;-).
>
> well, git$(X) didn't link...

I meant your change to the "if ()" expression in gitfakemmap().
Does the change have anything to do with git$X linkage?  I think
not.
