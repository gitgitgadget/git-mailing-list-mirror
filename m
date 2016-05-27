From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2016, #08; Thu, 26)
Date: Thu, 26 May 2016 19:11:55 -0700
Message-ID: <xmqq60u0tfkk.fsf@gitster.mtv.corp.google.com>
References: <xmqqeg8otowp.fsf@gitster.mtv.corp.google.com>
	<20160527003621.GB26262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 04:12:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67Fr-0008M5-QX
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbcE0CL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:11:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932104AbcE0CL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:11:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB3611EDF5;
	Thu, 26 May 2016 22:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p1NHzGuhdQawY3W1/L6UQagIlwE=; b=avmKvM
	ceRuWY48KiLsEArCij1B8dTI1kwA4Zqio2o+uFaCS1H7go1fdA9i+yIDBkiTH5/e
	cYKcgYZWmoSvspMNdBZYIRhek5BE/YNE1qqdcYP21DhefdUgFUjaLUfJ0dAGuQ89
	XWItbf3+TI3PS8KUpDx/ZctcDXJKeLwcvEmNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TMI1wXtNuL6UGwnPWzaIpBJK9cT7Icnz
	iE2NU+Rk+W2cBbielD6u7ntDkRJIt/l7ZxMWbELRealUpKgAK44Hz3D/rUbjdhlv
	2fpy5ba74KdjYJO18gLUwDapfvsoRVFGNeXBO4mWO/2rV44AZKzU0Fv0Nf2L1U6Q
	hBFvKB03IbQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F4611EDF3;
	Thu, 26 May 2016 22:11:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FAA31EDF1;
	Thu, 26 May 2016 22:11:56 -0400 (EDT)
In-Reply-To: <20160527003621.GB26262@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 20:36:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 636E48C0-23B0-11E6-81FD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295708>

Jeff King <peff@peff.net> writes:

> I just sent a replacement for the fourth patch that avoids the t/helper
> problem. It's probably worth dealing with before even hitting "next" so
> as not to break bisection.
>
> You should probably hold off on merging the top one. The discussion
> stalled because I was on vacation, but it has resumed now (the earlier
> refactoring bits are uncontroversial, I think).

Thanks, will do both.
