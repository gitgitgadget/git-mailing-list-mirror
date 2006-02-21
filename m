From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Mon, 20 Feb 2006 16:01:56 -0800
Message-ID: <7vlkw57f63.fsf@assigned-by-dhcp.cox.net>
References: <11404323692193-git-send-email-ryan@michonline.com>
	<20060220234054.GA7903@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 01:02:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBKyj-0003vw-QA
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 01:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWBUACC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 19:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbWBUACB
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 19:02:01 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44210 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161210AbWBUACA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 19:02:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060221000204.JOVN25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 19:02:04 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060220234054.GA7903@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 21 Feb 2006 00:40:54 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16512>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I have also been working on a blame program.

Very nice to see these two.

Obviously I prefer this one for its performance ;-).

Its interface is probably friendlier when used as a preprocessor
by other tools.  I can imagine GUI source viewer that fontifies
the source code and prefers to get just the origin information
from a "blame backend".

BTW, these days I always compile things with 

	-Wall -Wdeclaration-after-statement

which caught quite a many.

Also I have my templates/hooks--pre-commit enabled so you might
want to lindent it before inclusion.

I'll play with both a bit.  Thanks for nice toys, both of you!
