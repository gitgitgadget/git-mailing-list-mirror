From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3] gitweb: Show information about incomplete lines in commitdiff
Date: Wed, 23 Aug 2006 19:21:00 -0700
Message-ID: <7vy7teg9gz.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608240158.49908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 04:21:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG4qE-0007Q9-1W
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 04:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWHXCVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 22:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWHXCVB
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 22:21:01 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:58593 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030212AbWHXCVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 22:21:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824022100.VRWL18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 Aug 2006 22:21:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DeLz1V00Z4Noztg0000000
	Wed, 23 Aug 2006 22:21:00 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608240158.49908.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 24 Aug 2006 01:58:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25940>

Jakub Narebski <jnareb@gmail.com> writes:

> In format_diff_line, instead of skipping errors/incomplete lines,
> for example
>   "\ No newline at end of file"
> in HTML pretty-printing of diff, use "incomplete" class for div.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

I think this makes sense, while I do not see much point in
removal of git_commitdiff_plain.
