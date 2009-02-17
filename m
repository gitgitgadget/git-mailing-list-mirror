From: Andreas Ericsson <ae@op5.se>
Subject: Re: send-email sending shallow threads by default
Date: Tue, 17 Feb 2009 09:30:40 +0100
Message-ID: <499A75B0.5050600@op5.se>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLNN-0005CF-4N
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbZBQIat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZBQIat
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:30:49 -0500
Received: from mail.op5.se ([193.201.96.20]:35413 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbZBQIas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:30:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E7B1924B0002;
	Tue, 17 Feb 2009 09:32:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODQZHk8k0e7Y; Tue, 17 Feb 2009 09:32:39 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E9E6C1B8010D;
	Tue, 17 Feb 2009 09:32:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090216000732.GC3503@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110330>

Jeff King wrote:
> On Sun, Feb 15, 2009 at 03:53:50PM -0800, david@lang.hm wrote:
> 
>>> * git-send-email won't make deep threads by default
>>>
>>>  Many people said that by default when sending more than 2 patches the
>>>  threading git-send-email makes by default is hard to read, and they
>>>  prefer the default be one cover letter and each patch as a direct
>>>  follow-up to the cover letter.
>>>
>>>  http://article.gmane.org/gmane.comp.version-control.git/109790
>> I have mixed feelings about this one, if some messages get delayed in  
>> transit the deep threads still keeps them in order, while the 2-layer  
>> option doesn't.
> 
> Is that the case? mutt at least orders by thread, but by rfc822 date
> within a single level of thread. So as long as the date fields (set by
> the sender) are correct, it looks right no matter what order they arrive
> in.
> 
> Are there common readers that thread but do not order by date?
> 

Thunderbird does it. I haven't found an option to sort by "date sent"
inside threads, .

FWIW, I like this change either way. Deep threading is nice for up to
five or so patches. After that it becomes messy. Shallow threading
simply scales much better, so it's easier to be consistent if that's
the default.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
