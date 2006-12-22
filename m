From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-commit-tree: if i18n.commitencoding is utf-8 (default), check it
Date: Fri, 22 Dec 2006 13:50:54 -0800
Message-ID: <7vy7ozwqf5.fsf@assigned-by-dhcp.cox.net>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	<20061221085907.GA2244@cepheus>
	<Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612211623.14236.litvinov2004@gmail.com>
	<7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612221030440.18171@xanadu.home>
	<7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612222204010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:51:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxsID-0003ob-RM
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbWLVVu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbWLVVu4
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:50:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38733 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbWLVVu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:50:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222215055.KOLE2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 16:50:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1xqC1W00M1kojtg0000000; Fri, 22 Dec 2006 16:50:13 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612222204010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 22 Dec 2006 22:06:08 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35227>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, git-commit-tree refuses to commit when i18n.commitencoding is
> either unset, or set to "utf-8", and the commit message does not
> minimally conform to the UTF-8 encoding.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>
> 	Unfortunately, I could not think of a shorter oneline description. 
> 	But my next patch fixes at least the output in shortlog.

I think the rule that you described on the one-line description
makes more sense than "either unset of set to utf-8".  In other
words, I'd prefer doing this in a repository that explicitly
asks for it.

I do not want to get burned by too many incompatible changes X-<.
