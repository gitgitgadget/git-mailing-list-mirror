From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge-recursive: do not rudely die on binary merge
Date: Tue, 14 Aug 2007 17:09:05 -0700
Message-ID: <7vlkcdacbi.fsf@assigned-by-dhcp.cox.net>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	<20070814231422.GA10662@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 02:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL6Ro-00088I-Ph
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 02:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588AbXHOAJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 20:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756434AbXHOAJN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 20:09:13 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:38539 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbXHOAJM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 20:09:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070815000911.TLEU24055.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 20:09:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c09A1X00U1kojtg0000000; Tue, 14 Aug 2007 20:09:11 -0400
In-Reply-To: <20070814231422.GA10662@pe.Belkin> (Chris Shoemaker's message of
	"Tue, 14 Aug 2007 19:14:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55867>

Chris Shoemaker <c.shoemaker@cox.net> writes:

>> This changes merge-recursive to still warn but do the "binary"
>> merge for such a path; leave the "our" version in the working
>> tree, but still keep the path unmerged so that the user can sort
>> it out.
>
> Very nice.

Forgot to ask.  I did this because you had trouble on #git
yesterday and then at around the same time today somebody else
had the same issue.  Did this patch solve your problem?  I do
not think this has big risk of regression, but if it does not
help anything there is no reason to put it in 1.5.3, so I am
asking for a success report.
