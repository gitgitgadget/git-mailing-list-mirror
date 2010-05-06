From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: some shells do not let $? propagate into an
 eval
Date: Thu, 06 May 2010 13:20:24 -0700
Message-ID: <7vocgshjef.fsf@alter.siamese.dyndns.org>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
 <20100506055236.GA16151@coredump.intra.peff.net>
 <20100506064428.GA29360@progeny.tock>
 <20100506065419.GA21009@coredump.intra.peff.net>
 <20100506084045.GA25917@progeny.tock>
 <20100506085720.GA31873@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 06 22:20:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7Ym-00086q-SE
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274Ab0EFUUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 16:20:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab0EFUUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 16:20:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AA7BB1E37;
	Thu,  6 May 2010 16:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R4KvkPuCNFmwEGpQ3qIAW7MIS6s=; b=YOWu1N
	IcjgSd6/n+ocU+zxbc3j6Kiqy5K6LVD6WPjUlsT5jUJCGJTy8DyMqYo4bKo+dBNz
	TdLjHsPB+tndNl6tZzdbT40hbv4AfQQ2qkz1kJMviipgv/ZQfb5BQhefnMjAAawm
	bUea6naWZcuHGzr07Gs8Te3QR/y9BEFoOoUgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ve7e54N9u296spcL817FUtx/umJXKzlp
	ln8UUN+kSb5jZrlNf8HkQpDs+6/QIyhj1tv+OQueCLHxiqQFU4g/zCfVNMNHRE5I
	S+Jho7y9Q1lVJ0h0Q0XfUjf/khmZCUfQIWhSkZ8ftCR37/OVrsBR5jAuq91aQMt6
	u+vr+gt2woA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E913FB1E36;
	Thu,  6 May 2010 16:20:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46EFAB1E34; Thu,  6 May
 2010 16:20:25 -0400 (EDT)
In-Reply-To: <20100506085720.GA31873@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 6 May 2010 04\:57\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D02ABF96-594C-11DF-A4CF-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146492>

Jeff King <peff@peff.net> writes:

> I think Junio is much more carefree with changes that only touch test
> infrastructure, as they cannot possibly be breaking git itself for
> anybody.

Yes, and also I deliberately queued this with a known breakage because
I've been swamped with non-git issues (sorry), I knew it would be very
isolated issue, and it was the easiest way to get people's attention.

Thanks for helping.
