Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 9758 invoked by uid 107); 4 Oct 2009 09:59:37 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 05:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbZJDJzA (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbZJDJzA
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 05:55:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZJDJy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 05:54:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B35FB4BAC5;
	Sun,  4 Oct 2009 05:54:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=c2rus2iRZEac4lLS+705RQGzeLU=; b=hPLSgABISAHg4Fo00Fb9Q8c
	aeVr7MOn71sYxdF04r16NocvPl7CBMhALKgYrVfJchrmwBkE0dlLLeE7Ru0irpz0
	S9MzaqxaZb+SksQ/HY/c5tfQyEU0JRrJAqrZihKM5b/GnXdxfX5o9DjdMxzqMuGt
	37PtQIAVQ75SN6qwQgoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Nynx3oEzArJqUgyftXh1Q+cCN1uSIypzHMctxdxX1xMFDEAra
	545KOGaI4u/LY7ERtLHR8yqR6EOLf7ikNiz7SZw7SF/TW7+qX3t1NJE+PjkmU5Vg
	UQONzF8IHCHcRIKp5ujqSS54jrKby0dlj3E8nxVb6yJiwTQfRxNxyRzF/o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BE594BAC4;
	Sun,  4 Oct 2009 05:54:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE2254BAC2; Sun,  4 Oct
 2009 05:54:09 -0400 (EDT)
To:	Jeff King <peff@peff.net>
Cc:	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Subject: Re: Interim maintainer tree
References: <20090925160504.GW14660@spearce.org>
 <7viqevu1zt.fsf@alter.siamese.dyndns.org>
 <20091004064129.GB7076@coredump.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Sun, 04 Oct 2009 02:54:08 -0700
Message-ID: <7viqevpjr3.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: DF17EEA4-B0CB-11DE-902C-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For my stuff, I think you can just take over my tips. I was just
> collecting and polishing topics, while Shawn was doing integration. For
> topics I have, please use my versions rather than applying from the
> list; many of them have extra fixes squashed in, acked-by's collected
> from the list, etc.

Many topics Shawn merged to his 'pu' were identical to what you have,
except for mr/gitweb-snapshot.  The patch-ids in the series are the same
but you have Jakub's Ack added, so I'll pick yours up and rebuild.

> Here's a brief status report on what's in my tree:
>
>   proposed-master
>     One-off patches that I think should go straight to master.

I briefly looked at them after looking at what Shawn queued to his
'master'; they all looked sane.

>   ef/mscv-noreturn
>     This is the latest round and I think should be ready for at least
>     'next' (maybe even 'master' as it is really about the build and not
>     about functionality).
>
>   ef/msys-imap
>     This is from an RFC which has generated some comments. He should be
>     posting another round soon. 'pu' at best.
>
>   fc/mutt-alias
>     Latest round that addressed comments. Ready for 'next' if not
>     'master'.
>
>   jn/gitweb-patch
>     After some comments with Jakub, I think the code is right but he
>     promised a re-roll with more in the commit message.
>
>   mr/gitweb-snapshot
>     This is probably the pu rewind you saw. He posted a v5 of his
>     series. I didn't look at it closely, but Jakub ack'd it.
>
>   tf/doc-pt-br
>     Minor translation update, ack'd by somebody who can read it. :)
>     Ready for 'master'.

I've queued all of these to 'pu' for tonight as I haven't still fully
recovered yet from jetlag, but I agree with the above assessment.

> There are a few patches floating on the list that I haven't picked up or
> looked too closely at yet. Just so we don't drop anything, they are:
>
>   - curl http auth tweak:
>     http://article.gmane.org/gmane.comp.version-control.git/129455
>     The author said he didn't really test it, and I haven't set up http
>     auth to test it with, but probably somebody should do so before
>     applying. :)

Heh ;-)

>   - a new rev-cache from Nick

What Shawn had in his 'pu' had one patch removed from what I had earlier
(perhaps my 'tip list' was faulty).  I'll pick the new one up later.

>   - silence gcc warning:
>     http://article.gmane.org/gmane.comp.version-control.git/129485
>     The warning is overly cautious, I think, but it is a dubious enough
>     construct that it is probably worth fixing.

I cannot reach gmane now, but if this is about -Wextra, I'd rather not
touch it before the release.  "comparison between signed and unsigned"
tends to be excessive and IMNSHO it is crazy to use -Wextra and -Werror 
together.

>   - enable openssl on msvc
>     http://article.gmane.org/gmane.comp.version-control.msysgit/7238
>     This goes on top of ef/msys-imap, but I think that will be getting a
>     re-roll.

Ok.

Thanks.

