From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Tue, 18 Feb 2014 11:52:55 -0800
Message-ID: <xmqqppmkdwq0.fsf@gitster.dls.corp.google.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093716.GE15720@sigill.intra.peff.net>
	<xmqqob32s08p.fsf@gitster.dls.corp.google.com>
	<20140124213521.GA26602@sigill.intra.peff.net>
	<9D08338A41454F778D03FB2E9F4B7DD1@PhilipOakley>
	<20140218085224.GB2692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:53:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqj3-0007ad-85
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbaBRTxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:53:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbaBRTw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:52:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 065C76D862;
	Tue, 18 Feb 2014 14:52:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGTcUElMiQs9lKHyWgu4qji1TZU=; b=ly6Qr2
	hU7PeGbntKZTqvt1krKEBpo5FjobbwoLHevKxbCiXlCPnME4fmMJHV/Z+a7sDdeK
	PnfnrFQoYXibE0qeFbhKSbLcMr3fm2p9gKKfP6L17qCItcJbRjbUTHM096s6aRj9
	ukfjL39lILCL8F0yFxUKC8SEtrjG1aB/s94+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTE6AgOwm7nIquD/nBmRAjStCyRl6agi
	+ClH14WCWRoIkOJ3E9UV11fV+ChAzN2SwyHSl8odFKUknBxX4Ns8o66CUJL0D+SB
	CWLWYKG2/g0utIH73YBpE6ABrGb4sVM4pTnL5EykMFTihTI/N645PHQzTvYiSyll
	8ChY+oegpv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD5526D861;
	Tue, 18 Feb 2014 14:52:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6151C6D85D;
	Tue, 18 Feb 2014 14:52:57 -0500 (EST)
In-Reply-To: <20140218085224.GB2692@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Feb 2014 03:52:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 437F267C-98D6-11E3-9EE1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242347>

Jeff King <peff@peff.net> writes:

> In that sense, "publish" is not the best word, either, as it describes
> only the first two, but not the third case (and those are just examples;
> there may be other setups beyond that, even).
>
> Perhaps "@{push}" would be the most direct word.

Hmph, then the other one would be @{pull}.

Which does not sound too bad, IMHO.
