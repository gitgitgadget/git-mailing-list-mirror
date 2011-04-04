From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Mon, 04 Apr 2011 11:09:00 -0700
Message-ID: <7vwrj999dv.fsf@alter.siamese.dyndns.org>
References: <201103260141.20798.robert.david.public@gmail.com>
 <20110328142121.GB14763@sigill.intra.peff.net>
 <201103301739.12691.trast@student.ethz.ch>
 <201104040943.10030.robert.david.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robert David <robert.david.public@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:09:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6oDY-0000R6-0O
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 20:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab1DDSJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 14:09:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab1DDSJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 14:09:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3649848F8;
	Mon,  4 Apr 2011 14:11:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nGh0M3TJD0B4oLmtwT15+n0qeck=; b=vcxBPn
	9/L5KxPN6JgF6+hoAYuFoIoIhNazCsf8GfjPMHDzMpny/5M93x7jixYK84931fi7
	QsPzaZ6kJmZQhjQFz16yclUjN5eYw5JOKUxh9LMnMqxiST0uwJjKTQs/Zmi4ZhsO
	HjMjXtCnSvWRmREFf31n5JoxNnfGNh3XtIc1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jjDGuNdgtS8sjN2ccJXWu640L2io7Oxl
	VAKYkcbWMuvqySy0uuvWIol4hsm6xytq/HunGpz1/t64rg8HDKxxB2NhIVaGD8et
	KZcM70ihsb6pFEtZSKM2AwBljuRUuQetK5UbcPAI+7h2jqwHmM9QdLi6ajs8KrrD
	L4A/FwhVPso=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8D1548F6;
	Mon,  4 Apr 2011 14:11:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 49DEE48EE; Mon,  4 Apr 2011
 14:10:55 -0400 (EDT)
In-Reply-To: <201104040943.10030.robert.david.public@gmail.com> (Robert
 David's message of "Mon, 4 Apr 2011 09:43:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9A7D512-5EE6-11E0-8565-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170829>

Robert David <robert.david.public@gmail.com> writes:

> 1) Pre-coding time
> 2) 1-3 week
> 3) 4-5 week
> 4) 6-7 week
> 5) 8-11 week
> Extend the C code to the state it should be.
> Adopt other git commands to work with the new interface correctly.
> Test extensively.
> Update documentation where needed.
>
> 6) 12 week
> Write more documentation, to document what was done and how.
> Correct bugs and test.

I am afraid to say that the above schedule is too ambitious and does not
leave any time for reviews and re-rolls.  Please keep in mind that
historically patch series by more experienced contributors of substantial
size (comparable or even smaller scale than the topic you are proposing)
all typically took three or four review-reroll cycles, if not less, and we
don't automatically get extra review bandwidth just because GSoC is going
on.

I am starting to suspect that it might make sense to say "as far as GSoC
participation is concerned, we would call a topic "merged upstream" when
it hits 'next', even if it is not ready for 'master' at the end of the
term".

What do regular reviewers and potential mentors think?  Perhaps we have
more stringent quality requirements than other open source projects that
take "commit first, review and fix as necessary" cycle, and they may
declare success when "commit first" happens.  If that is the case, 'next',
whose definition is "without glaring design and implementation bugs and
fit enough for dogfooding, but needs extra polish", might be a better
success criteria to be fair for our students.

I am not in the mentor pool and I would rather not to be to stay neutral,
so I'll leave it up to the mentors.
