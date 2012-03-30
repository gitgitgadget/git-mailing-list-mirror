From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is the "text" attribute meant *only* to specify end-of-line
 normalization behavior, or does it have broader implications?
Date: Fri, 30 Mar 2012 11:22:06 -0700
Message-ID: <7v62dmlzjl.fsf@alter.siamese.dyndns.org>
References: <CANSc5vG0o_eAn7X39XhCzUoN4ab52pGCP+PvzOQCyTV31R8LGg@mail.gmail.com>
 <4F7555BC.1000804@viscovery.net>
 <20120330072546.GC30656@sigill.intra.peff.net>
 <CANSc5vGaodyv4H5qp2ZkjY7q6ot7_JG0jdvNDFRBFW1+p7v4sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Chris Harris <ryguasu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 20:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDgSo-0001hW-S0
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 20:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759552Ab2C3SWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 14:22:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757054Ab2C3SWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 14:22:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF5ED7159;
	Fri, 30 Mar 2012 14:22:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U3LUdKEiC/zJSWykjG/3RzRXuAE=; b=Q3eP6P
	TDmb82kHgAuwKaEomO9IzMiHvCR36xRsck68c/HbFsNQ2lpIV6Wr6rFg4zdDD9qQ
	Hi7E8EhPj6Bb7/3XS7To+Dl+2koqf0unLgL94fB8Dc3PLSh7IbAJwY81uK43mBct
	gPVJX3DOrUfNn94T235s07aMRQlyB9u17mk3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k7AMto2dgdArffrareL2LmSW8IQo+MIu
	t+wqh5+8atCiSNdM6if67kyr/InV/6pFeEZ2hv260TCB8VPmya502xGXAgQLenRY
	93n3PbwD7X/074XJ7eN244ITcD9mAB42NucHuoyZ+Osk9xRXHD4gE2Tw3REAXBG9
	MJ5jyl1EehU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C70397158;
	Fri, 30 Mar 2012 14:22:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AB3A7157; Fri, 30 Mar 2012
 14:22:08 -0400 (EDT)
In-Reply-To: <CANSc5vGaodyv4H5qp2ZkjY7q6ot7_JG0jdvNDFRBFW1+p7v4sw@mail.gmail.com> (Chris
 Harris's message of "Fri, 30 Mar 2012 10:49:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42A27AE4-7A95-11E1-B783-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194384>

Chris Harris <ryguasu@gmail.com> writes:

> A related point of confusion: I've noticed that, if you start with a
> question along the lines of "how can I explicitly tell git that a file
> is binary", then the web currently gives a slightly confusing array of
> answers. For example:
>...
> It makes me wonder if the documentation could be improved a little on
> this count, though I don't yet feel solid enough in my understanding
> to propose a particular patch.

If you only read your analysis on gitattributes documentation, it would be
clear that text/-text does not have much to do with binaryness, and it
also gives an authoritative advice "binary".

We do not have direct control over third-party sites that give incorrect
information, so people need to bug them as they find mistakes.  I think
ProGit actively accepts patches; I do not know about others.

Thanks.
