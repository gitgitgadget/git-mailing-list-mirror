From: Michael Cronenworth <mike@cchtml.com>
Subject: Re: git-cvsserver strips exec bit
Date: Tue, 10 Sep 2013 17:20:13 -0500
Message-ID: <522F9B1D.3070100@cchtml.com>
References: <522F397E.6080709@cchtml.com> <xmqqa9jkzk2l.fsf@gitster.dls.corp.google.com> <xmqqfvtcxwqp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:20:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWIL-0008Ep-FT
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab3IJWUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:20:18 -0400
Received: from mta31.charter.net ([216.33.127.82]:35369 "EHLO
	mta31.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3IJWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:20:16 -0400
X-Greylist: delayed 24990 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2013 18:20:16 EDT
Received: from imp10 ([10.20.200.15]) by mta31.charter.net
          (InterMail vM.8.01.05.02 201-2260-151-103-20110920) with ESMTP
          id <20130910222015.VDSO24708.mta31.charter.net@imp10>
          for <git@vger.kernel.org>; Tue, 10 Sep 2013 18:20:15 -0400
Received: from cchtml.com ([97.93.199.156])
	by imp10 with smtp.charter.net
	id PaLE1m00h3NxN1505aLFfA; Tue, 10 Sep 2013 18:20:15 -0400
X-Authority-Analysis: v=2.0 cv=brYUnzmi c=1 sm=1
 a=lo8auXNu6Mom74z6dLD8eg==:17 a=7E2d2x4H2BEA:10 a=I_qP6JxhQSIA:10
 a=qYDZOxW1f6MA:10 a=8nJEP1OIZ-IA:10 a=XT0ipqFZAAAA:8 a=iglDd2-_o8YA:10
 a=iSzC3_11aGYC067Up_cA:9 a=wPNLvfGTeEIA:10 a=47ZmYQJ84zMA:10
 a=amCFM8iG8_MA:10 a=lo8auXNu6Mom74z6dLD8eg==:117
Received: by cchtml.com (Postfix, from userid 500)
	id ACD3B154029F; Tue, 10 Sep 2013 17:20:14 -0500 (CDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on balthasar.cchtml.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from mcronenworth.nhsrx.com (unknown [67.130.187.94])
	by cchtml.com (Postfix) with ESMTPSA id EAAB015400E8;
	Tue, 10 Sep 2013 17:20:13 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <xmqqfvtcxwqp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234493>

Junio C Hamano wrote:
> I stopped interacting with CVS quite a long time ago, so I do not
> have any way of verifying, but the fix may be just the matter of
> something like this.

This fix is close. Now all files are checked out with a mask of 555.
