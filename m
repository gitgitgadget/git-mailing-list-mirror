From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Wed, 15 Aug 2012 12:07:59 -0700
Message-ID: <7vehn855yo.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch> <7vr4r98ah5.fsf@alter.siamese.dyndns.org>
 <87sjbo63pl.fsf@thomas.inf.ethz.ch> <7vfw7o6p1g.fsf@alter.siamese.dyndns.org>
 <502BECAD.90307@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:08:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1iwt-0000Vj-5l
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 21:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab2HOTIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 15:08:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab2HOTID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 15:08:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07E36832D;
	Wed, 15 Aug 2012 15:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2VKBMzkPfcihfU9dWC9Onl5d+z0=; b=B9vf/O
	evliAZcclPwSdMWdwkxMhKDkc/s9O4/zf35weAxIJsVEwF0V4nq+UnCJPM36pmf7
	TlTTp+d4RhnMe+msGrtqEQ0Nagm3R1oaSpu9yTNre8asrrARRJVatMt2rZaG3bvX
	9Xg/QSzwHiu1TA3R2Lh3/hjbrDomm5wQAxfAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qFoijdrdRRxD7LEYJUpz9Lg3+sNPkfH1
	kXyNFsTVsdzViBcHxE2MJm5XuxOt9OHPO/i7QeZ6gAIUCOr7QyFxjdZzwuC4NPf4
	xjbYljmx2NtF9c7WlG9tq99Y5GpHVWkZ2KSYw+AaUWaPkZGSVyXH5jhufuonN/gc
	ouvwwL04fzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9177832C;
	Wed, 15 Aug 2012 15:08:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62B54832B; Wed, 15 Aug 2012
 15:08:01 -0400 (EDT)
In-Reply-To: <502BECAD.90307@ira.uka.de> (Holger Hellmuth's message of "Wed,
 15 Aug 2012 20:38:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88890A9E-E70C-11E1-91C0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de> writes:

> Am 15.08.2012 19:30, schrieb Junio C Hamano:
>> The current rule is very
>> simple and understandable.  You either say from the command line
>> exactly what should happen (refspec without colon is the same as the
>> refspec with colon at the end, meaning "do not track"; if you want
>> to track, you write what to update with the fetch), or we use the
>> configured refspec (which again spells what should happen).
>
> Couldn't a similar new rule just say that refspec <name> is a short
> for <name>:<name> ?

Of course not.
