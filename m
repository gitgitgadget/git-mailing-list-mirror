From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 14:24:54 -0700
Message-ID: <7v3b2yofrt.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com>
	<7v7isbpb0p.fsf@assigned-by-dhcp.cox.net>
	<200704171235.34793.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdvAZ-0000Qk-TR
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXDQVY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbXDQVY4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:24:56 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65352 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbXDQVYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:24:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417212456.FXFU1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 17:24:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oMQu1W00v1kojtg0000000; Tue, 17 Apr 2007 17:24:55 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44830>

Andy Parkins <andyparkins@gmail.com> writes:

> On Tuesday 2007 April 17 11:09, Junio C Hamano wrote:
>
>> 	$ git checkout B
>>
>> 	should be immediate and instantaneous.
>
> Now - that's a much better argument.  However, it's not
> relevant, keywords (in other VCSs, and so why not in git) are
> only updated when a file is checked out.

It _is_ very much relevant.

If you have the keyword in your svg drawing, and if branch A and
branch B happen to have textually the same contents but the way
they got there are different, I do not think not checking it out
upon branch switching is correct.  Otherwise your printed copy
would have information from the version in branch A, even after
switching to B.
