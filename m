From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] Quoting paths in tests
Date: Mon, 15 Oct 2007 16:17:45 +0200
Message-ID: <47137689.9050907@viscovery.net>
References: <4711486B.1050301@op5.se> <11924540291536-git-send-email-maillist@steelskies.com> <47136F71.1050107@viscovery.net> <8977E4C2-2C13-4C52-8FD9-CEEB5AA85B70@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 16:36:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQlZ-0000uB-8q
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbXJOORt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 10:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758228AbXJOORs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:17:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22429 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbXJOORr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:17:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhQlC-0007Zn-T2; Mon, 15 Oct 2007 16:17:35 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8408169F; Mon, 15 Oct 2007 16:17:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <8977E4C2-2C13-4C52-8FD9-CEEB5AA85B70@steelskies.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61000>

Jonathan del Strother schrieb:
> On 15 Oct 2007, at 14:47, Johannes Sixt wrote:
>> I don't see the point in changing an incorrect quoting to a different 
>> incorrect quoting that you fix up in a follow-up patch. It's *two* 
>> large patches to review instead of just one. I'm stopping the review 
>> here.
> 
> If we want to support apostrophed paths in tests,

I could ask, "if we want to support paths with blanks in tests", so...

> I'll flatten 2 & 3 
> into a single patch.  I thought I'd make the apostrophe part optional 
> since there seemed to be some resistance to having to bother about 
> quoting & escaping in tests..

You could also make a patch that reverses the quoting in t9100-* (and 
probably others), i.e. instead of

	"... '$foo'..." (which is incorrect)
or
	"... \"$foo\"..."
make it
	'... "$foo" ...'

It will be a large patch, too, but the result should be easier to read.

-- Hannes
