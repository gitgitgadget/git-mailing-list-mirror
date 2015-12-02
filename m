From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Tue, 01 Dec 2015 18:27:08 -0800
Message-ID: <xmqqpoyp60w3.fsf@gitster.mtv.corp.google.com>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
	<5655D755.8060503@atlas-elektronik.com>
	<5655DAE7.2000008@informatik.uni-hamburg.de>
	<20151202005826.GE28197@sigill.intra.peff.net>
	<CAGZ79kZ8WLzwvsSPCgt4ncfqib479mXuDWQ5cLj0QjmZmR439g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	huebbe <nathanael.huebbe@informatik.uni-hamburg.de>,
	stefan.naewe@atlas-elektronik.com,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:27:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3x8X-0002T7-3I
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 03:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbbLBC1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 21:27:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757396AbbLBC1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 21:27:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3E4F30CB7;
	Tue,  1 Dec 2015 21:27:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bicClkP/Mq4xHIdwkpaQc1+4jms=; b=Ofk3Hy
	Waitnx7S6TlqVEC6fHhltDOeMuAmIyWmb5Din/hV4owluCqSs+fQQKoVwjMZ/aCl
	FKMgTQXeypQgHqsBIREkvkns3isipDuh910Em8ZD6cdp0CU03zH/y3kBdgdE6WF6
	wgzZy0NF/cXLt82sjbyN/dsEn11K1woNjHKUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VwlW99xG+9fo/+jsaTa3nEVLIj4uMX2S
	fT8k+dPVMw1XOFI6BHBhKfUv2tBwtd5CsgLhdWqM7ez/Lok+D3gjR6jcacplNww8
	euy7sM3nYowhNA3mQfbyxXCMAAqvoQfep+UmLNFs9ELkGxoQRl/vP+AHB2RGZm+r
	vyosjraU57g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DCDD430CB4;
	Tue,  1 Dec 2015 21:27:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58E2D30CAB;
	Tue,  1 Dec 2015 21:27:09 -0500 (EST)
In-Reply-To: <CAGZ79kZ8WLzwvsSPCgt4ncfqib479mXuDWQ5cLj0QjmZmR439g@mail.gmail.com>
	(Stefan Beller's message of "Tue, 1 Dec 2015 17:10:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3017403E-989C-11E5-9914-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281877>

Stefan Beller <sbeller@google.com> writes:

> Do we as the Git community have a place where we take notes for version 3?

I do not think there is, I do think we might need one when a need
arises, and I do not think this topic is one that creates such a
need.

And I said "might" in the second one, based on the experience at
2.0; we didn't need such a separate place when managing the
backward incompatible changes for that release.
