From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive.perl: Remove two unused variables
Date: Mon, 25 Jun 2012 11:06:09 -0700
Message-ID: <7v7guvgtbi.fsf@alter.siamese.dyndns.org>
References: <4FE7889E.2020009@gmail.com>
 <7vfw9khrrt.fsf@alter.siamese.dyndns.org>
 <CAFjFENo7qLTZHrEtPPBLGzp=h0w69C+7C2zfiJJmqFANmaWAgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Thomas Badie <thomas.badie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 20:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjDg2-0000ct-9J
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 20:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab2FYSGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 14:06:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab2FYSGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 14:06:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B82F7112;
	Mon, 25 Jun 2012 14:06:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gNMWgj8Gt3Zoxg9snfvnisfxgaA=; b=Gg9QYP
	pbLiTQlVnWMuFHtrvHhqFjGqgTPzQdwWtIGmt1V7U+KbyuUTnjJ0/FGT2JMO/R6p
	GKjEy8fbVt2ZVhl2VFjIOMe7w00DoZaiqtp/eGy0eqQ+ze3hoYMFcRUBtN6rBO+i
	3X/OSxe4pgQhI2p12Y2O3oxmxpHONECrjMPrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GoD9do0cW3SrEbu9hxJYA0Aa7s/NL013
	g56k0/+7LtePIlkZXYlLbqCOuC1++GMvvcu34x2kLZNZaS7iKLfa547jzo/HUAlI
	gcjed45RAFKEKyzk4PZ/42vHwJ+Cm9M+i5aNVHbQprYKmMJ4/unfamBM4iFg0anY
	ViwI0rJ/9Do=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 636BD7111;
	Mon, 25 Jun 2012 14:06:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE3FF710E; Mon, 25 Jun 2012
 14:06:11 -0400 (EDT)
In-Reply-To: <CAFjFENo7qLTZHrEtPPBLGzp=h0w69C+7C2zfiJJmqFANmaWAgg@mail.gmail.com> (Thomas
 Badie's message of "Mon, 25 Jun 2012 12:12:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 727A21FA-BEF0-11E1-A452-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200588>

Thomas Badie <thomas.badie@gmail.com> writes:

> 2012/6/25 Junio C Hamano <gitster@pobox.com>:
>> "Thomas \"Enki\" Badie" <thomas.badie@gmail.com> writes:
>>
>>> The patch 8f0bef6 refactors this script and leaves the `$fh' variable
>>> unused in `diff_applies' and `patch_update_file'.
>>>
>>> Signed-off-by: Thomas Badie <badie@lrde.epita.fr>
>>> ---
>>> Hello,
>>> This is my first patch. It introduces a really minor change, and I
>>> also want to be sure the way I submit it is the right way. Thanks :)
>>
>> The patch submission is almost perfect, except that:
>>
>> (1) the patch seems to be whitespace damaged; and
>>
>
> The only damage I see is a space on the deleted lines which doesn't
> exist in the patch. Is that you're talking about ?
> I need to investigate why it appears...

A typical context line would begin with SP and typically then tab
(because our code is indented with leading tabs) but your context
lines all have two SPs in front and indented with more SPs.  This is
a symptom of your MUA mangling your patch, and the reason can be seen
in the "Content-Type: text/plain; charset=ISO-8859-1; format=flowed"
header.
