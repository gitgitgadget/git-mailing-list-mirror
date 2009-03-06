From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch and pull
Date: Fri, 06 Mar 2009 14:21:50 -0800
Message-ID: <7v7i32s35t.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
 <m3iqmmidlf.fsf@localhost.localdomain>
 <7vd4cus7ez.fsf@gitster.siamese.dyndns.org>
 <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>, <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:23:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfiS4-0000ZB-8B
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbZCFWWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755908AbZCFWWD
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:22:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbZCFWWC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:22:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 10E842C75;
	Fri,  6 Mar 2009 17:21:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2977E2C70; Fri, 
 6 Mar 2009 17:21:52 -0500 (EST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com>
 (John Dlugosz's message of "Fri, 6 Mar 2009 17:11:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 34DAE3BC-0A9D-11DE-8749-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112485>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> Here is what I'm "cooking":
>
> ======excerpt======
>
> To keep apprised of other people's work, including updates to the main
> dev branch, start the day with:
>
> 	git fetch
>
> This will update your "remote tracking branches", letting you see what
> everyone else is working on, and letting you see the central
> repository's dev (as remotes/origin/dev) compared to your own local dev,
> so you can see what has been added.
>
> This does not change your local dev, or any other branches you are
> using.  As for your own topic branches, you are the only one who changes
> them.  This is a perfectly safe command and can be performed any time to
> update your view of what's happening throughout the team.
> You will, in particular, see your local dev where you last left it, and
> the current remotes/origin/dev pointing ahead of it.  E.g.
>
> 	A <== dev
> 	 \
> 	  B--C--D <== remotes/origin/dev
>
> In this example, you see plain "dev" still pointing to A, and
> "remotes/origin/dev" pointing to D.  So, you can tell that B, C, D were
> added.  Review the nodes B, C, and D, by reading the comments and seeing
> which files were affected, and look deeper if it seems to affect what
> you are doing.  Finally, issue the command
>
> 	??? 
>
> And this will update your local dev to match the origin.
>
> ======

I already answered that question in a separate message (that is
different from what you are replying to), didn't I?
