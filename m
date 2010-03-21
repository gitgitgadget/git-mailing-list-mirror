From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Correct references to /usr/bin/python which does not
 exist on FreeBSD
Date: Sun, 21 Mar 2010 15:13:21 -0700
Message-ID: <7veijdfhmm.fsf@alter.siamese.dyndns.org>
References: <20100321190145.GA32578@kiwi.sharlinx.com>
 <7veijdl6kp.fsf@alter.siamese.dyndns.org>
 <20100321212335.GB32016@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@monkeypox.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 23:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtTOr-0001de-KF
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 23:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab0CUWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 18:13:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab0CUWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 18:13:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41800A35D7;
	Sun, 21 Mar 2010 18:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J8wLdSjkDJU7/nqQPPFgI6N2IiA=; b=A+LUHu
	cvsLd0nnqTehzCNc1SwhlC3+VEPymkwU/OpTpAs+IDtIG8U94VF9U0saFmUdaQYV
	ObS5rPy/48xwkvsUrgS7NXx4zziGQtefNEOY6r+kf2wbMO3CoALXOHoFgwfzx6kb
	z7Fmecs4r9H92/s8OvxLjKJiW/sf7L4tCwJN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tyxK/Caf39tthm+1eT2zBla9d3Mnkoqe
	KNueOJX0/qg+aROyqhkAc6DksIjXbybnm8oDxY5DtT9l61todTOfg0duu9wbtecm
	FyMCL2eJEDTPpv6H/x3GrboQZBvRy56uuPIMaHZKooKPgijOa4jp2HErD40hsCyi
	aRO1YSsUUOY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E1CA35D3;
	Sun, 21 Mar 2010 18:13:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B388A35D0; Sun, 21 Mar
 2010 18:13:23 -0400 (EDT)
In-Reply-To: <20100321212335.GB32016@kiwi.sharlinx.com> (R. Tyler Ballance's
 message of "Sun\, 21 Mar 2010 14\:23\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F88A39BA-3536-11DF-A654-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142867>

"R. Tyler Ballance" <tyler@monkeypox.org> writes:

>> I would have expected that the patch would look more like this:
>> ...
>> What am I missing?
>
> No, that looks right, I didn't notice the specialized section towards the
> bottom for FreeBSD or the others for that matter.

Thanks.  I usually use a "make" wrapper to handle platform particulars
like setting PYTHON_PATH automatically outside of the build system we
ship, and never noticed this.

I'll just commit my version with a forged sign-off from you ;-)
