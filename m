From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: Configurable prefixes for git commit --fixup and --squash
Date: Thu, 03 Mar 2016 09:23:14 -0800
Message-ID: <xmqq7fhj327x.fsf@gitster.mtv.corp.google.com>
References: <CALHmdRz3ffgifH2BZK14B=4LGFqOeTWpRarD+RAFx8AtwwMidg@mail.gmail.com>
	<20160303132128.GE1766@serenity.lan>
	<CALHmdRwgDjRJMQSPzp34aS25ZHg-mr458QeyYgyp85q8g34Aig@mail.gmail.com>
	<vpq1t7rlfi1.fsf@anie.imag.fr>
	<CALHmdRwZCb7LnQcKkdy-wNx5Ree+FcMPz2ykqVnTTq_SPDR_HA@mail.gmail.com>
	<vpqvb53ij45.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martine Lenders <mlenders@riot-os.org>, authmillenon@riot-os.org,
	git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:23:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abWy9-000342-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 18:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbcCCRXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 12:23:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752052AbcCCRXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 12:23:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7E5747C55;
	Thu,  3 Mar 2016 12:23:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P3J2x1NNX2aGbcDUCwvobpbEe64=; b=N+oDbN
	w7Ll43aX14npycZdTOkby3hBQaJo1IBIrzbvl4HMw6vLFGi+m3a9WTVSK6v6Ch4K
	8V9PCetN7NqsbyfhQLQzH9dwv9vbWxRWXUFKu4JwzQz6I2KiUTQkRYt08GpSzIcU
	D1sL6/PJV+y6efz+uv1AXqcQs967SZ5fE9RFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uln6AgW0VCeMDI1yI7/74RYRJlf1U3rZ
	2bY7PI0kMulBkEmIxm8LUqZiLCfX6lxWV4dBDX6MXvHQ28wgnQ+k+vaSiGoygyEb
	t6PrYY9e5D1o0xzJrtxhhjdehe6nw2czrTvgb664eivQWn1hmnjZGIDO87ukDtLj
	gdWGxxTZyVM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD2FE47C53;
	Thu,  3 Mar 2016 12:23:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 352F647C52;
	Thu,  3 Mar 2016 12:23:15 -0500 (EST)
In-Reply-To: <vpqvb53ij45.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	03 Mar 2016 18:09:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D146B92-E164-11E5-BFE6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288193>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> We don't have "procedure" for feature requests. It happens often that
> someone dreams aloud like I did above, and it's OK as long as "it
> shouldn't be hard to implement" is understood as "one day I should do
> it" and not "hey, you lazy devs, why don't you code that for me?" ;-).

;-)

> I may get some students to work on this in May, or do it myself one day.

I envy teachers who can say "hey, code this for me if you want
course credits".
