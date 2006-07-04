From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 00:17:21 -0700
Message-ID: <7vd5cln8ji.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Jul 04 09:17:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxfA1-0000Bs-R5
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 09:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWGDHRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 03:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWGDHRX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 03:17:23 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60832 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751139AbWGDHRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 03:17:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704071722.IQQJ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 03:17:22 -0400
To: gitzilla@gmail.com
In-Reply-To: <44AA0DAE.1060308@gmail.com> (A. Large Angry's message of "Mon,
	03 Jul 2006 23:41:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23263>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Junio C Hamano wrote:
>> A Large Angry SCM <gitzilla@gmail.com> writes:
>>
>>> This demonstrates a problem with git-merge-base.
>>>  +# Setup for second test set
>>> +#
>>> +#   PL  PR
>>> +#  /  \/  \
>>> +# L2  C2  R2
>>> +# |   |   |
>>> +# L1  C1  R1
>>> +# |   |   |
>>> +# L0  C0  R0
>>> +#   \ |  /
>>> +#     S
>>...
> Not _that_ pathological in practice, given that you can't really
> depend on the timestamps in a distributed SCM.

After I looked at the timestamps you assigned to these sequences
I fully agree they are not pathological at all.  For each
"repository owner" who makes a single strand of pearls, time
seems to be flowing monotonically.

   1   1
  /  \/  \
 4  -1   4
 |   |   |
 3  -2   3
 |   |   |
 2  -3   2
   \ |  /
     0
