From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Mon, 08 Sep 2014 15:35:25 -0700
Message-ID: <xmqq38c1n3ki.fsf@gitster.dls.corp.google.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 09 00:35:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR7X5-0007eM-KV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 00:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbaIHWfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 18:35:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59911 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbaIHWfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 18:35:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F90C38739;
	Mon,  8 Sep 2014 18:35:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YoFUnN10cWyqZx0V0BxUWvZ8G7Y=; b=fU081z
	cidt1nbrv3+V/IH/spZNvbE5/ExEjHVt0moLtypnQE8dN53kYFpUCqHRncoR9fcw
	gav09MiUw2cdOO6NtH2eIpCIyGKqgVQ01fJYwGfGlGf9pX3P8bhbyDZlaBahvwmj
	hRgq7+U4S6S4Fnz6bKoRsq7Guhc5qMlBn/9d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHRQCz53VSCJe80xUhjBLf6Tnoccka6z
	87WifkCYopLDQIub3V92bsPF5dkJol8Bw0AvhSo8lfxGLADPfLbEYt/8cvrBOhxS
	XPoCU0L9UCCYm60udNWC+bCsiKMula9uCCdJAsuOnxqN3G1jgFPxFKT05NMfUN7v
	UhKHIe62Va8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC39638734;
	Mon,  8 Sep 2014 18:35:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1BB1238733;
	Mon,  8 Sep 2014 18:35:27 -0400 (EDT)
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sat, 6 Sep 2014 09:50:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E436154-37A8-11E4-9EDF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256680>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This series applies to the current "master". There is a trivial
> conflict between these changes and "next", and a few not-too-serious
> conflicts between these changes and Ronnie's reference-related series
> in "pu".

The conflicts weren't very pretty as rs/transaction* series
progressed, but I think I got something readable queued at the tip
of 'jch' (which is what I usually run myself and is at somewhere
between 'pu^{/match next}' and 'pu').

I'd appreciate if both of you can double check the result.

> I've figured out how to resolve the conflicts locally. Is
> there some form in which I can put the conflict resolution that would
> help you?

A public tree that shows a suggested conflict resolution, so that I
can try it myself without looking at it first and then compare my
result with yours, would probably be the easiest for both of us.  In
the worst case, I could fetch from such a tree, use rerere-train in
contrib/ and figure out any necessary evil-merges that are not
covered by rerere.

Thanks.
