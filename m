From: Junio C Hamano <junkio@cox.net>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Thu, 05 Apr 2007 03:24:28 -0700
Message-ID: <7vwt0rqftv.fsf@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	<7vircbwfym.fsf@assigned-by-dhcp.cox.net>
	<87y7l7tc4j.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Apr 05 12:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZP8s-000135-3x
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 12:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966070AbXDEKYb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Apr 2007 06:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966072AbXDEKYb
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 06:24:31 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33009 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966070AbXDEKYa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2007 06:24:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405102430.BQUH25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 06:24:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jNQV1W00J1kojtg0000000; Thu, 05 Apr 2007 06:24:29 -0400
In-Reply-To: <87y7l7tc4j.fsf@morpheus.local> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of
	"Thu, 05 Apr 2007 11:16:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43814>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> I think we should be able to use --left-right and ... operator
>> to express what the above cherry does with something like:
>>
>>     $ git log --left-right --ignore-common-patch cvs-upstream...my-b=
ranch
>
> --left-right is not documented, so I think it's hard for people (for
> me at least) to follow your reasoning.
>
> Would it be to much to ask for to want to have all options have some
> kind of documentation?

Not at all.  I often wish that ;-)

> As in not accepting patches for new options
> that don't include documentation?
>
> "git log -Sleft-right" will actually give me the documentation I want=
,
> since the docs are written but only put in the commit message.

=46air enough.  Perhaps the list can help out ;-).
