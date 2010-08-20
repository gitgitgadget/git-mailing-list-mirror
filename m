From: Richard MICHAEL <rmichael@leadformance.com>
Subject: Re: git-filter-branch : LANG / LC_ALL = C breaks UTF-8 author names
Date: Fri, 20 Aug 2010 15:44:10 +0200
Message-ID: <4C6E86AA.2020903@leadformance.com>
References: <4C6E8109.5030202@leadformance.com> <20100820133244.GB15736@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRtR-0004tR-2f
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab0HTNoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:44:15 -0400
Received: from office01.leadformance.com ([88.191.95.206]:41961 "EHLO
	office01.leadformance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab0HTNoN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:44:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by office01.leadformance.com (Postfix) with ESMTP id 4D2854E002;
	Fri, 20 Aug 2010 15:44:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at leadformance.com
Received: from office01.leadformance.com ([127.0.0.1])
	by localhost (office01.leadformance.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iDSP6QODa2hp; Fri, 20 Aug 2010 15:44:11 +0200 (CEST)
Received: from aluminum.local (lns-bzn-51f-62-147-243-253.adsl.proxad.net [62.147.243.253])
	by office01.leadformance.com (Postfix) with ESMTPSA id 85C6A4E001;
	Fri, 20 Aug 2010 15:44:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <20100820133244.GB15736@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154038>

  On 10-08-20 3:32 PM, Jonathan Nieder wrote:
> Richard MICHAEL wrote:
>
>> I am filtering our repo with git-filter-branch, but as the sed
>> script runs with LANG=C LC_ALL=C (7 bit US ASCII), it dies on
>> commits authored by our team members with accented names.
> Yep, someone else recently sent a report about such a sed version,
> too.  It is breaking our fragile minds; we ought to find some way to
> deal with it, but we haven't yet.
>
> Jonathan

Jonathan, thanks for your reply.

What about special casing the bad sed (or whitelisting good sed)?  
Surely a hack, but would those of us with GNU or BSD would be happy.  
Which was the troublesome sed?

That opposed to figuring out the problem, reading about unicode, and 
re-cloning and re-filtering 5,000 commits. :-)  Unfortunately, it 
doesn't "die" well either; the 'export' shell var fails but it keeps 
processing commits.  (If I hadn't investigated and changed the LANG, 
would I have lost those commits?)

Regards,
Richard
