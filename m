From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Add the --color-words option to the diff options family
Date: Mon, 31 Jul 2006 03:54:25 -0700
Message-ID: <7vbqr66o4e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607282354450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 12:54:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7VPq-0000n3-UJ
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 12:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWGaKy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 06:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWGaKy2
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 06:54:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25037 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751030AbWGaKy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 06:54:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731105426.JXQX6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 06:54:26 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24511>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this option, the changed words are shown inline. For example,
> if a file containing "This is foo" is changed to "This is bar", the diff
> will now show "This is " in plain text, "foo" in red, and "bar" in green.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This looks sooooooooooo strange (and I do not particularly like
colours, so I am biased).  We might want to disable it when the
output would not be colored under diff.color = auto, at least,
but if the user asks to shoot himself in the foot that is fine
as well ;-).
