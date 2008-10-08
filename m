From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git and tagging hook
Date: Wed, 08 Oct 2008 19:40:02 +0200
Message-ID: <48ECF072.3000506@op5.se>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se>	 <1223399613.20250.1.camel@localhost>  <gcg67d$4o2$1@ger.gmane.org> <1223484445.4055.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Kristis Makris <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Wed Oct 08 19:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knd2K-0001KV-GO
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 19:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbYJHRkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbYJHRkN
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 13:40:13 -0400
Received: from mail.op5.se ([193.201.96.20]:37822 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbYJHRkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 13:40:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B550E1B800F5;
	Wed,  8 Oct 2008 19:32:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.655
X-Spam-Level: 
X-Spam-Status: No, score=-2.655 tagged_above=-10 required=6.6
	tests=[AWL=-0.156, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKW3gxlKXoPK; Wed,  8 Oct 2008 19:32:15 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id CAFED1B800AF;
	Wed,  8 Oct 2008 19:32:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1223484445.4055.8.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97805>

Kristis Makris wrote:
> On Tue, 2008-10-07 at 19:28 +0200, Jakub Narebski wrote:
>> Kristis Makris wrote:
>>
>>> But the post-receive is NOT executed when I apply a tag.
>>>
>>> I want the integration when I apply the tag to a local repository, NOT
>>> only when I push/pull.
>> If you are talking about taging locally, you can simply make an alias
>> or do something after tagging. Search archives for description when
>> it is worth to add a hook, and when it is not.
> 
> I am looking for a guarantee that is better than casually saying
> "simply". I will be providing the integration work to users that may not
> be as comfortable with making aliases. 
> 
> I still don't see why a hook on local tagging is not available. Is it
> possible to add support in Git for such a hook ? Both pre-tag and
> post-tag.

Because noone's ever needed one before. If aliases can't do what you
want, write a patch to support it and hope Junio accepts it. It's really
quite straight-forward. Make sure you read Documentation/SubmittingPatches
before you send it.

Note though that use of tags on the developer's side will still be up
to the developer and not something you can force through other means
than policy or convention.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
