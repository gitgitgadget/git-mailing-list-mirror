From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote-helpers: move tests out of contrib
Date: Mon, 21 Apr 2014 12:24:10 -0700
Message-ID: <xmqqy4yy8p0l.fsf@gitster.dls.corp.google.com>
References: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
	<1398029971-1396-3-git-send-email-felipe.contreras@gmail.com>
	<xmqq7g6ia5rr.fsf@gitster.dls.corp.google.com>
	<5355690fbe8ad_32c4849310d1@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 21:24:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcJpE-0001MA-CL
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbaDUTYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:24:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaDUTYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:24:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6077F47E;
	Mon, 21 Apr 2014 15:24:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rxdPWDH29Nhn3wDMIxgfjQxJX0Y=; b=HL8IZE
	TP8pHXhJMujK83BhvDYxv7DCdJeCLtWAUlP/cCwkBajrtL6bgW7/8U+rf+hvyrZF
	fByy9xoRJtaaDvfSsMSpMPMSkBs7HUPyO9Xe0BkUl3sNZes0i+ksy+PCHwmakECK
	NCGhAQPSzNMHF8FtuQhQJLjQW8zCDn/UaTSIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uoktip7WHCsWAaZoj4lYnbfuiVAn6l/T
	7ZZ0VTelFVET+GLzVK9ynhnau6OONJ7Wg+iZzupyKVeX/QZy/mrGVkJ9F86kd8id
	2ehlCDyz38pgfl6vXZKQs3xHt+gMXCSQxHGbryytemlIhrq/FOYUF9mc3ByWlhYT
	pRcivGcHedo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB87A7F47D;
	Mon, 21 Apr 2014 15:24:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C81A7F47A;
	Mon, 21 Apr 2014 15:24:12 -0400 (EDT)
In-Reply-To: <5355690fbe8ad_32c4849310d1@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 21 Apr 2014 13:53:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 84D7C00E-C98A-11E3-B5B0-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246623>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> This step needs a bit more work, I am afraid, to at least have these
>> three test scripts follow the same numbering scheme.  Especially given
>> that there were recent discussions on allowing a range of tests to
>> be run (or omitted) via notations like "5000,5020,9800-9812", not
>> doing so now will make it harder to implement such an enhancement.
>
> I don't see how such an enhancement would be beneficial to these remote
> helpers.

Why are remote helpers more special than other parts of the system?
Do they _have to_ be different and special?

> For starters there aren't any number rages left for them,...

Wouldn't "5 - the pull and exporting" be an obvious space for them,
especiall somewhere after 5800?

> There might be other practical reasons to use this numbering scheme (although
> I'm sure the scripts could be fixed to not assume those),...

;-)  Yes, as long as you can program it, anything is possible.

>> Can we squelch these expected import error messages?
>
> Sure:

Then I'd expect a reroll, at least to 2/2 (I do not think I saw
anything iffy in 1/2).

Thanks.
