From: Junio C Hamano <junkio@cox.net>
Subject: Re: Odd behavior with git and cairo-devel repo
Date: Wed, 21 Jun 2006 12:43:12 -0700
Message-ID: <7v3bdyz44v.fsf@assigned-by-dhcp.cox.net>
References: <20060621010030.GP2820@artsapartment.org>
	<20060621024605.GO11245@skl-net.de>
	<20060621120618.GR2820@artsapartment.org>
	<20060621174632.GP11245@skl-net.de>
	<Pine.LNX.4.64.0606211054500.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andre Noll <maan@systemlinux.org>, Art Haas <ahaas@airmail.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 21:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft8bf-0007V3-SD
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWFUTnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbWFUTnP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 15:43:15 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45266 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932706AbWFUTnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 15:43:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621194314.PULG554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 15:43:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606211054500.5498@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 21 Jun 2006 11:01:12 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22285>

Linus Torvalds <torvalds@osdl.org> writes:

> Ouch. 

Ouch indeed ;-).

> Actually, the alternate patch is the one I had intended to do but for some 
> reasons didn't.
>
> This one also removes two more lines than it adds, but it's obviously a 
> bigger patch.

I'll take this, since I think keeping the hash population
(collision maintenance) code in one place like your version does
seems cleaner for me to read three months down the road.

Again, thanks Andre, Art and Linus.
