From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 09:37:13 -0700
Message-ID: <7vwt1jaiiu.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
	<7v6494dwms.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140701h60982fddw3ed8fa71288cb220@mail.gmail.com>
	<7v1wjrby4w.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140933v5c684aa9g1f61d61e502c6783@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 17:37:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRWTY-00043U-Ac
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 17:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXCNQhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 12:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbXCNQhQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 12:37:16 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47075 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbXCNQhP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 12:37:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314163714.SJNQ1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 12:37:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id agdD1W00r1kojtg0000000; Wed, 14 Mar 2007 12:37:14 -0400
In-Reply-To: <81b0412b0703140933v5c684aa9g1f61d61e502c6783@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 17:33:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42213>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>>         echo ... &&
>>         git add . &&
>>         {
>>                 git diff-index ...; test $? != 0
>>         }
>
> Confused. What's wrong with test_expect_failure which
> does not need any of the both ugly constructions?
> Hmm... Do you mean: "we expect successful
> operation with exit code 1"?

No.  Think what happens if you broke "git add".
