From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Fri, 24 Feb 2012 12:56:58 -0800
Message-ID: <7vobsox84l.fsf@alter.siamese.dyndns.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net>
 <87sjicpsr1.fsf@smith.obbligato.org> <87ty2ro1zf.fsf@smith.obbligato.org>
 <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org>
 <CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12CT-0005c3-JS
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758097Ab2BXU5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:57:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350Ab2BXU5D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:57:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC8056BB7;
	Fri, 24 Feb 2012 15:57:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jsMVhTm/byuML9kBgEHl1OKkRMk=; b=uPgrpD
	pAkC6/XL82xlPra7ToA1FyMwzik8NqYQ+Gcmozx8hIJzyQ2hp0xkOtR1KI8On77a
	cIunwhkpbcjsCunL2EFeJnS4Nn0g+BhyFAjPD0E8yGIxNz7SV/83wwTzg1T5gqTq
	iYkrq3hJoPCWXPcmpQdM7WqSTpWWS5dKerzo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e01eYJSyWoCRorKSnxk02Ncmb9XPn0ET
	SbYpQNXuHtvu7EtvCCZWj1m2vcXJVYtxPw0Uc5MVvqocRAI2Q22dQaCI5fkit2NN
	rcEK+zeON0k8lXgfLUNzHcBSTdSQv/nHD+iGA28FhszKKOHdksMA6tykUWsiG9xC
	5JXfnBqROD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A477A6BB6;
	Fri, 24 Feb 2012 15:57:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 435B66BB5; Fri, 24 Feb 2012
 15:57:00 -0500 (EST)
In-Reply-To: <CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com> (Avery
 Pennarun's message of "Thu, 23 Feb 2012 20:19:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 188B38F8-5F2A-11E1-9625-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191476>

Avery Pennarun <apenwarr@gmail.com> writes:

> Overall I agree that there's little benefit in preserving the history,
> at least as far as I can see, *except* that some code changes were
> submitted by people other than me and squashing those changes might
> conceivably cause licensing confusion down the road.

That is a good point, and it sounds like a good enough justification to
merge with history, at least for me.
