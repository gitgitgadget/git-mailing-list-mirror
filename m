From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff-*: Allow "--name-only -z" as alias for "--name-only-z"
Date: Thu, 14 Jul 2005 22:46:46 -0700
Message-ID: <7vu0iwy62h.fsf@assigned-by-dhcp.cox.net>
References: <20050714215126.GY9915@kiste.smurf.noris.de>
	<7vvf3d6nis.fsf@assigned-by-dhcp.cox.net>
	<20050714223622.GZ9915@kiste.smurf.noris.de>
	<7vmzop56fo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507142205580.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 07:47:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtJ2P-0000gE-1u
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 07:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVGOFqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 01:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbVGOFqv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 01:46:51 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49537 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261855AbVGOFqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 01:46:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050715054650.CRUM7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Jul 2005 01:46:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507142205580.19183@g5.osdl.org> (Linus Torvalds's message of "Thu, 14 Jul 2005 22:12:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 14 Jul 2005, Junio C Hamano wrote:
>> 
>> That said, I have been hating that diff options parsing for
>> quite a while, and I've been thinking about cleaning it up along
>> the lines I'll outline here, but have not done anything about
>> it.  Care to help me out?
>
> I didn't do what you suggested, but I _did_ split the "format" up into 
> "format + line_termination", which in my opinion cleaned up part of it a 
> _lot_.

Agreed 100%.  Regardless of the further cleanup I suggested,
what you did was something I should have done in the first
place.  Thanks for the cleanup.
