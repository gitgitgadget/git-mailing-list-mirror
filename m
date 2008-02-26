From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
 threads for packing
Date: Tue, 26 Feb 2008 10:40:03 +0100
Message-ID: <47C3DE73.2030507@op5.se>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net> <7vhcfwb116.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 10:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTwIu-00009v-5I
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 10:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbYBZJkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757831AbYBZJkP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 04:40:15 -0500
Received: from mail.op5.se ([193.201.96.20]:49445 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473AbYBZJkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 04:40:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 02DE01F082F4;
	Tue, 26 Feb 2008 10:40:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLkd9KPXO9Ct; Tue, 26 Feb 2008 10:40:07 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 3EA7B1F0802C;
	Tue, 26 Feb 2008 10:40:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vhcfwb116.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75117>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Fri, Feb 22, 2008 at 08:12:58PM -0600, Brandon Casey wrote:
>>
>>> +	if (progress)
>>> +		fprintf(stderr, "Using %d pack threads.\n",
>>> +			delta_search_threads);
>> I just noticed that this was in next.
> 
> Please send in a fix-up patch to remove it.  I noticed it while
> reviewing the patch, and even commented on it, but I somehow
> forgot that this leftover debugging message disqualified the
> series from 'next' when I was merging topics to 'next'.

FWIW, it wasn't in the original patch I sent in, but only in
the one sent by Brandon Casey. I believe that may have added
to the confusion.

I like Jeff's suggestion of only showing it when we autodetect
though, but I won't have time to send a patch until this weekend
at the earliest.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
