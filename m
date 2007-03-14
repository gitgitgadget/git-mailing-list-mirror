From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 14 Mar 2007 04:27:21 -0700
Message-ID: <7vbqiwawva.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	<7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
	<7vhcsphqtk.fsf@assigned-by-dhcp.cox.net>
	<8aa486160703131614i1b67e6c3vf7ccf395d63573b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Paolo Bonzini" <paolo.bonzini@lu.unisi.ch>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 12:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRRde-0004gu-Rh
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 12:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbXCNL1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Mar 2007 07:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbXCNL1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 07:27:24 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40271 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161149AbXCNL1X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2007 07:27:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314112722.CVYK3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 07:27:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id abTN1W00B1kojtg0000000; Wed, 14 Mar 2007 07:27:22 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42199>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

>> I tried the "NULL fetch between 1000-refs repositories" test,
>> which prompted the git-fetch--tool work that was done on
>> jc/fetch topic in 'next', with the following versions:
>>
>>  (1) 1.5.0 (without any git-fetch--tool optimization)
>>  (2) master (ditto)
>>  (3) master with jc/fetch (but not sb/fetch topic)
>>  (4) next ((3) plus sb/fetch and others)
>>
>> The test scripts are at the end of this message.  Both (1) and
>> (2) take 3 minutes 7 seconds wallclock time.  (3) improves it
>> down to 15 seconds.  (4) makes the operation spend 24 seconds
>> (the times are all on my primary machine x86-64 with 1GB, hot
>> cache and average of three runs each).
>
> I think it is not fair,...

That's a very unexpected response.  I personally do not think
the separation of FETCH_FETCHED made improvements to the code,
but the above numbers do not have anything to do with such
perhaps subjective ascetic judgement.

The comparison showed that the "Split" patch is a step backward
from the existing optimization hack that was specifically made
to solve an issue raised on the list, and you may not like the
numbers, but if you call that is "not fair", I do not know what
could be considered fair.

Yes, life is unfair, but I do not think that word applies to
this particular case.
