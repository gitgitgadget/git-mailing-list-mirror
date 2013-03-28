From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t5520 (pull): use test_config where appropriate
Date: Thu, 28 Mar 2013 08:17:21 -0700
Message-ID: <7vli97wo3i.fsf@alter.siamese.dyndns.org>
References: <7v4nfz1ndo.fsf@alter.siamese.dyndns.org>
 <1364474419-22796-1-git-send-email-artagnon@gmail.com>
 <7vy5d7wpbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEaP-0005dP-7x
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3C1PRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:17:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab3C1PRY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 11:17:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FD9BA43E;
	Thu, 28 Mar 2013 11:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=txyYGtCW525yQjbxYVPDRTRGvaI=; b=Eq+9ul
	rzxv8H0yKzJ+N/Rg6+8+O5rzH1j30KdPJ+asW4mfaCWjVanJiL1JZA/wCuj3lWTR
	/W2QYUTp4UPu2bJN314NpBVZ2CFFpAV9JoLn4D5ZKgDdnbIHK9TadCvIXSP/MT+G
	i2GfpKP0O/LGzT2njZq6567qHBep/dUh7X8Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mk8rJnq5WzZZr8dOXS+QguMZ8Zm151dO
	KtOfPCStH8C4ptc4Akc3Wzw6/ddV8OIyQhMQ1F5gnrkcUFymNaqVkq1EFl2XUG9f
	nylTG7XVdDoRY0LYU6uqbCBFYVg/o9eeM0Bmb5HtCnXwCNAAP9UiNKLQ2NwPEpNn
	smobw7ZbPPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 053A8A43D;
	Thu, 28 Mar 2013 11:17:24 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73A04A43A; Thu, 28 Mar 2013
 11:17:23 -0400 (EDT)
In-Reply-To: <7vy5d7wpbi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 28 Mar 2013 07:50:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 976DDFBC-97BA-11E2-AE62-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219406>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Configuration from test_config does not last beyond the end of the
>> current test assertion, making each test easier to think about in
>> isolation.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Removed first hunk, as per Junio's comment.
>
> Thanks, but doesn't yd/use-test-config-unconfig topic already
> address this?

The last hunk from your version was missing from 9d6aa64dc32b
(t5520: use test_config to set/unset git config variables,
2013-03-24); I'll pick that part and apply as a follow up to the
series.

No need to resend; thanks.
