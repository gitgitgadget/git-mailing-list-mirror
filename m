From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 02:36:36 -0700
Message-ID: <7vk5xkcgkb.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	<7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140119s4691211bw8a5ef3ba25c5cbdf@mail.gmail.com>
	<7vfy88dwvw.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140207kf887738od482022497d2a63d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRPuW-00032d-MM
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030827AbXCNJgi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030824AbXCNJgi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:36:38 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41479 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030823AbXCNJgh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:36:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314093636.OLGD1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 05:36:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZcc1W00J1kojtg0000000; Wed, 14 Mar 2007 05:36:37 -0400
In-Reply-To: <81b0412b0703140207kf887738od482022497d2a63d@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 10:07:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42192>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
>> and people who have been learning from the scripts (we used to
>> have lot more scripts) would have picked up that pattern.
>> That's why I already told you that --exit-status is the right
>> thing to do if we were doing it from scratch, but is a wrong
>> thing to do at this point.  Maybe in a release as big as 1.5.0
>> that we pre-announce a lot of interface changes.
>
> This is something I don't understand: why is a new option
> --exit-code wrong?

Sorry, what I said was very confused (I sent out a
correction/clarification didn't I?).

In the ideal world we would sensibly make our diff to report
with its exit status.  Unfortunately we cannot for the above
backward compatibility worries, so a new option is an ugly
but necessary workaround.
