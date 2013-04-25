From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 09:37:33 -0700
Message-ID: <7va9om5zxu.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
	<877gjrpsk4.fsf@hexa.v.cablecom.net>
	<CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
	<87li87awwc.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 18:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVPB5-0001qp-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964Ab3DYQhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 12:37:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758955Ab3DYQhh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 12:37:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79A5E19284;
	Thu, 25 Apr 2013 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pBUmRVHjJl9xPu6ptaYQua34PdQ=; b=Np4MVX
	OJpezzXunnZag+IrKdXMr9tJUEGjSLZtmgekxxOfCteaomYNcMLUKmQQ/iUw0b0t
	YOLFvXxoqjd8b9rxLJLz1ZPZGb/lHLUSB/Cg04lnytzc3KYNSXKSE1D/c3w+ZZLX
	RRKVrPrLzG3knjKGKMWnsWNEoOS1QmYicCB7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ADLzzM8Wg6qX2H8vqw5WIyX6OX85QWQE
	WKUv4z6yImtN1vpRs6xbme36VjvwH/m2lrQycCCg6kKHrEJouWuD0OBFSQopNVAU
	5g7GRQzCH2LTOdg93+rB/7leOruyAzzdzVBcWqLpXzeL40kGaR+51yfESQhGZeY0
	oLJ2kW12ADI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F05F19282;
	Thu, 25 Apr 2013 16:37:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF8B01927B;
	Thu, 25 Apr 2013 16:37:34 +0000 (UTC)
In-Reply-To: <87li87awwc.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 25 Apr 2013 09:32:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6EB8CE52-ADC6-11E2-AC4C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222392>

Thomas Rast <trast@inf.ethz.ch> writes:

> What's the problem with cooking it for a while?  You can start using it
> immediately.  I'm just somewhat annoyed that the syntax is rapidly
> converging to Perl-style line noise.

Not quite, not quite, and a mild agreement.

Adding an obscure feature that may not be useful at all behind a
command line option will fall into the "you can afford to cook for a
while, you can use it immediately yourself, nobody will get hurt"
category.  Adding a configuration to turn such a feature by default
on already is a more severe problem because we need to adjust and
protect scripted Porcelains from getting hurt by an unexpected new
behaviour user may trigger by setting such a configuration before it
fully cooks, which is annoying maintenance burden for an obscure
feature with an unknown value.

Piling cruft on syntax is in a totally different league.  If not
carefully thought out, adding a random new syntax on a whim can
paint us into a corner we cannot later get out of, like the ":/" we
recently discussed (which does have an escape hatch planned, but
imagine a world without one).

> I already hate half of the existing syntax, and I cannot remember using
> ^! (except while investigating what 'git diff C^!' does and why not),
> ^@, @{-N} (only the related 'git checkout -'), @{date} and @{relative},
> ^{}, :/foo, and ^{/foo}, *at all*.
>
> In fact I had to look up the second half of that list on the manpage.

I would have actually expected that people are more familiar with
the second half, i.e. @{2.weeks.ago}, @{4} and :/string, than ^!/^@
which I agree were more-or-less "let's add a random cruft on a whim
without thinking things through" mistakes.
