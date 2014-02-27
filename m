From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2014
Date: Thu, 27 Feb 2014 12:32:34 -0800
Message-ID: <xmqqfvn4xpnh.fsf@gitster.dls.corp.google.com>
References: <20140225154158.GA9038@sigill.intra.peff.net>
	<530CCFB0.5050406@alum.mit.edu>
	<20140226102350.GB25711@sigill.intra.peff.net>
	<530DC4D1.4060301@alum.mit.edu>
	<xmqq8usx4pvh.fsf@gitster.dls.corp.google.com>
	<530EEAA2.3030306@alum.mit.edu>
	<xmqqlhwwz7m7.fsf@gitster.dls.corp.google.com>
	<530F9F59.4030307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:32:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7dJ-0007zW-B9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbaB0Uch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 15:32:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbaB0Uch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 15:32:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9743870D61;
	Thu, 27 Feb 2014 15:32:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zVW9RPIwwhoAG5Kx+Nnw2QTHZUo=; b=aRiqHP
	u2Ag/BjTnfEfsZuYMmKU1AzwkP6N7pFK4uTJY3Cg7G3I2etBCvBddkxU8urs6gwm
	+UgE6REAfYeo7gva6gyEn0y5qa/WIEScGxfYSBHBGBL25/pmdo9soYFnKtWBcICa
	vRJ7P3MxMCVfE7uTSsLKsGwy30zhUwSO+5iwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M25/lOdfnxtAhgfDHOwtm6RB0RGTsv+K
	ztx59VMObGzSmidEPyH2xdQNwz14Ao0qFCkT6DLtfa0O+UjCNArEJ+Qve3Luat24
	Nxbw+hTd2dOp555fS8hG0qmSOX2RskAgv3MgeurMmN7yGoZb2rsqaOkCaBF6noL+
	MP5H+bD6Ev0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86B5E70D60;
	Thu, 27 Feb 2014 15:32:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C722970D5D;
	Thu, 27 Feb 2014 15:32:35 -0500 (EST)
In-Reply-To: <530F9F59.4030307@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 27 Feb 2014 21:26:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4ADCF1AA-9FEE-11E3-B739-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242853>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/27/2014 08:19 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> Sounds good.  I suggest we make your blob a paragraph before the list of
>>> bullet points rather than part of the list.  Please suggest some "TBD*"
>>> then I'll add it to the text.  Would we also fill in "X" with the name
>>> of the actual student involved in the conversation that is pointed to?
>> 
>> I was not thinking about using a student thread (I do not remember
>> having a good on-list interaction with past GSoC students).
>> 
>> How about using this one from our recent past:
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/239068
>> 
>> which has the following good points to be used as an example.  It:
>> 
>>  - involved multiple cycles and multiple reviewers;
>> 
>>  - showed good response to the comments from the original author;
>>    and most importantly
>> 
>>  - had everything related to the topic in one single neat thread.
>> 
>
> Change pushed.  Thanks Junio!

Thank you for starting this.

Another point to add to the above three-point list is that it had an
example of the original author defending (some of) the design
choices he made and reviewers who initially raised questions and/or
issues agreeing with that choice after the thinking was clearly
explained.
