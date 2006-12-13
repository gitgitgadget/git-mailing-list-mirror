X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] runstatus: restructure visual appearance
Date: Tue, 12 Dec 2006 16:46:20 -0800
Message-ID: <7v3b7koc6b.fsf@assigned-by-dhcp.cox.net>
References: <11650882251452-git-send-email-hjemli@gmail.com>
	<8c5c35580612120330n36bcdd00p57b2a7cd1d6c801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 00:46:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34173>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuIGQ-0006aX-0t for gcvg-git@gmane.org; Wed, 13 Dec
 2006 01:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964848AbWLMAqW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 19:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWLMAqW
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 19:46:22 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32987 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964848AbWLMAqW (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 19:46:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213004621.SZMT25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 19:46:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id y0mY1V0051kojtg0000000; Tue, 12 Dec 2006
 19:46:32 -0500
To: "Lars Hjemli" <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 12/2/06, Lars Hjemli <hjemli@gmail.com> wrote:
>> This is a rather subjective 'improvement', but I think it makes the commit
>> message easier to comprehend and I hope that goes for both new and
>> experienced users.
>
> Just wondering if this patch got dropped or simply overlooked...

I looked at the patch, and I was neutral to slightly negative
(but only slightly.  I thought M vs M+ was too subtle and
cryptic until the user gets used to them).

I however did not see overwhelming support from the list, so I
did not further think about it.

One thing that was mentioned in the past on the list about the
output from git-status was that we do not make mode changes
stand out, and people can mistakenly do something silly to
change the -x bit and the current git-status would only say:

	modified:	git-foobar.sh

which would not help them notice the mistake, as a result,
accidental mode change can get committed.

If we are designing a new format to make git-status output more
compact and easier to understand, I think it should also attempt
to address this problem as well.
