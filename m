From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow the ident attribute to include a length specifier
Date: Thu, 17 May 2007 12:55:25 -0700
Message-ID: <7vr6pf8bte.fsf@assigned-by-dhcp.cox.net>
References: <200705141405.29550.andyparkins@gmail.com>
	<200705171453.32093.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 21:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hom4T-0004LC-Qt
	for gcvg-git@gmane.org; Thu, 17 May 2007 21:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbXEQTz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 15:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756194AbXEQTz0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 15:55:26 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44456 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbXEQTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 15:55:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517195525.YKY13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 15:55:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 0KvR1X00F1kojtg0000000; Thu, 17 May 2007 15:55:25 -0400
In-Reply-To: <200705171453.32093.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 17 May 2007 14:53:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47551>

Andy Parkins <andyparkins@gmail.com> writes:

>> There is no change to existing behaviour.  With no parameter, the
>> expansion is all 40 hex digits.
>
> Were there any thoughts on this patch?  I think it might have got drowned in 
> the noise I made about $ident$ -> $Id$.

I was kind of hoping that I can avoid the decision and also I
can avoid having to remember it, by waiting long enough and
either seeing nobody on the list bring it up again, in which
case we can safely forget it, or somebody asks "what happened to
this, I want it too!", in which case the original submitter
would resubmit after the dust settles after 1.5.2, possibly with
a necessary rebase and clean-up.  I'll see which one is the case
in the coming few weeks ;-).
