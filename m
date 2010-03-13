From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 05/12] docs: differentiate between <tag> and
 <tagname>
Date: Sat, 13 Mar 2010 13:53:06 -0800
Message-ID: <7vbper7ut9.fsf@alter.siamese.dyndns.org>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
 <1268455984-19061-6-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 22:53:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZGq-0000Np-4o
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 22:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab0CMVxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 16:53:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab0CMVxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 16:53:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67075A11EF;
	Sat, 13 Mar 2010 16:53:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dxk1bN+Wd3r5GsE6GmqmmSZ+IW0=; b=pTqrdW
	lsfJfE3SnRitN9QrAxAyj38aAW8kdqqa7JeLap6+jHYU2HKGocaEMFhAfiyPX1f+
	LWYi0dlyoKGYnhGvm/nEzBU0Jgo30Hbq5JjEa6hAob0V4hDz7oQSAQu+m5ri3hdq
	YyfaDu8x9Vsl0JMDdd5Q+GzwwniHQtyoHVyNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZVlOX8D/BZCHsw2hTVNn9DF45lHdmtk
	Dc/vlxdk64BW+0lk50rXRN950dVG/DLRz+BhHylGPXNWLjr+6I0DvMUdrj+XYwIi
	aYf2QcA5yiT2+QuNpavU9vI3E2fqLMtA7iW1gi1nSUUMVlG1hd+KwPNOm6Dm6SD6
	BTfqm7QHhQg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44ADBA11EE;
	Sat, 13 Mar 2010 16:53:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B015BA11E9; Sat, 13 Mar
 2010 16:53:07 -0500 (EST)
In-Reply-To: <1268455984-19061-6-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Fri\, 12 Mar 2010 23\:52\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0AB6934-2EEA-11DF-921A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142110>

Mark Lodato <lodatom@gmail.com> writes:

> In the documentation and user messages, differentiate between <tag>,
> which means an actual annotated tag object, and <tagname>, which is
> a revision specifier for refs/tags/<tagname>.

Do we talk about annotated tag objects that often?

I would instead recommend you to consistently use "tag object", "tag name"
(the string that appears on "tag " line in a "tag object"), and "tag" (the
refs that live under refs/tags/ namespace.
