From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Mon, 04 Feb 2008 00:22:20 -0800
Message-ID: <7v8x21ku6b.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	<402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
	<7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
	<402c10cd0802040006yb654688l8dfc7140c507bc26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 09:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLwbd-00022U-6d
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 09:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbYBDIWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 03:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYBDIWf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 03:22:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbYBDIWe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 03:22:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EBE472961;
	Mon,  4 Feb 2008 03:22:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 720D32960;
	Mon,  4 Feb 2008 03:22:27 -0500 (EST)
In-Reply-To: <402c10cd0802040006yb654688l8dfc7140c507bc26@mail.gmail.com>
	(Sverre Hvammen Johansen's message of "Mon, 4 Feb 2008 00:06:09
	-0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72478>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> ...  However, it might take some time.  What is the
> time-frame for inclusion in 1.5.5?

The 1.5.4 cycle was too long (5 months).  A regular interval
ought to be about 3 months but I'd really like to keep 1.5.5
focused on obvious and unanimously supported changes that do not
impact the existing semantics deeply, and keep it shorter than
that.

I think it is too early to tell if this topic falls into that
category.  The patch is only a few day old, and there has been
no real discussion nor comments on it yet.  I also felt that the
backstory was lacking and it would be hard to judge for people
other than yourself how useful the new ff substrategies are in
what context.

The documentation updates talked about what the options do, but
it was unclear why they could be useful in what situations and
workflows.  At least it was not apparent to me on my cursory
read.

> --ff=never will turn this off together with fast forward.  Maybe we
> should have --ff=traditional that is the old behavior.

Sure, and I mildly suspect that it should be the default.
