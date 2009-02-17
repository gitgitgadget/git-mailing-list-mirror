From: Andreas Ericsson <ae@op5.se>
Subject: Re: send-email sending shallow threads by default
Date: Tue, 17 Feb 2009 09:34:35 +0100
Message-ID: <499A769B.2080308@op5.se>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net> <mj+md-20090216.103512.5791.nikam@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Mares <mj@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLR3-00067x-Ow
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZBQIem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbZBQIel
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:34:41 -0500
Received: from mail.op5.se ([193.201.96.20]:35892 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbZBQIel (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:34:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 31DF424B0002;
	Tue, 17 Feb 2009 09:36:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmLAFO4DZW3Q; Tue, 17 Feb 2009 09:36:33 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 0956A1B8182B;
	Tue, 17 Feb 2009 09:36:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <mj+md-20090216.103512.5791.nikam@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110332>

Martin Mares wrote:
> Hello, world!\n
> 
>> Is that the case? mutt at least orders by thread, but by rfc822 date
>> within a single level of thread. So as long as the date fields (set by
>> the sender) are correct, it looks right no matter what order they arrive in.
> 
> Actually, it matters, because the Date field has limited precision
> and it frequently happens that the sender produces several mails
> within a single second.
> 

There's no need to have the date field be set to the time the mails were
actually sent though. AFAIR, they get the AUTHOR_DATE now, and I doubt more
than one commit can be authored every second.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
