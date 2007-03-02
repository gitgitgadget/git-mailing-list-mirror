From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Fri, 02 Mar 2007 02:03:25 -0800
Message-ID: <7vejo8ezde.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87y7mhrnrc.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87hct4roqa.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4bq-0005IQ-5L
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbXCBKD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422996AbXCBKD1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:03:27 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62861 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422992AbXCBKD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 05:03:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302100326.OHXZ3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 05:03:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vm3R1W0021kojtg0000000; Fri, 02 Mar 2007 05:03:26 -0500
In-Reply-To: <87hct4roqa.fsf@latte.josefsson.org> (Simon Josefsson's message
	of "Fri, 02 Mar 2007 10:14:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41178>

Simon Josefsson <simon@josefsson.org> writes:

> The problem here is that CVS insert '*** empty log message ***' when
> you didn't supply a log message, and doing something intelligent with
> such logs would be useful.

If that is indeed the case then I suspect that cvs-to-git
conversion should know about it and strip the artificial
string.

In any case, as I already said a few times in this thread, I
think what you did is the right approach --- to read from "git
log --numstat" output and format the output to match the precise
detail of your project's liking with an external script.

> But I want more than the oneline comment in the ChangeLog?  There is
> no size limit on ChangeLog messages, and having as much information as
> possible available is better.

I think this was purely underspecification when your request was
passed to Johannes.

I've merged Johannes's gnucl series to 'next' but haven't pushed
out, so I'll revert it.
