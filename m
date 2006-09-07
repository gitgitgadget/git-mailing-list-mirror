From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach rev-list an option to read revs from the standard input.
Date: Thu, 07 Sep 2006 02:07:17 -0700
Message-ID: <7virk02gfu.fsf@assigned-by-dhcp.cox.net>
References: <7v64g1a9f7.fsf@assigned-by-dhcp.cox.net>
	<44FEBFD6.10709@shadowen.org>
	<7vhczk5wup.fsf@assigned-by-dhcp.cox.net>
	<44FFD436.4020407@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 11:07:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFqp-0007nF-LQ
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 11:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWIGJHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 05:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWIGJHH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 05:07:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63923 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751317AbWIGJHE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 05:07:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907090704.GCWU21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 05:07:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KM6w1V00Y1kojtg0000000
	Thu, 07 Sep 2006 05:06:57 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <44FFD436.4020407@shadowen.org> (Andy Whitcroft's message of
	"Thu, 07 Sep 2006 09:11:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26620>

Andy Whitcroft <apw@shadowen.org> writes:

> There was white space breakage in the patch which I noticed late in the
> game, and a problem with the printing lacking newlines.  Your conversion
> to direct writes on the fd fixes the bug part.
>
> What you have on 'pu' looks good to me.
>
> /me wasn't aware of the meaning of the pu branch :)

Thanks.  Will merge into "next" with a plan to have it graduate
to master by next week.
