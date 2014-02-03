From: Junio C Hamano <gitster@pobox.com>
Subject: Re: splitting a commit that adds new files
Date: Mon, 03 Feb 2014 10:11:34 -0800
Message-ID: <xmqqioswf4mh.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
	<xmqqzjm9fkk4.fsf@gitster.dls.corp.google.com>
	<20140202231110.GC16196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 03 19:12:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAO08-0002h9-GU
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 19:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbaBCSMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 13:12:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbaBCSL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 13:11:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4D4269533;
	Mon,  3 Feb 2014 13:11:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EsgXVTAYbeR7fE1ZeMKQZVp3Cho=; b=gcKesa
	R41A69/1/t8AYJN+9N058+Njac4CLPajok9W7sz+nwE7TiN4cQ4AtLtI0iWVJQQX
	yWlFyyO1DXoAWM2gbnnaPCNGzkfDrlOXfx3mSXZpprV7558kScEELVbvRQsVzAX7
	M/P2Y92APJF5v1yJkthU1IX7t6yd+uFvkXsyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rM99IcMmgMWG+kLtVVerog2ZQ+mksL2M
	f9ql2Eh/rjPSPkzywiDsDYg8eOVr+4Ub2dIwD2VheUakvcYDmGTnqunTv/YdPzVq
	QPyJpUEwmF6gWJBWtDvmBAvD07tifPtkksLafevrlrjXz1gVpOT9ODSG6kYWl38g
	hx/hJ1Gpq+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C0469532;
	Mon,  3 Feb 2014 13:11:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB0DD6952D;
	Mon,  3 Feb 2014 13:11:51 -0500 (EST)
In-Reply-To: <20140202231110.GC16196@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 2 Feb 2014 18:11:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7E733D6-8CFE-11E3-981C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241445>

Jeff King <peff@peff.net> writes:

> [1] I _do_ use "reset -p" when splitting commits, but I do not think it
>     is useful here. I use it for "oops, I staged this change, but it
>     actually belongs in the next commit. Undo my staging, but leave the
>     changes in the working tree for the next one".

Sure.  I thought that was exactly what Duy was attempting to do when
he splitted a commit into two (or more).
