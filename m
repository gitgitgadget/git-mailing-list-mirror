From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix zebra coloring flip introduced by eeef88cd2
Date: Tue, 10 Oct 2006 21:45:36 -0700
Message-ID: <7vk637xxxr.fsf@assigned-by-dhcp.cox.net>
References: <20061011020903.63831.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 06:45:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXVyP-0003UO-DX
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 06:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030789AbWJKEpi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 00:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030790AbWJKEpi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 00:45:38 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56301 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030789AbWJKEph (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 00:45:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011044537.KKPZ16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 00:45:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yslf1V00r1kojtg0000000
	Wed, 11 Oct 2006 00:45:40 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061011020903.63831.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 10 Oct 2006 19:09:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28692>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Commit eeef88cd2 introduced $group_size which
> inverted the meaning of $current_color.
>
> Normally we start with white (same as background) color
> for the zebra coloring, and flip to dark shade only when
> another commit changed some lines of the file.  (Thus
> if there are no changes, the file appears black on white.)

I do not have much preference either way, but it was done more
or less deliberately to match what you did with 6dd36ac.
