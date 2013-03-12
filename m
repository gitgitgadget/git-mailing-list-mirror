From: Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 15:00:24 -0700
Message-ID: <7vli9s5ldz.fsf@alter.siamese.dyndns.org>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
 <alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
 <20130312041641.GE18595@thunk.org>
 <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
 <20130312212027.GE14792@thunk.org>
 <CA+55aFwHJtOU4Qzt3XZsER165kTc5P0ATQP2wPHvuUiVic8bnA@mail.gmail.com>
 <7vppz45lz9.fsf@alter.siamese.dyndns.org>
 <CA+55aFzWjfFjcRZXBO+edO7f66REA0pOsC3iZ2vYdHrkcovnHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-next-owner@vger.kernel.org Tue Mar 12 23:00:53 2013
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1UFXFc-0003Ox-70
	for glkn-linux-next@plane.gmane.org; Tue, 12 Mar 2013 23:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab3CLWA2 (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Tue, 12 Mar 2013 18:00:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190Ab3CLWA1 (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Tue, 12 Mar 2013 18:00:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD717B6C6;
	Tue, 12 Mar 2013 18:00:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S9DAS2z3DH4p/pyGS/N+v3Mq86M=; b=a99YNj
	kuS+n/6EbPaS3U10ZILn6v1SHG/NQrB8Y1VrsMxY3d0mty/9SSIGU8F89vTuR/OY
	uNhq7YYnx3xwTMhUCLn3PDuCeF93PB7XzWwo7BmHnJB1gf/hTr2JljwWzEojZ45M
	0lcPhzkom1S6u5xZGSUhNFdho9VBH65hRlcK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aeU6sCReqUNhldTTaeKRWEODHOa+VcUa
	PGB8BMwTGwnj+1qJ1FM0HUEpNDD1RF0424TME3+0i4KESv5XVsIb1g1MlbxdjGYV
	SENM9p6ijGHdqBYe9DMCdnZYFOu6jlmqm7gpVsE5cBAjiIYqugZ2rJzkLfNJ+IjU
	j7O4MCfzfk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1E91B6C4;
	Tue, 12 Mar 2013 18:00:26 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A437B6BF; Tue, 12 Mar 2013
 18:00:25 -0400 (EDT)
In-Reply-To: <CA+55aFzWjfFjcRZXBO+edO7f66REA0pOsC3iZ2vYdHrkcovnHA@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 12 Mar 2013 14:54:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EC4677A-8B60-11E2-8FD2-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218002>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, adding the signature from an upstream tag doesn't really
> seem to be hugely useful. I'm not seeing much of an upside, in other
> words. I'd *expect* that people would pick up upstream tags
> regardless, no?

Yes, their "git fetch" will auto-follow, but mergetag embedded in
the commit objects will give the history auditable trail the same
way as the merges you make your downstream.  You of course could
match out-of-line tags against back-merges and verify your merges
with mergetags, but you do not have to.
