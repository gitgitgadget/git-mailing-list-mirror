From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7300: mark test with SANITY
Date: Tue, 03 May 2016 14:19:24 -0700
Message-ID: <xmqqk2jalu03.fsf@gitster.mtv.corp.google.com>
References: <1462301672-20866-1-git-send-email-sbeller@google.com>
	<20160503190417.GD30530@sigill.intra.peff.net>
	<xmqqmvo7lz5f.fsf@gitster.mtv.corp.google.com>
	<20160503211528.GA32737@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	janx@linux.com, Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 23:19:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhjH-0000HI-Is
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694AbcECVT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:19:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756527AbcECVT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:19:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D16291842E;
	Tue,  3 May 2016 17:19:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Omun6I2jI+oCYpZLL4vk9Ka+rpk=; b=g8evF4
	vKpVnUs8OnORLELYTQMNKSZxAZ9B8fW2uQAyRUu0nmkDufVH0jxL1WhcZp7hxBUn
	OJUFGFwsJzgmC3Dqi4nerA5xtdCCEKFsUKdlMuqRLyYUvSS4qw9zeZUYJ2jymqRN
	RC2b2lQqQGNLBLSoXNwpoEfSR/M4v4FZfEVqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YUl3Ob1jYVPsRDSOvc4lDNTpfOha+l+W
	w2v2CWdeQ5G14Fcjthm8P+RrsOyYx38h7t/TtZYdI9xXjbaWSC6MC/+j5913k+Q8
	6fWoMJkD2rIjG5sObMDhJSjbvmDYtllWt5pGpqtkz/I+/e1YT/fuuFtfLMJM4zFx
	f2lGMgM+0zo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C88641842D;
	Tue,  3 May 2016 17:19:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 254FD1842B;
	Tue,  3 May 2016 17:19:26 -0400 (EDT)
In-Reply-To: <20160503211528.GA32737@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 May 2016 17:15:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6C5C79E-1174-11E6-8237-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293457>

Jeff King <peff@peff.net> writes:

> Maybe. I admit to not really using the Travis tests myself, as they are
> way too slow and cumbersome to debug compared to just running "make
> test".  The primary value to me of centralized CI is:
>
>   1. _If_ people are looking at PRs on GitHub, the test status is shown
>      right there in the PR, without a reviewer having to wonder whether
>      the submitter ran "make test". But since I don't ever look at PRs
>      for Git, that's not helpful.

What I was hoping was that bots like SubmitGit could look at that
status.

>   2. Quicker testing on a variety of platforms that I don't have.
>
>      ... I think
>      there was some discussion in the 0day thread elsewhere on the list,
>      but I didn't follow it too closely.

Yes, I'd love to see it happen some day.

> Anyway, back to the original question. I do think "test as root" can be
> considered another platform, which makes it a good match for CI. But at
> the same time, I don't know that it has ever surfaced an actual bug in
> _Git_, and not just the test suite. So seeing those bugs quickly is a
> lot less interesting.

True.
