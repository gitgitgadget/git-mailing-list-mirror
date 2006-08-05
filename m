From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 05 Aug 2006 04:27:46 -0700
Message-ID: <7vac6je825.fsf@assigned-by-dhcp.cox.net>
References: <20060805031418.GA11102@coredump.intra.peff.net>
	<20060805105953.GA5410@moooo.ath.cx>
	<7vejvve8ci.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 13:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KJr-0004N5-5O
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWHEL1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWHEL1s
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:27:48 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31380 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932483AbWHEL1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 07:27:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805112747.LUTS6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 07:27:47 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <7vejvve8ci.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 05 Aug 2006 04:21:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24909>

Junio C Hamano <junkio@cox.net> writes:

>> Is there any way to do isatty() from shell scripts?
>
> Yes.

Oops -- wrong answer which is too short.

$ git grep -B1 'standard input' -- '*.sh'
