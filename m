From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ignore unknown color configuration
Date: Sun, 13 Dec 2009 18:33:13 -0800
Message-ID: <7vzl5mjndi.fsf@alter.siamese.dyndns.org>
References: <20091212122524.GA17547@coredump.intra.peff.net>
 <7vzl5nn9x2.fsf@alter.siamese.dyndns.org>
 <20091212222046.GA25973@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 03:33:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK0kc-0004q7-62
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 03:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbZLNCdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 21:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbZLNCdZ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 21:33:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbZLNCdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 21:33:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A26D5A5EDC;
	Sun, 13 Dec 2009 21:33:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DVq7izxzq0ftrnGEp0NT8zlk7lY=; b=w0LJCy
	WDUw8vjIA1m16FAeC9sO3rPAaSpB/h2T94LoIaXKeYjngPpGIvghPuEQNSrbCKt1
	Cp7iSIpzZk4bBAbsqm1re//iF3VJt/EQJxBqJnFlgRguHcbjTPGHMownRiavDx6b
	4txnWL4+/ALzCmKfiRF+jltGb55LCJGS7mvyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JdfLKPVxJSNMWs4FUUAhsxtcaRrxaDiH
	346NYa30URdPjlRa3Ju6p3Gtj7Y/yyIuoQrR1oXqlJFA419FMDK7vv3dh/ZM9Gc8
	8hwZljsaBGl6ssJsnAmBeZlda01i7KEcsmEzkTiGdfKL47jIAk9nSHwmOSyX0a5D
	VMROtGwsRRo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82764A5EDB;
	Sun, 13 Dec 2009 21:33:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D89DA5EDA; Sun, 13 Dec 2009
 21:33:14 -0500 (EST)
In-Reply-To: <20091212222046.GA25973@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Dec 2009 17\:20\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A942B82-E859-11DE-9C81-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135164>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 12, 2009 at 01:45:45PM -0800, Junio C Hamano wrote:
>
>> This is a sane thing to do, as "slot" is part of the name of the variable,
>> and we generally do not warn upon seeing a misspelled variable name (it
>> makes it worse that "func" is not even misspelled but merely unknown to
>> older version of git in your scenario).
>> 
>> On the other hand, I suspect that most people would apprecfiate if their
>> git pointed out "diff.color.finc?  What do you mean?"  before they waste
>> 30 minutes wondering why the new feature in 1.6.6 does not work for them.
>
> I would be more sympathetic to that user if this weren't the _only_ set
> of variables with this property. They don't get warned for diff.externel
> or color.show-branch.

True and fair enough.  Let's have this in 1.6.6 then.
