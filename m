From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Wed, 18 Jan 2006 08:55:48 -0800
Message-ID: <7vd5ipzd9n.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	<7vvewi2typ.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0601180550k4df9b89fwf73af7966095ffc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:00:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzGbE-0004mp-1g
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 17:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWARQzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 11:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWARQzw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 11:55:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28096 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751367AbWARQzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 11:55:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118165305.JUBT20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 11:53:05 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601180550k4df9b89fwf73af7966095ffc7@mail.gmail.com>
	(Alex Riesen's message of "Wed, 18 Jan 2006 14:50:04 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14837>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 1/18/06, Junio C Hamano <junkio@cox.net> wrote:
>> Instead of depending on $SECONDS (isn't it a bashism?), how
>> about doing something like this?
>
> Probably not, even QNX6 ksh has it, and being the most broken shell
> I ever met, I'd consider $SECONDS safe 8-)

When I have to answer these questions myself, I mostly do so by
checking http://www.opengroup.org/onlinepubs/009695399/.
