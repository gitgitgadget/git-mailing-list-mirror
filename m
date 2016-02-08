From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git worktree loses path information after git reset --hard
Date: Mon, 08 Feb 2016 11:49:01 -0800
Message-ID: <xmqqh9hj7zki.fsf@gitster.mtv.corp.google.com>
References: <A1270C54-3868-42F4-8F7E-8F444631078F@eggers-club.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Daniel Egger <daniel@eggers-club.de>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:49:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSro5-0008OB-FA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbcBHTtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:49:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752617AbcBHTtD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:49:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE3444186F;
	Mon,  8 Feb 2016 14:49:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+kxLN6MJ978iCQw3WHszpPNQB44=; b=W/qH5T
	ERM5kD578HAWHc09wHPEgwZL0uirS7ATZymszk4lr+7mBv2/hV+K4NddSA6OL6sd
	lJP0knXf0sdxyu543JEayyqqL4dcb1Dtf4n4O0II/XEt879e3CRKlB7DI0cuiglG
	ODnayIjA/IFXqp5KLpq9aGMCcHZ39Eh2d8V9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vQ3tLRHystR5nrKzRK9q9jVYAQPaC5hr
	git9oB7HjJnuO7TJSBrllBg0O0CLa0hepEqEBKozlQrSeMrWDEk0fhEs5E1Wfa6V
	3FTig+mtclCH9JEh8wRSaMUpGrflUDwCNBfW//uXYORSeNpP3lV20UzBln8l5E7c
	NAiZuv3TWPM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B40CA4186C;
	Mon,  8 Feb 2016 14:49:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 356094186B;
	Mon,  8 Feb 2016 14:49:02 -0500 (EST)
In-Reply-To: <A1270C54-3868-42F4-8F7E-8F444631078F@eggers-club.de> (Daniel
	Egger's message of "Mon, 8 Feb 2016 09:07:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00BE1FEC-CE9D-11E5-9207-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285795>

Daniel Egger <daniel@eggers-club.de> writes:

> I stumbled across a problem with worktrees recently; I incorrectly
> opened a ticket a GitHub for that and it was suggested that it
> might be fixed in 2.7.1 so I held off reporting it here but as it
> turned out it is still broken in 2.7.1 so here we go.

Instead of holding off, report them early after checking the list
archive to see if it is already resolved.  You may be asked to
verify the proposed fix works for you with this and that patch, and
you can help us that way, too, in addition to your helping us by
throwing us a bug report.

I think the fix for this particular one is cooking in 'next' and
about to graduate to 'master' (hence hopefully it can be part of
2.7.2).

Thanks.
