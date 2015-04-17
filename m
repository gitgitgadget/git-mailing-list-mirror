From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git-owner, was Re: [bug] first line truncated with `git log
 --oneline --decorate --graph`
Date: Fri, 17 Apr 2015 09:14:37 +0200
Organization: gmx
Message-ID: <e50ad4a89b2a62ccc448e19321f97879@www.dscho.org>
References: <20150416.115628.1228076242478955092.davem@davemloft.net>
 <6ebf8090f8246f9880f2bd94d494c872@www.dscho.org>
 <20150416162620.GA10573@peff.net>
 <20150416.123109.141223786207291496.davem@davemloft.net>
 <ef9e69f60275dc7edb2dff8e65952630@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 09:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj0UB-0005Bf-CS
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 09:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbbDQHOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 03:14:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:58815 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbbDQHOl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 03:14:41 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lcjgd-1ZBA2T2TcF-00k6EO; Fri, 17 Apr 2015 09:14:38
 +0200
In-Reply-To: <ef9e69f60275dc7edb2dff8e65952630@www.dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ELJJqHiwrq+E0sATKHYYYm25Q65wHEjAlcLF3n0Vqtu8WApKvuc
 VqS3VN1bhWWBd7fCZlCyfOSXStIj+PO5kzAwN+4bbrDc4+Bx96GI6jvq+r5TJLUkcE2f1UY
 OLfpHxDk4j5gYlqycUsfyxXNkQeG2HXRxYl4g6LJyamdVgIzR+mYMh/Z3Y4Sr3SXhuKNq/m
 pPGaiSAIPdZgxN+XvHsZQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267348>

Hi Dave,

On 2015-04-16 19:06, Johannes Schindelin wrote:
> On 2015-04-16 18:31, David Miller wrote:
>> From: Jeff King <peff@peff.net>
>> Date: Thu, 16 Apr 2015 12:26:21 -0400
>>
>>> Weird. In a nearby thread with the same problem, the first email that
>>> mentions git-owner in a cc header is yours[1]. It's in reply to a
>>> message that does not mention git-owner at all[2], except in the
>>> "Sender" field. Your agent header looks like:
>>>
>>>   User-Agent: Roundcube Webmail/1.1.0
>>>
>>> Maybe their "reply to all" function is a little over-zealous?
>>
>> This is always caused by broken reply list handling in email clients.
> 
> That must be it. Dave, my apologies! Will investigate *right now*.

With the help of Peff, who identified the culprit (http://trac.roundcube.net/ticket/1489011 introduces this bug, but maintains to fix one), I was able to fix this on my side: https://github.com/dscho/roundcubemail/commit/baec39d

Please accept my sincerest apologies,
Johannes
