From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Sat, 12 Mar 2011 22:34:08 -0800
Message-ID: <7vsjuril5r.fsf@alter.siamese.dyndns.org>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
 <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com>
 <20110313030214.GB10452@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 13 07:34:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyesm-0005Os-L2
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 07:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab1CMGeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 01:34:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1CMGeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 01:34:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4FD34FFD;
	Sun, 13 Mar 2011 01:35:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=orRYGO5MVoURzVb2J1WVmH89h0Y=; b=utj2HY
	3D1qnf032ZVU5wRLB9t5EF7h0gWH4eK8NEv6masA3JIizKAtzjw/8a8KbAD39J7P
	GmBr7hKPM66Rt7fqNJUu0zrmYtca1D6TC6bOueFT0IwaVYE1MhkMrbqoiFabbB0v
	3Ewr2nFmNkKb49VYhyWwWefeHlsnG7LO8nZFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k7v7bC9vRCtIZQP7aZqtg2S5OzRhK+xF
	EoE4Pr68FJ7QBTLMjo5o4tEditMOVhvT73o0uFde0nL1ctFuauwtv1wS9B8ndVdI
	JgxpZjMzFrArUdnMihSr/5aG/zBPtRdw0BSmgB0eUi+d4AoCEWjIrbnM+yzP9jLQ
	LTt9BTuNNMo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 848D94FFA;
	Sun, 13 Mar 2011 01:35:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4329B4FF4; Sun, 13 Mar 2011
 01:35:42 -0500 (EST)
In-Reply-To: <20110313030214.GB10452@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 12 Mar 2011 22:02:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2160DC72-4D3C-11E0-A129-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168960>

Jeff King <peff@peff.net> writes:

> Yeah, I was tempted to put in explicit instructions but opted to keep it
> simple. I forgot about the credits listing at git-scm.com, though. Maybe
> this on top of my other patches?

Looks sensible.

I see you rebased your jk/doc-credits topic at GitHub but haven't queued
this one yet, so I won't be pulling, but give me a holler when the branch
is ready to be pulled into 'master'.  I'll then push the result out after
running final "make doc" check on a few platforms I have and eyeballing
the output.

Thanks.
