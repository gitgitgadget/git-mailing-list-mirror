From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch and pull
Date: Fri, 06 Mar 2009 11:27:49 -0800
Message-ID: <7vljrisb7u.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 20:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lffjb-00039V-17
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 20:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbZCFT16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 14:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbZCFT16
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 14:27:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbZCFT15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 14:27:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 717399F1A4;
	Fri,  6 Mar 2009 14:27:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 657A59F198; Fri,
  6 Mar 2009 14:27:51 -0500 (EST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
 (John Dlugosz's message of "Fri, 6 Mar 2009 14:04:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3F909DC-0A84-11DE-93A1-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112476>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> I've gotten the hang of git well enough to pretty much bang on it until
> I achieve what I wanted to happen, though maybe trying a few things and
> recovering from mistakes or taking the long way around.
>
> Now I'm putting together a cookbook for our team, to allow use of topic
> branches rather than treating it simply as a faster SourceSafe.
>
> I want to advocate running
>
> 	git fetch
>
> as being a safe thing to do at any time, just to refresh your view of
> the origin and not mess up any of your local labels.  That is, you can
> see the difference between the local dev and the origin/dev.
>
> So, after inspecting the changes, how do you fast-forward your local dev
> to sync up with origin/dev?

$ git push . origin/dev dev
