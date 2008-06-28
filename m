From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug related to branches using / in name
Date: Fri, 27 Jun 2008 21:57:38 -0700
Message-ID: <7v7icakvgd.fsf@gitster.siamese.dyndns.org>
References: <1214509350.28344.31.camel@odie.local>
 <20080627030245.GA7144@sigill.intra.peff.net>
 <20080627035747.GC7144@sigill.intra.peff.net>
 <7vtzfemp4d.fsf@gitster.siamese.dyndns.org>
 <20080628041841.GA9451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>,
	git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 06:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCSWQ-0006jz-1B
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 06:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbYF1E5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 00:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYF1E5w
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 00:57:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYF1E5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 00:57:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0160F11171;
	Sat, 28 Jun 2008 00:57:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0EC891116D; Sat, 28 Jun 2008 00:57:40 -0400 (EDT)
In-Reply-To: <20080628041841.GA9451@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 28 Jun 2008 00:18:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0D209C6-44CE-11DD-A81F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86704>

Jeff King <peff@peff.net> writes:

> As as long your "equivalent of" means "branch -d"; we need to kill off
> both the ref and its reflogs. And therefore...
> ...
> The one key difference between rewinds and branch deletion is that the
> latter will kill off the reflog, making the history inaccessible. You
> can always still access rewound or rebased work via the reflog.

Hmm, you are right.

I somehow still had a vague distant memory from late 2006 when we did not
have reflogs for remotes/ hierarchy.
