From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-checkout: Don't tell user that HEAD has moved before it has
Date: Sat, 16 May 2009 12:57:44 -0700
Message-ID: <7vr5yolt1j.fsf@alter.siamese.dyndns.org>
References: <20090516192531.6117@nanako3.lavabit.com>
	<20090516175444.GA1000@cumin.applehq.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Daniel Cordero <theappleman@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 21:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Q14-0002cT-5H
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbZEPT5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbZEPT5o
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:57:44 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43016 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbZEPT5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:57:43 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516195743.JZLH20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Sat, 16 May 2009 15:57:43 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id sKxk1b0074aMwMQ04KxkDD; Sat, 16 May 2009 15:57:44 -0400
X-Authority-Analysis: v=1.0 c=1 a=vBRyrRn4i_kA:10 a=wsqUAQMUkPEA:10
 a=pGLkceISAAAA:8 a=pD9OhsPJ_acKGGFgXIYA:9 a=2GOI8zMD7DvI_hIewW1EXkcsYosA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119380>

Daniel Cordero <theappleman@gmail.com> writes:

> Previously, checkout would tell the user this message before moving HEAD,
> without regard to whether the upcoming move will result in success.
> If the move failed, this causes confusion.
>
> Show the message after the move, unless the move failed.
>
> Signed-off-by: Daniel Cordero <theappleman@gmail.com>

Thanks; the patch looks obviously good.  Can we have tests?
