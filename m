From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Move code resolving packed refs into its own function.
Date: Sat, 30 Sep 2006 13:33:10 -0700
Message-ID: <7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 22:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTlWO-0004l1-1p
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 22:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWI3UdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWI3UdN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 16:33:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52892 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751120AbWI3UdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 16:33:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930203311.ENOP6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 16:33:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UkZD1V0021kojtg0000000
	Sat, 30 Sep 2006 16:33:14 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060930220158.d331bb7c.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 30 Sep 2006 22:01:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28152>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch move Linus' packed refs resolving code from
> "resolve_ref" into a new "resolve_packed_ref" extern
> function so that it can be reused when needed.

I think we are stepping on each other's toes.  How far into the
process of making correct branch deletion are you?
