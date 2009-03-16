From: Junio C Hamano <gitster@pobox.com>
Subject: Re: undoing something
Date: Mon, 16 Mar 2009 13:11:04 -0700
Message-ID: <7v3addw7mv.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com>
 <7veiwxwa9z.fsf@gitster.siamese.dyndns.org>
 <450196A1AAAE4B42A00A8B27A59278E70A2AEFD7@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJAx-00062I-7s
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293AbZCPULN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756939AbZCPULN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:11:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023AbZCPULM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:11:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3442CA231A;
	Mon, 16 Mar 2009 16:11:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 126DFA2318; Mon,
 16 Mar 2009 16:11:05 -0400 (EDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AEFD7@EXCHANGE.trad.tradestation.com>
 (John Dlugosz's message of "Mon, 16 Mar 2009 15:48:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 96B1E31C-1266-11DE-A9C3-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113363>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> === Re: ===
> The answer was best only because in your previous question you wanted to
> ensure fast-forwardness, i.e. "git push . origin/dev:dev" without plus
> in
> front to cause it to fail if it is not fast-forward.
> === end ===

This is offtopic, but *PLEASE* notice that nobody else quotes like this
around here.  I find the style of quoting makes it unnecessarily harder to
skip over parts that others wrote (and I've already read---so I do not
want to waste my time on re-reading them) to get to what you are adding to
the discussion quickly, and extremely annoying.  It is the reason why I am
skipping many of your replies to other people without reading to the end,
even when I suspect you might be saying something worth reading.

> No, I don't want to ensure ff.

I was referring to the exchange that started with this message from you:

From: "John Dlugosz" <JDlugosz@TradeStation.com>
Date: Fri, 6 Mar 2009 14:04:25 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>

where you asked:

> I want to advocate running
> 
>         git fetch
> 
> as being a safe thing to do at any time, just to refresh your view of
> the origin and not mess up any of your local labels.  That is, you can
> see the difference between the local dev and the origin/dev.
> 
> So, after inspecting the changes, how do you fast-forward your local dev
> to sync up with origin/dev?

and I gave you an answer (with a typo you corrected in another message
today) "git push . origin/dev:dev".  In that context, you clearly want to
encure fast-forward, and local push without + is an easy and safe way to
do so.

That is where "it is best only because" came from.  If you are not
interested in ensuring fast-forward, "local push" may not be best, and
there are other ways (I've shown you at least two, so I won't repeat
them) to choose from.
