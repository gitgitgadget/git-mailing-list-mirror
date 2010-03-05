From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 09:01:16 -0800
Message-ID: <7vhbou1z4z.fsf@alter.siamese.dyndns.org>
References: <4B90C701.3070308@gmail.com> <4B90C974.2050405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiri Slaby <jirislaby@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Mar 05 18:02:21 2010
connect(): Connection refused
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Nnauq-0007Ay-EM
	for glk-linux-kernel-3@lo.gmane.org; Fri, 05 Mar 2010 18:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab0CERCJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 5 Mar 2010 12:02:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0CERCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2010 12:02:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8C619F833;
	Fri,  5 Mar 2010 12:01:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HhcaKYd9MqL9RGAOKXKw6bFoAuA=; b=RNfGET
	zh9AGGtOtGMcg/WK9oNr8M8MS9fEKyxZYREDo6ll6OMEKhGLI5ROsrQQD9q7r5v0
	jMrsUwCxx/4GH6jbNKjHHnnzjH431cCPORTT2U2W2dYmBVT3Vc42/zRETVEcMfPr
	eygKR32aS3hcQmUombZfh6FN6JpWSt7vl+o/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bew7KHqrfYHxp5/5Aiv1FctjX8Hon559
	XGfmCNnq+z5h8cYqFhSP9hlPo/NbDX1PTzXZN7VmtoeIsCdtp+3fib05ZGdq2VJl
	O0Wt69B77PpUmJXHxdZFLUrw00E/fQeKdcqg4pFzcwvzr03umiF772ZUOzsz6rJx
	3tX1lDbY/zw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9279F820;
	Fri,  5 Mar 2010 12:01:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B9809F810; Fri,  5 Mar
 2010 12:01:18 -0500 (EST)
In-Reply-To: <4B90C974.2050405@viscovery.net> (Johannes Sixt's message of
 "Fri\, 05 Mar 2010 10\:05\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCBD651C-2878-11DF-B8E3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141588>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jiri Slaby schrieb:
>> having 'linux' line in .gitignore makes 'include/linux/vga_switcheroo.h'
>> to be ignored
>
> That's the behavior that I would expect.

Also the initial report made it sound as if there were a regression, but
it doesn't seem to be the case; I don't see it behaving any differently
among 1.7.0, 1.7.0.1, 1.6.0, 1.6.6, or even 1.5.4.
