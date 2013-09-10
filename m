From: Michael Cronenworth <mike@cchtml.com>
Subject: Re: git-cvsserver strips exec bit
Date: Tue, 10 Sep 2013 17:22:54 -0500
Message-ID: <522F9BBE.404@cchtml.com>
References: <522F397E.6080709@cchtml.com> <xmqqa9jkzk2l.fsf@gitster.dls.corp.google.com> <xmqqfvtcxwqp.fsf@gitster.dls.corp.google.com> <522F9B1D.3070100@cchtml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWKr-0003LV-Ho
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3IJWW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:22:57 -0400
Received: from mta31.charter.net ([216.33.127.82]:38050 "EHLO
	mta31.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3IJWW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:22:57 -0400
Received: from imp11 ([10.20.200.11]) by mta31.charter.net
          (InterMail vM.8.01.05.02 201-2260-151-103-20110920) with ESMTP
          id <20130910222256.VESR24708.mta31.charter.net@imp11>
          for <git@vger.kernel.org>; Tue, 10 Sep 2013 18:22:56 -0400
Received: from cchtml.com ([97.93.199.156])
	by imp11 with smtp.charter.net
	id PaNw1m00C3NxN1505aNwl3; Tue, 10 Sep 2013 18:22:56 -0400
X-Authority-Analysis: v=2.0 cv=KYGKKnkD c=1 sm=1
 a=lo8auXNu6Mom74z6dLD8eg==:17 a=7E2d2x4H2BEA:10 a=I_qP6JxhQSIA:10
 a=qYDZOxW1f6MA:10 a=8nJEP1OIZ-IA:10 a=XT0ipqFZAAAA:8 a=iglDd2-_o8YA:10
 a=ijTWprrPGZSKuHzZIjkA:9 a=wPNLvfGTeEIA:10 a=moN3lsw9FiQA:10
 a=WfG7X66XhFoA:10 a=lo8auXNu6Mom74z6dLD8eg==:117
Received: by cchtml.com (Postfix, from userid 500)
	id 0AAC4154029F; Tue, 10 Sep 2013 17:22:55 -0500 (CDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on balthasar.cchtml.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from mcronenworth.nhsrx.com (unknown [67.130.187.94])
	by cchtml.com (Postfix) with ESMTPSA id 5271C15400E8;
	Tue, 10 Sep 2013 17:22:55 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <522F9B1D.3070100@cchtml.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234494>

Michael Cronenworth wrote:
> This fix is close. Now all files are checked out with a mask of 555.

Let me clarify.

Git mask 755 => CVS mask 555
Git mask 644 => CVS mask 444

Thanks,
Michael
