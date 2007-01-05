From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Improve cached content header of status output
Date: Fri, 05 Jan 2007 10:42:39 -0800
Message-ID: <7vk601fh7k.fsf@assigned-by-dhcp.cox.net>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
	<11677659921833-git-send-email-j.ruehle@bmiag.de>
	<459E2E57.6020503@shadowen.org>
	<7vr6u9g1l4.fsf@assigned-by-dhcp.cox.net>
	<459E4F2D.4000806@shadowen.org>
	<17822.34697.691000.253492@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 19:43:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2u1i-0007Fo-Ry
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 19:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbXAESml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 13:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbXAESml
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 13:42:41 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52948 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422647AbXAESmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 13:42:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105184240.MJRD97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 13:42:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7Whr1W00S1kojtg0000000; Fri, 05 Jan 2007 13:41:51 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17822.34697.691000.253492@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Fri, 5 Jan 2007 18:14:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36011>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> Andy Whitcroft writes:
>  > Junio C Hamano wrote:
>  > > 
>  > > Somebody did not like the verb "stage"; perhaps we can say:
>  > > 
>  > > 	# You have added changes to these files to be committed:
>  > > 	...
>  > 
>  > # These files have changes and are marked for commit:
>  > 
>  > >         # There are yet to be added changes to these files:
>  > 
>  > # These files have changes but are not marked for commit:
>
> Does this better reflect that git tracks content and not files?
>
> # Changes to these files will be committed:
>
> # Changes to these files are not marked for commit:

One of the goals is to find a pair of messages that make sense
when the same file appears on both lists.

> BTW: how about also adding a hint how to review the changes in
> question (i.e. diff --cached and diff; as an alternative to diff
> --cached we could just advertise the --verbose switch to status and
> commit).

Sounds sane.
