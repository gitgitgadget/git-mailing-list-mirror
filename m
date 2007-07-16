From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Mon, 16 Jul 2007 00:00:22 -0700
Message-ID: <7vr6n84yux.fsf@assigned-by-dhcp.cox.net>
References: <46977660.7070207@trolltech.com>
	<81b0412b0707130603q69857564i1ba418b74397a33d@mail.gmail.com>
	<200707131533.55544.simon@lst.de> <20070715024928.GY4436@spearce.org>
	<7vmyxydwld.fsf@assigned-by-dhcp.cox.net>
	<20070716053511.GC32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, Alex Riesen <raa.lkml@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 09:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAKZH-0001gB-JA
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 09:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbXGPHAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 03:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbXGPHAY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 03:00:24 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42490 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbXGPHAY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 03:00:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716070024.DIMP1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 03:00:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q70N1X0071kojtg0000000; Mon, 16 Jul 2007 03:00:23 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52647>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I'm more than happy to play patch monkey and ship them through the
> fastimport repository, but since I'm not a p4 user that offers little
> value to the process, other than perhaps to save you a little time.
>
> Simon suggested he might setup a git fork on repo.or.cz himself, at
> which point you could pull the patches for git-p4 directly from him.
>
> Simon?

Pulling from Simon sounds the sanest.

How big is the population that can help testing and cheering-on
git-p4 on this list?  If we can have git-p4 subgroup that would
be wonderful, as I do not interoperate with p4 myself.
