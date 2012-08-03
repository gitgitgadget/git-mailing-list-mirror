From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.7.12-rc1
Date: Fri, 03 Aug 2012 12:50:42 -0700
Message-ID: <7vfw83bvql.fsf@alter.siamese.dyndns.org>
References: <7v8ve0q4yy.fsf@alter.siamese.dyndns.org>
 <20120803161916.GA16973@sigill.intra.peff.net>
 <20120803170336.GA24237@sigill.intra.peff.net>
 <7vk3xfbxe6.fsf@alter.siamese.dyndns.org>
 <20120803192337.GA5091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxNtd-0002tc-7J
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 21:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab2HCTus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 15:50:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388Ab2HCTur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 15:50:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE5D86F2D;
	Fri,  3 Aug 2012 15:50:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S1fJa3zTaxyC8/Gim2HRM7gn390=; b=HUmADc
	XkOL0YJa8K8wJJeIXP+MrLOLMgsGKk29iMIMSxJaGoTBp0v6Ytm1ZRiKjb8nn7hh
	ZLyt6bCFSKPJX/BOaDhzhhkRpC10+csNR5hDXFsR94mv2QviAcIbnd1IVmoyVZBR
	FeZzGR4R6vTwOUPU8k/mLC5VYRu4EMxD0+wHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WWvL0pcPFgOWPYVO5HdmTfiImCKSp9oG
	OzWz64FLQbZtk4GmHJpcnivEM8opfDSpcFvqDVakXH/5WYvNNsgHo4jF05qB159B
	t6yEUbdn23Kk/qazS7DfU1srQYCmAcJOWnj6fO/6WSsQqx9sI71tJSKI8gLbMgGU
	2KywhaKUq1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB8A16F2C;
	Fri,  3 Aug 2012 15:50:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 381E96F2B; Fri,  3 Aug 2012
 15:50:44 -0400 (EDT)
In-Reply-To: <20120803192337.GA5091@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Aug 2012 15:23:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8323F90E-DDA4-11E1-8BAB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202852>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 03, 2012 at 12:14:57PM -0700, Junio C Hamano wrote:
>
>> >> Here's a repost for convenience.
>> >
>> > And here's an update to the release notes.
>> 
>> Thanks.  Both are signed-off (I expect regulars to lead newbies by
>> example, so...).
>
> [s/are/are not/, I assume you mean]

Actually s/\.$/?/ but they amount to the same thing ;-).

> Oops. I recently refactored my "print one patch so I can stuff it in an
> email" alias and it lost its "add-signoff" functionality.

I suspected some automation-gone-bad; no need to resend but please
do make sure to update your procedure.  Thanks.
