From: Junio C Hamano <gitster@pobox.com>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Wed, 11 Jul 2007 14:26:09 -0700
Message-ID: <7v7ip64opa.fsf@assigned-by-dhcp.cox.net>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
	<Pine.LNX.4.64.0707110347580.4047@racer.site>
	<alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
	<7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com>
	<Pine.LNX.4.64.0707111209160.4516@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Frech <david@nimblemachines.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jiO-0007v9-Mt
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbXGKV1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758200AbXGKV1H
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:27:07 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45823 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258AbXGKV1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:27:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212614.DSGX1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMSD1X0031kojtg0000000; Wed, 11 Jul 2007 17:26:14 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52207>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I'll see what I can do. As I'm planning on running git on both FreeBSD 
>> and DragonFly for the forseeable future, and plan to track git's 
>> evolution (running stable releases if not more bleeding-edge code), I 
>> can run the test suite every time I build a new git.
>
> If you want to, I can help you setting up a nightly cron job to fetch what 
> is the current "next", run the tests, and report failures by email.

Wow.  Nightly builds of 'next' on various platforms would
actually be quite useful, especially from non Linux and non bash
world.
