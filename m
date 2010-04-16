From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-id: Add support for mbox format
Date: Fri, 16 Apr 2010 14:23:01 -0700
Message-ID: <7vochjay8a.fsf@alter.siamese.dyndns.org>
References: <1271434948-14134-1-git-send-email-bonzini@gnu.org>
 <7vk4s7cks4.fsf@alter.siamese.dyndns.org> <4BC8CEC7.40003@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 23:23:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2t0O-0000oG-Ay
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 23:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446Ab0DPVXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 17:23:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414Ab0DPVXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 17:23:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF289ABF5D;
	Fri, 16 Apr 2010 17:23:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SC92Vw8PoNkOHI0jxVORwanpTTQ=; b=aiFSPC
	23VKzQu61vssMkL4SjIyt1ECi0p/EapWnk0HRcHwHpg2R6Ysy5wq2/05BuOWwY9R
	KeHd5B+Pe5xOKXXKidgxdUuoNZ1zN+OiCw3YcFpoMvL+j6mMXJuPnVuxYda8q3sV
	QDcRUKs6BgfA/mqO9APsrPoRTDgCXvHPErIHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E75zBdhqoOFoJ0BUUX6K24LRMhr0lU5t
	j2CgPPZxiOQdGqkR29FxQAEQL4f+VZ8ozesHKadRYZvMzqPrKAg4BdGATUiOc5lB
	Ks1CvO/FhxeEnXvvWlLwxfFvVuDosxkQA0dzVNc72a7AWYc2GempX4aPyS8D+MGL
	OPrY6vNwJ78=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9F6ABF57;
	Fri, 16 Apr 2010 17:23:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1DFAABF52; Fri, 16 Apr
 2010 17:23:02 -0400 (EDT)
In-Reply-To: <4BC8CEC7.40003@gnu.org> (Paolo Bonzini's message of "Fri\, 16
 Apr 2010 22\:55\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3EF0B962-499E-11DF-8F28-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145096>

Paolo Bonzini <bonzini@gnu.org> writes:

> On 04/16/2010 08:30 PM, Junio C Hamano wrote:
>>> >  I have an alias that takes two arguments and compares their patch IDs.
>>> >  I would like to use to make sure I've tested exactly what I submit
>>> >  (patch by patch), like
>>> >
>>> >      git patch-cmp origin/master.. file-being-sent
>>> > ...
>>
>> I somehow have a feeling that this is solving a wrong problem.
>
> In what sense?

Why does file-being-sent have anything from origin/master to begin with?
Perhaps the --ignore-if-in-upstream mechanism needs to be updated so that
you won't have duplicates that patch-id could easily find in the first
place?
