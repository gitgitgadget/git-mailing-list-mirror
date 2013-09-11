From: Michael Cronenworth <mike@cchtml.com>
Subject: Re: git-cvsserver strips exec bit
Date: Wed, 11 Sep 2013 08:12:58 -0500
Message-ID: <52306C5A.7070507@cchtml.com>
References: <522F397E.6080709@cchtml.com> <xmqqa9jkzk2l.fsf@gitster.dls.corp.google.com> <xmqqfvtcxwqp.fsf@gitster.dls.corp.google.com> <522F9B1D.3070100@cchtml.com> <522F9BBE.404@cchtml.com> <xmqqtxhsux25.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 15:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJkEH-0001T9-2U
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 15:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab3IKNNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 09:13:04 -0400
Received: from mta11.charter.net ([216.33.127.80]:44590 "EHLO
	mta11.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab3IKNND (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 09:13:03 -0400
Received: from imp11 ([10.20.200.11]) by mta11.charter.net
          (InterMail vM.8.01.05.09 201-2260-151-124-20120717) with ESMTP
          id <20130911131301.DZIO6169.mta11.charter.net@imp11>
          for <git@vger.kernel.org>; Wed, 11 Sep 2013 09:13:01 -0400
Received: from cchtml.com ([97.93.199.156])
	by imp11 with smtp.charter.net
	id PpCz1m00U3NxN1505pD0mJ; Wed, 11 Sep 2013 09:13:01 -0400
X-Authority-Analysis: v=2.0 cv=KYGKKnkD c=1 sm=1
 a=lo8auXNu6Mom74z6dLD8eg==:17 a=7E2d2x4H2BEA:10 a=I_qP6JxhQSIA:10
 a=qYDZOxW1f6MA:10 a=8nJEP1OIZ-IA:10 a=XT0ipqFZAAAA:8 a=iglDd2-_o8YA:10
 a=R_YDzTTKVMJ4-2TEB7QA:9 a=wPNLvfGTeEIA:10 a=lo8auXNu6Mom74z6dLD8eg==:117
Received: by cchtml.com (Postfix, from userid 500)
	id BB61215402A3; Wed, 11 Sep 2013 08:12:59 -0500 (CDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on balthasar.cchtml.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from mcronenworth.nhsrx.com (unknown [67.130.187.94])
	by cchtml.com (Postfix) with ESMTPSA id 9486E154029F;
	Wed, 11 Sep 2013 08:12:58 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <xmqqtxhsux25.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234564>

Junio C Hamano wrote:
> Then what I wrote was actually relevant;-)
>
>      I am not sure if we want to use the owner bit (i.e. 4th place)
>      instead of the other bit (i.e. the last place) like this patch does,
>      though.  The old code in 1.8.1.x would have produced either "r" (for
>      100644) or "wx" (for 100755); I think that the result of applying
>      this patch would give us "r" (for 100644) or "rx" (for 100755).
>
> This should then work, I would think.

Yes, this new patch fixes the issue.

Thanks!
Michael
