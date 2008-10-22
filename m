From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-i-p: only list commits that require rewriting in
 todo
Date: Tue, 21 Oct 2008 22:48:18 -0700
Message-ID: <7vwsg1uqn1.fsf@gitster.siamese.dyndns.org>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com> <20081020115003.GA11309@coredump.intra.peff.net> <7vej2a3kl5.fsf@gitster.siamese.dyndns.org> <20081022000113.bacc1923.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 07:49:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsWbK-0006UV-Eq
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 07:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbYJVFse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 01:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYJVFse
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 01:48:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbYJVFsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 01:48:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74C3272F84;
	Wed, 22 Oct 2008 01:48:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B2AD72F82; Wed, 22 Oct 2008 01:48:25 -0400 (EDT)
In-Reply-To: <20081022000113.bacc1923.stephen@exigencecorp.com> (Stephen
 Haberman's message of "Wed, 22 Oct 2008 00:01:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F62B98A-9FFD-11DD-AB7A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98829>

Stephen Haberman <stephen@exigencecorp.com> writes:

> Looks good--I applied this locally and it passes t3404, t3410, and
> t3411. Do I need to do anything else with this, e.g. resubmit/append on
> top of the previous series, or do you have it taken care of?

I've queued it on top of your series and merged the result in 'next'.
Further improvements should be done the same way.

> I will be bullish about the use cases I'd like to see work (these
> preserve merges tweaks and the config setting for `git pull`), but
> humble about my patches. This one especially is not elegant, it just
> passes the tests.

That's perfectly fine.  We can start from sound ideas (the behaviour we would want
to see) and incrementally improve the implementation.

Thanks.
