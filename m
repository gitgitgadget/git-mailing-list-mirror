From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Sat, 14 Jul 2007 23:12:14 -0700
Message-ID: <7vmyxydwld.fsf@assigned-by-dhcp.cox.net>
References: <46977660.7070207@trolltech.com>
	<81b0412b0707130603q69857564i1ba418b74397a33d@mail.gmail.com>
	<200707131533.55544.simon@lst.de> <20070715024928.GY4436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, Alex Riesen <raa.lkml@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 08:12:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9xLL-0006gL-5o
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 08:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbXGOGM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 02:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbXGOGM2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 02:12:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43351 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbXGOGMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 02:12:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070715061215.IWOJ1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 02:12:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PiCE1X00Q1kojtg0000000; Sun, 15 Jul 2007 02:12:15 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52527>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Thanks.  Marius' patch was whitespace damaged in the context lines,
> but it was easily repaired.  I've got a couple of other small items
> in my fastimport repository that I'm going to ask Junio to include
> in 1.5.3 shortly.

Thanks for taking care of this.  I have pulled gfi master into
'master'.  Perhaps we would want to tag -rc2 this weekend, run
with it for a week or so and see if we need -rc3 before the
final.
