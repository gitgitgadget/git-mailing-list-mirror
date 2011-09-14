From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t0300-credentials: poll failed: invalid argument
Date: Wed, 14 Sep 2011 10:24:01 -0400
Message-ID: <C9FED2AA-15CB-4850-B3DA-F4FC12F06EB4@silverinsanity.com>
References: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com> <20110829174309.GA11524@sigill.intra.peff.net> <201109091613.13137.trast@student.ethz.ch> <201109141015.58333.trast@student.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 14 16:24:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3qNt-0001sL-Fc
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 16:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab1INOYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 10:24:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49675 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1INOYL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 10:24:11 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 536421FFC166; Wed, 14 Sep 2011 14:24:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [129.21.210.224] (bcg2784.student.rit.edu [129.21.210.224])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id DEE441FFC100;
	Wed, 14 Sep 2011 14:23:59 +0000 (UTC)
In-Reply-To: <201109141015.58333.trast@student.ethz.ch>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181360>


On Sep 14, 2011, at 4:15 AM, Thomas Rast wrote:

> Thomas Rast wrote:
>>  $ uname -a
>>  Darwin mackeller.inf.ethz.ch 11.1.0 Darwin Kernel Version 11.1.0: Tue Jul 26 16:07:11 PDT 2011; root:xnu-1699.22.81~1/RELEASE_X86_64 x86_64
> [...]
>>  --- expect-stderr       2011-09-09 14:12:13.000000000 +0000
>>  +++ stderr      2011-09-09 14:12:13.000000000 +0000
>>  @@ -1,2 +1,3 @@
>>   askpass: Username:
>>   askpass: Password:
>>  +fatal: poll failed: Invalid argument
>> 
>> for each of the tests 15--19.  Is it supposed to be fixed?
> 
> Ping?

Jeff's patch did fix this for me, but it never appears to have made it into git.git.  He mentioned something about re-rolling it along with some other fixes...  *hint, hint*

~~ Brian
