From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/5] RFC: for_each_revision() helper
Date: Fri, 27 Apr 2007 10:13:40 -0700
Message-ID: <7vr6q5oi4b.fsf@assigned-by-dhcp.cox.net>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
	<7vr6q6svkc.fsf@assigned-by-dhcp.cox.net>
	<20070426181420.4db235cc@localhost>
	<7vk5vysufp.fsf@assigned-by-dhcp.cox.net>
	<20070427102113.46869367@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Fri Apr 27 19:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhU3Q-0000Oq-UN
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbXD0RNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756665AbXD0RNo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:13:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49766 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756302AbXD0RNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 13:13:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427171342.ZNRI1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 13:13:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sHDg1W00C1kojtg0000000; Fri, 27 Apr 2007 13:13:41 -0400
In-Reply-To: <20070427102113.46869367@localhost> (Luiz Fernando
	N. Capitulino's message of "Fri, 27 Apr 2007 10:21:13 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45736>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

>  BTW, Robin, can we have an option to read the introductory e-mail
> from a file? It could read a Subject line from it too.

Without adding any new option, I think you can do that today.

	$ git format-patch -o ./+outgo -n master..jc/my-series
	$ edit ./+outgo/0000-cover.txt
        $ git send-email [options] ./+outgo
