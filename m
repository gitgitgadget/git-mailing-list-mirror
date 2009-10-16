From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 13:05:11 -0700
Message-ID: <7vpr8nt894.fsf@alter.siamese.dyndns.org>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
 <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
 <7v7huvuptn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "jamesmikedupont\@googlemail.com" <jamesmikedupont@googlemail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myt3L-0007IR-Il
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 22:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbZJPUFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZJPUFT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 16:05:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZJPUFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 16:05:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 246D05B2E9;
	Fri, 16 Oct 2009 16:05:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hNYUrm3QYqCgQxqM97yFKtAaaVQ=; b=GvjAoe
	WRbrdorlq/hSGT7AO3u4UMQ+RNZdWCCiiV1nGr5CNpD431J3zbCi9mag2qgSsT/E
	WpNvE0hbwghxKPbMIlNP8pn6RY0yMUzGhZOul3fSF8Sm3UMwgfemc3k+tuJJKs9B
	tM6LGg4F2SHH5PVrVAlHGHIWCbWdq4LFe6++U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLuy12JLo8SwCYut/IheEUnsfTAW/dD1
	SO3GjjhzDXVsNPl6NLlwv7ajiWk9IZqv/aPqJZr5yZm5dU0PQUFLKPfei/iudxPL
	gqRR2dmx70kgSV453MuZAwUMmHpnUWlENEzzoKtBiuvnIsb7FCDk95CWHxQYxmac
	rn8HgXMH7PM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E82235B2E7;
	Fri, 16 Oct 2009 16:05:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02BBA5B2E6; Fri, 16 Oct
 2009 16:05:12 -0400 (EDT)
In-Reply-To: <7v7huvuptn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 16 Oct 2009 12\:00\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39B952CC-BA8F-11DE-8955-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130524>

Junio C Hamano <gitster@pobox.com> writes:

> "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com> writes:
>
>>> You would need to postprocess the computed result (either by diff or
>>> blame) to lay out the final text output in either case anyway, and making
>>> the existing blame engine do the work for you would be a better approach,
>>> I think.
>>
>> Please can you tell me what is the basic algorithm of the blame engine?
>
> I think this is one of the most conprehensive write-up on the algorithm:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/28826/focus=28895
>
> The whole thread (at least what I wrote in it) is worth reading if you
> want to understand what the current code does.  The first message in the
> thread talks about "NEEDSWORK" label on an unimplemented part of the code,
> and says "we could", but these gaps were since filled.

Ah, nevermind.  The thread is the definitive description of the blame
algorithm, but I agree with Dscho that in this case, you either have to
change blame itself to do this "byte-wise" comparison internally between
versions, or re-do the blame logic yourself like Dscho suggests.  Dscho is
right in this case; an unmodifled blame engine, unless you feed a history
that is converted to use the byte-per-line format, won't help you at all.

So it would be either between rolling a custom byte-wise blame algorithm
yourself and teaching a new byte-wise mode to existing blame engine.
Sorry for making the task sound much easier than it would be.
