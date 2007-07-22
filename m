From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid to duplicate commit message when is not encoded
Date: Sun, 22 Jul 2007 02:17:47 -0700
Message-ID: <7v4pjwssp0.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707220123g5826cbf5n3e2ff7256d9b5366@mail.gmail.com>
	<20070722085225.GB3408@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 11:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICXZg-0005GU-WE
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 11:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762413AbXGVJRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 05:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764804AbXGVJRw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 05:17:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36213 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764767AbXGVJRs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 05:17:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722091749.LKSQ1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 05:17:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SZHn1X00M1kojtg0000000; Sun, 22 Jul 2007 05:17:48 -0400
In-Reply-To: <20070722085225.GB3408@steel.home> (Alex Riesen's message of
	"Sun, 22 Jul 2007 10:52:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53242>

Alex Riesen <raa.lkml@gmail.com> writes:

> Marco Costalba, Sun, Jul 22, 2007 10:23:05 +0200:
>> +		if (encoding) // we'll strip encoding header later
>
> You better avoid using C++ comments, not all C compilers support them.

I've "fixed" them.

>> +		else
>> +			return NULL; // nothing to do
>
> And you better avoid such useless comments too

I think this one is probably a good-to-have.  It really needs a
bit of thinking why there is nothing to do in this case.  At
least for me it did ;-)
