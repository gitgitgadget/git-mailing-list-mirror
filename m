From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] make filepairs detachable
Date: Thu, 29 Jun 2006 18:16:10 -0700
Message-ID: <7vy7vfmoit.fsf@assigned-by-dhcp.cox.net>
References: <20060630002736.GB22618@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 30 03:16:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw7cF-0005Ev-Is
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 03:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWF3BQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 21:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWF3BQM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 21:16:12 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56518 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751381AbWF3BQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 21:16:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630011611.SVON12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 21:16:11 -0400
To: fork0@t-online.de (Alex Riesen)
In-Reply-To: <20060630002736.GB22618@steel.home> (Alex Riesen's message of
	"Fri, 30 Jun 2006 02:27:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22940>

fork0@t-online.de (Alex Riesen) writes:

> Actually, just make sure diff_flush does not crash for diff queue
> entries which were cleared.

Somehow I really feel uneasy about this one.  I think it is the
responsibility of the one who mangles the queue to adjust the
entries and count consistent.
