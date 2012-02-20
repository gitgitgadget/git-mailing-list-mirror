From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 12:16:03 -0800
Message-ID: <7v8vjxl0qk.fsf@alter.siamese.dyndns.org>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
 <20120220010617.GB4140@sigill.intra.peff.net>
 <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
 <20120220135639.GA5131@sigill.intra.peff.net>
 <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
 <20120220154452.GA27456@sigill.intra.peff.net>
 <alpine.DEB.2.00.1202202002330.28090@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Nicolas Mailhot <nicolas.mailhot@laposte.net>,
	git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZeh-0001nM-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab2BTUQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:16:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290Ab2BTUQF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:16:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 182E16060;
	Mon, 20 Feb 2012 15:16:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2WbI3T0dNeai6TwfUjo4l9KrD2g=; b=BZ4jiS
	ESYnQ0+jGf8Pn/PTsK1HgCoejXwNr8XajvF1PGgjKSIwOAWz6BBND0NM4Zgx3FBN
	AP6VKoWffb/ioWc8SIYIt4zIBXjth5UNGmAlsadxmHBbqnZGmLxg3i9y0EjNZqGG
	UIc79C74Zk01y/OWo858/Bgk0HvwEzlFuaSBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHOd0Jrxusa7gE1DAFsb04G3p3ouPsow
	nIbcGNF3eh38GhuRm+cH/SoUZHQ47QdSppfLyfhI1pcP+dkZ2nh+VExu7Qt9w7z1
	Qqy+x0RWEGV623EqF2LwfqO+9vNbYDRRjVcqLg7EI7ICo7ibQZeve0/igJsnOmsd
	On+Pu0wfbBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB2B605F;
	Mon, 20 Feb 2012 15:16:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9215B605E; Mon, 20 Feb 2012
 15:16:04 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1202202002330.28090@tvnag.unkk.fr> (Daniel
 Stenberg's message of "Mon, 20 Feb 2012 20:06:46 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B731C126-5BFF-11E1-A07D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191098>

Daniel Stenberg <daniel@haxx.se> writes:

> As a git user, I would probably be very surprised if using 'git'
> suddenly caused by browser to pop up a captive portal login. I would
> prefer git to instead properly explain to me that is being the victim
> of a 511 and what I should do to fix it.

I agree what you envisioned, nothing more, nothing less, is the ideal
solution.

Thanks.
