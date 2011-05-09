From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Mon, 09 May 2011 09:53:05 -0700
Message-ID: <7vei47q0i6.fsf@alter.siamese.dyndns.org>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
 <20110509144451.GA11362@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: conrad.irwin@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:53:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJThw-0000jd-EE
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 18:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab1EIQxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 12:53:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1EIQxO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 12:53:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C48C4633;
	Mon,  9 May 2011 12:55:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q5gsPALwHuIKZlGkGrTH4S/lZKk=; b=MoD3iz
	6Wnra7x+KXGXbyfAIeJuWU5kkEksP9IGo5O2tQTbJWj08RkQrctBUX/03BeYBE9K
	fOm7Nc4BJmDosSBuxFQYWMKBxOX/AIqOdDyESUV/svJ29S1vCSIsW9LGG2Ch6W4T
	g8ZSbyKA+wK0VvRtwWoLbczMGW0EQl/cI18d0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g08N8eOjbD8cNg+xpiTEGlFdV47sYKwj
	mzvb5hmk5iqgmAgAD3SNBM2TYRlC4YANMl+W3qHC4LRa2rbNyUOMZrnSMkJHzB5/
	ZDJIb3uIZQS+dXp8Qgiihw0TzWX0gSKkyANa8MdiemgKx3oSX+rMujxq6T4Y+/md
	NzggCYVSva4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 565E3462E;
	Mon,  9 May 2011 12:55:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 441BF4629; Mon,  9 May 2011
 12:55:11 -0400 (EDT)
In-Reply-To: <20110509144451.GA11362@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 May 2011 10:44:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CA6A02E-7A5D-11E0-AF85-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173246>

Jeff King <peff@peff.net> writes:

> I'm not sure if it is worth caring about. If you are really interested
> in index state, you are probably better off using "git add -p" and "git
> commit" separately.

I agree with this. I do not foresee myself using "commit -p" ever for this
exact reason. I however didn't see anything wrong in the series and I do
not see any reason to reject it, either. It's just another long rope other
people can use to tangle their neck with ;-).

> Hmm. Test t7501.8 explicitly tests that this isn't allowed. But the test
> is poorly written, and falsely returns success even with your patch.

Thanks. Let me see if I can simply amend what I queued already ;-)
