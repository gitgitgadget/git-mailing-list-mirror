From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Explicitly adding ignored files in subdirectories not working
Date: Sat, 27 Feb 2010 08:58:21 -0800
Message-ID: <7v4ol239aq.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com>
 <20100224045958.GA2385@coredump.intra.peff.net>
 <fabb9a1e1002270459h55fbd1c0o509106e035402810@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:00:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlQ1h-0008RC-0x
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 18:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621Ab0B0Q6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 11:58:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030610Ab0B0Q6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 11:58:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 988F89DC85;
	Sat, 27 Feb 2010 11:58:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZWNZpYyr1C3hf2S2hmuoTaEOyI0=; b=MmZBQL
	/LI9+Jvw5mK1Fxj4phbOMq007qDnQkxvo6jYpuPUM9nNGqhskQVdiSrV3tWZ6pzf
	9e+sZqaJbWCvhW8etqLqu3fTjxT2H2nt9afe2qjJQwDgQKnlgaBA6l2UrE8oQNoC
	KzWmwfqF6YKTMhQhxCdBFTpH/aumW130WrQZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fjGHkCUxqsEOzsC9jnFFrq9TjHonNEof
	Sk8mT1moaUayfv5PqViFrhCtA0IXwHR/s+0iYQoLzUxr7SWalEfHhkOzSNEhBXrA
	omyVKiG2jB6JC9Y7XmzjgEIrlUiPy5eirVD0RYGTTTrSaGvY+ROAkUiloHYfGF1+
	K1PuIg30flI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 638179DC83;
	Sat, 27 Feb 2010 11:58:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9E629DC7F; Sat, 27 Feb
 2010 11:58:23 -0500 (EST)
In-Reply-To: <fabb9a1e1002270459h55fbd1c0o509106e035402810@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 27 Feb 2010 13\:59\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5312947C-23C1-11DF-9EF6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141217>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> http://thread.gmane.org/gmane.comp.version-control.git/140405
>
> Peff, IIRC from that thread was left to die with you handing over to
> Junio? Junio, do you intend to investigate what's going on there?

The thread is still in my inbox but haven't had a chance to allocate
enough time to look at the issue yet.
