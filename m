From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 15:24:07 -0700
Message-ID: <7viripkwag.fsf@assigned-by-dhcp.cox.net>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
	<7vlknlmc9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:39:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8yL-0003Dp-8o
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWJLWYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWJLWYK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:24:10 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:9460 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751208AbWJLWYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:24:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012222408.RWWN12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 18:24:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZaPx1V00J1kojtg0000000
	Thu, 12 Oct 2006 18:23:57 -0400
To: Alexei Podtelezhnikov <apodtele@gmail.com>
In-Reply-To: <7vlknlmc9y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Oct 2006 14:53:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28811>

Junio C Hamano <junkio@cox.net> writes:

> Missing e-mail address on S-o-b line.  If your mail From: line
> does not say who you are, please add an extra From: line in the
> body, like this:
>
> 	From: Alexei Podtelezhnikov <apodtele@gmail.com>
>         Subject: [PATCH 1/2] diff --stat: ...
>
>         Instead of ...
>
> 	Signed-off-by: Alexei Podtelezhnikov <apodtele@gmail.com>

Eh, no.

Sorry, what I meant was:

Not like this:

        From: apodtele <apodtele@gmail.com>
        Subject: [PATCH 1/2] diff --stat: ...

        Instead of ...

        Signed-off-by: Alexei Podtelezhnikov

But like this:

        From: apodtele <apodtele@gmail.com>
        Subject: [PATCH 1/2] diff --stat: ...

        From: Alexei Podtelezhnikov <apodtele@gmail.com>

        Instead of ...

        Signed-off-by: Alexei Podtelezhnikov <apodtele@gmail.com>
