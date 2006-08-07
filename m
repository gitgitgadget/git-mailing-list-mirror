From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
Date: Mon, 07 Aug 2006 12:53:29 -0700
Message-ID: <7vu04o1fwm.fsf@assigned-by-dhcp.cox.net>
References: <7vd5bc4czr.fsf@assigned-by-dhcp.cox.net>
	<20060807193809.GA24013@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 21:53:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GABAL-0003Ay-VT
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWHGTxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 15:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHGTxa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 15:53:30 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:897 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932330AbWHGTxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 15:53:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807195329.FMZL2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 15:53:29 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060807193809.GA24013@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 7 Aug 2006 22:38:09 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25036>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> It might not be too difficult to change it though.  This part of
>> the code is relatively old and I do not remember the details
>> offhand, other than I remember that the first time I saw it I
>> had the same confused "Huh?  we do not let a ref fetched twice?"
>> reaction ;-).
>
> At least, fix the error message?

That would touch the same vicinity of code so if I were to do
that myself I would rather see if the restriction can be
loosened properly first.
