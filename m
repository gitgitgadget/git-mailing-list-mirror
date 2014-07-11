From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 11:29:28 -0700
Message-ID: <xmqqzjgf3g1j.fsf@gitster.dls.corp.google.com>
References: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com>
	<1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
	<xmqqion4543l.fsf@gitster.dls.corp.google.com>
	<1405096840.22963.8.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:29:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fZo-0003N7-DD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbaGKS3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:29:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56304 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbaGKS3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:29:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91CE026726;
	Fri, 11 Jul 2014 14:29:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M3I21gvOuf5e8qirfwS0LWa8gNU=; b=xOyqFZ
	cVcStZdoExCHbi6W/pPTSahRxi7AapG0I0G7gcM+S73kxGg25e8Oz8ADCDDJWmDM
	aaIyVHEwf/ApiueZy1cc4959jkbBlo1vwOzs38AmupQU8CZobYUgDnjwj1TxDyiD
	ZBIDCiwcBfgOajxkLM5ol92w71KxX/h6PDK3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bN/4khIovUAwQkAxu3UAJ979nxKm6dx1
	P/UU0XftgMvGuHXYA7vRx3iLe3c+NmvLr6af28oayZSPQAuJ60sJdrslePU6glIw
	Mz/rHaQqK260vcM5awhp2nnmSb4O7IjG7r9eN45ZIfufLRbgU8Bpsqg58LW+dea1
	bzHdiKjkO+w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87A9B26725;
	Fri, 11 Jul 2014 14:29:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4BC7266F3;
	Fri, 11 Jul 2014 14:29:14 -0400 (EDT)
In-Reply-To: <1405096840.22963.8.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Fri, 11 Jul 2014 16:40:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42E8E932-0929-11E4-B52E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253313>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> This is not how the rest of the current tests work. I will submit a
> patch which fixes up the current --sort tests (but not every test, for
> now) as well.

I do not want to pile more work that is unrelated to the task at
hand on your plate, i.e. clean-up work, so I would assign a very low
priority to "fix up the current tests".  At the same time, existing
mistakes are not excuses to introduce new similar ones, hence my
suggestions to the added code in the patch I saw.
