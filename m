From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include xmlparse.h instead of expat.h on QNX
Date: Mon, 11 Feb 2013 13:53:51 -0800
Message-ID: <7v38x2ldow.fsf@alter.siamese.dyndns.org>
References: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
 <7vip5ylekj.fsf@alter.siamese.dyndns.org> <20130211214948.GB19113@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:54:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U51Kb-0007Kq-OI
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734Ab3BKVyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:54:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932692Ab3BKVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:53:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1E20B345;
	Mon, 11 Feb 2013 16:53:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEQsw3UEVkgTowOfM4s0+bLLDTc=; b=MA5Vj+
	eamkBw/BtRaJD3fl8iDTOmQBWltI3tsDaqmDguUKv+1VTww/ry4QuL88U0k7ox7t
	NkmIHALYA+8h8Lb+4rArQNjjJXkwijYojL91fN/6gc/nwVVDcMZ1dRQ8WCXbsI/B
	8TAeEdf0h7Cj7DjkP+IFhPZ4uzcfPHe5FRrWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WARZhiM7W4UymWYBltlNyK7Qw2ydlIo8
	XRx4HhhNGlrl8IcAvb/96/cqZids/XBn/FVEcq4SL1EUMkFE1whBKDa0JZ+ofjer
	kVDR15DE4Bo4xobQXz8PcOqKqcoz9KiH3h5sXQaKnVTYGNE4xoOZiYYYlcB2WmEk
	VYMW7/V3nic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A65F3B344;
	Mon, 11 Feb 2013 16:53:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B3BCB343; Mon, 11 Feb 2013
 16:53:53 -0500 (EST)
In-Reply-To: <20130211214948.GB19113@ftbfs.org> (Matt Kraai's message of
 "Mon, 11 Feb 2013 13:49:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 869BC0A2-7495-11E2-B1BF-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216098>

Matt Kraai <kraai@ftbfs.org> writes:

>> Assuming that this change is about building with expat1, it would
>> probably be better to do something like this instead, I would think.
>
> expat 1.95.0 through 1.95.8 used expat.h; should I still use
> EXPAT_VERSION = 1 to signify that it should use xmlparse.h, use
> EXPAT_NEEDS_XMLPARSE_H as Jeff suggested, or something else entirely?

Oh, please do not take it as a request to use that exact name (in
case you didn't know, I am bad at naming things).  It was merely an
illustration to show the direction, written without knowing that
Peff was essentially giving the same suggestion.

Thanks.

Oh, by the way, please do not deflect an attempt to directly send a
response to you with a Mail-Followup-To header.
