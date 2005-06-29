From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] denser delta header encoding
Date: Tue, 28 Jun 2005 22:59:48 -0700
Message-ID: <7vacl9k8iz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
	<7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org>
	<7virzxk9nd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506282244110.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506290146270.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:53:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnVVB-0000RS-Bz
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVF2F7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 01:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVF2F7y
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 01:59:54 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:27811 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262436AbVF2F7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 01:59:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629055948.CGXF550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 01:59:48 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506290146270.1667@localhost.localdomain> (Nicolas Pitre's message of "Wed, 29 Jun 2005 01:49:04 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> On Tue, 28 Jun 2005, Linus Torvalds wrote:
>> 
>> 
>> On Tue, 28 Jun 2005, Junio C Hamano wrote:
>> > 
>> > OK, not too much damage done.  I'll fix the rest up.
>> 
>> Actually, I already did, and pushed out. And this time I verified it by 
>> doing a "git-cat-file -s" on every object on a packed repo.

NP> Damn!

NP> And just when I was about to send a new patch with the thing nicely 
NP> abstracted to fix the dammage.

Double Damn!!  Three people working on the same piece of code.

And Linus head still breaks with t5300.  Triple damn X-<.
