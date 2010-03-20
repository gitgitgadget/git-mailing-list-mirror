From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Sat, 20 Mar 2010 07:01:18 -0700
Message-ID: <7v634rqehd.fsf@alter.siamese.dyndns.org>
References: <m2tyswb1jp.fsf@igel.home>
 <7v3a0fr740.fsf@alter.siamese.dyndns.org> <m3r5nzw05p.fsf@hase.home>
 <ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>
 <m23a01yzcc.fsf@igel.home> <4B9F2DB0.30400@viscovery.net>
 <m2pr34kpzm.fsf@igel.home> <4BA07AEE.2080100@viscovery.net>
 <m2k4t8qgyh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 15:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NszFE-0002hU-Bx
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 15:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab0CTOBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 10:01:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0CTOBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 10:01:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BBC5A2202;
	Sat, 20 Mar 2010 10:01:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=biKh7uOy0va+9pda4U7BFzB2Aq8=; b=HkpWy3
	CxF1lSeZewJJ1HxwxCUMzvbFARsX1o7QRaie1zwtqzRM9gHMdxdT+lXZHTO8zpmG
	BRD+IqUWLpsXryRnf9YYA6Z/Sbdl23AH7URAHCne8366TzAGcSi0HINWTglE1jhi
	EvFqbjvQHWqIDjNcyAwb2dWXH+c2zaXaHt/6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYzfx2nGG3/6jDR18EJy7i0NlWWkyd6F
	JdKCPB/QX7BKKxnVELOw8sONjZRpH1mzpK42FaF4WcjirR8cV/37y/j5bPgVPJ/j
	+0ZBNuW8TFUcf2rw+P1hAdsDPr2e/TjdrZ/3J/OfhFo14HUX/DAXBaIGQzKJdQ86
	O3hYbowU4N0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E65EA2201;
	Sat, 20 Mar 2010 10:01:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D905A21FB; Sat, 20 Mar
 2010 10:01:19 -0400 (EDT)
In-Reply-To: <m2k4t8qgyh.fsf@igel.home> (Andreas Schwab's message of "Fri\,
 19 Mar 2010 19\:55\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11F9F7E6-3429-11DF-AD43-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142709>

Andreas Schwab <schwab@linux-m68k.org> writes:

> That's not what I see.

It could be version differences of AsciiDoc-to-xmlto toolchain.  I think
I've listed the versions I use (and the ones currently used to format the
copies people get from k.org) elsewhere in this thread.  If you are using
anything newer, perhaps we are seeing an issue waiting to materialize and
you are being a useful coalmine canary.

If the output you showed is the best we could achieve without using
constructs that break the versions that are older than what you used but
are still in use (e.g.  "[horizontal]" and "three-colons"), I would say we
have to live with it.  It might be suboptimal but it still is readable.

Of course if you can come up with a patch that formats better without
breaking older tools, that is an entirely different story.  It would be
very much appreciated.
