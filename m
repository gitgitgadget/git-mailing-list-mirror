From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -u nonexistent-file
Date: Tue, 09 Feb 2010 15:18:15 -0800
Message-ID: <7vy6j2vw08.fsf@alter.siamese.dyndns.org>
References: <20100208182929.GB14355@neumann>
 <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
 <20100209003958.GA4065@coredump.intra.peff.net>
 <7v7hqm2hs7.fsf@alter.siamese.dyndns.org>
 <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NezLr-0001QH-P9
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 00:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab0BIXSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 18:18:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab0BIXSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 18:18:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B861987E5;
	Tue,  9 Feb 2010 18:18:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=YNytlK7oDT+za09hbIxff4MCv0U=; b=HQ/uce
	XgHF0MGMcukalQtq4N1C58dv628CSpSEvJRXmXl0DPLDo8nWtMlvzEXNFuFNtlNF
	TZeLJbvSnmq++ntY+MvbBV2TXpwM3/BvSipPoskbaGZUZhFK/H1tSnUUzKs/ePnJ
	Wyqe60aYwMh8Lb+W3t+4eCMLCO0iNiV/+Ym6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wLbEbqculzBYDQFPLiabKPPFgOv76LYy
	9E9cVw4cw5JF7bqZ8zsXGkWjcRBOu0To6fJmslffEpJc1MnR5OrFXh5523lB9ms8
	7I1+gzcizwcroP5mzec/PnUPsoitOJE7hn5Y1+kp6BFqRfV5tG7WLbp6k5qiSmMl
	aJUUKap31NI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C3A987DF;
	Tue,  9 Feb 2010 18:18:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52D01987D8; Tue,  9 Feb
 2010 18:18:17 -0500 (EST)
In-Reply-To: <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
 (Chris Packham's message of "Tue\, 9 Feb 2010 17\:17\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B0BD1A4-15D1-11DF-A04B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139459>

Chris Packham <judge.packham@gmail.com> writes:

> On Tue, Feb 9, 2010 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> It won't be entirely trivial to do so efficiently but it shouldn't be a
>> rocket surgery.
>>
>> Something like this (untested of course)?
>>
>
> Passes my new test and all the rest in t2200-add-update.sh and t3700-add.sh.

Thanks; will squash two tests into one.
