From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add branch test case: create "j/k" when "j" has been deleted.
Date: Wed, 20 Sep 2006 00:39:20 -0700
Message-ID: <7vy7sfkmvr.fsf@assigned-by-dhcp.cox.net>
References: <20060920070350.29039f28.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 09:39:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPwg9-0007cH-F2
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 09:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWITHjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 03:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWITHjW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 03:39:22 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52427 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751189AbWITHjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 03:39:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920073922.FIFR3535.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 Sep 2006 03:39:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QXfN1V00K1kojtg0000000
	Wed, 20 Sep 2006 03:39:23 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060920070350.29039f28.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 20 Sep 2006 07:03:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27331>

Christian Couder <chriscool@tuxfamily.org> writes:

> Linus wrote:
> "Somebody should add this test-case
>
>         git branch test
>         git branch -d test
>         git branch test/first
>
> which should work."
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

If you add this, please add its dual test as well, otherwise we
will certainly forget.
