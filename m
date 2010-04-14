From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/9] Setup cleanup, chapter one
Date: Wed, 14 Apr 2010 13:54:17 -0700
Message-ID: <7vwrw9oiva.fsf@alter.siamese.dyndns.org>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29bX-0002pj-4O
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772Ab0DNUy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 16:54:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab0DNUy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 16:54:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A61FAA761;
	Wed, 14 Apr 2010 16:54:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rlgWTkJKEyhk
	ZmQ077nVqn2H5bo=; b=DZ13GWtmsbhtWiAlErxu/c/jYLgdW5iiwYWL/5IoRUuk
	O/oE37wOyxg6FKmJy6eRskTl5tT6rz9kOzvFbYGR2Wz6UlxIznmpmSGU6URftSyo
	D2TV97LnubuO+ff/zAAFrovG+KJuclP7qqh8Enf2Y1Z84wj2DJKciWTa0cFZc8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vYhWNl
	Hg+viMzIyjOV0Ql9brB5vmxvI375dpJWc2B5h39IPGOwv0Vqrb+Dh64HmwuxbQo+
	lASgpu1qDKK69F36iELBXqScDDYocD2arrnI3B0/23C3nMzlKVQb6SwyL6hksEfY
	ZflsRFZ0WT3h3HJUPdY7vl8LtHmEsTuByPC38=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D4BAA757;
	Wed, 14 Apr 2010 16:54:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44F6AAA74F; Wed, 14 Apr
 2010 16:54:18 -0400 (EDT)
In-Reply-To: <20100413021153.GA3978@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 12 Apr 2010 21\:11\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E77C7D48-4807-11DF-A5A4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144914>

Jonathan Nieder <jrnieder@gmail.com> writes:

> These patches are designed to make people who want the pager.<cmd>
> configuration to be more reliable a little happier.  More importantly=
,
> they bring the setup procedure closer to doing the Right Thing=E2=84=A2=
=2E

Thanks for looking into this.

By the way, the other day I had an interesting experience after running=
:

	git -p help -m cat-file

If you try this yourself, you probably need "reset" or "stty sane" to
recover.

Does this series address it?
