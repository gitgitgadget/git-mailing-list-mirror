From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 10:42:41 -0700
Message-ID: <7vvd56m1ke.fsf@alter.siamese.dyndns.org>
References: <4CB5CEA3.8020702@xiplink.com>
 <20101013173555.GA13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:43:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65Lw-0005uM-5b
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab0JMRmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:42:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab0JMRmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:42:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D0EADE79E;
	Wed, 13 Oct 2010 13:42:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yKOIjjFH3NjYo09YWd6VGb2s+xU=; b=XiCEu0
	HNNrCGaQ3gnqYsihluvWJObHaa0e60BdBTIP3a3wEG8YaVdooHxV9NfIBzqRsqWF
	y0s+F1T9HYwFKwi6Aw+eGWxWX9bV2+lPniJbNrSkI/QA/YVf0WYO2vqGvVK8DO9r
	twfW+kcSOaZ1oTaa2zY9LXeeZNkvhyivJGfpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I58JbHx4gPw7RPqNAlYt/f6Fd3ZjNaG1
	LO1YYCwlG14NbgqNPPF+8iDR+ucB5Te3fHSKlcAHlJBSmglCU5JOMmEDkj2gjE/W
	RFQXgO2o0e8ouRjGyn7jBJ7RnrkpxBHhTaYTtXqXOdfv/MiAANHmH/r2sDK4I41u
	G/8Sg8L+cGQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9673DE79D;
	Wed, 13 Oct 2010 13:42:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE410DE79C; Wed, 13 Oct
 2010 13:42:43 -0400 (EDT)
In-Reply-To: <20101013173555.GA13188@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 13 Oct 2010 13\:35\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B073330-D6F1-11DF-98F9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158948>

Jeff King <peff@peff.net> writes:

> Yeah, I believe "." at the front of a directory component is explicitly
> forbidden by check_ref_format. I don't recall whether there was a
> specific rationale, or whether it was simply a can of worms we didn't
> want to explore.

Is "log foo...bar" a symmetric difference between foo and bar, or is it an
assymmetric one from foo and .bar?
