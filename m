From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 11:49:24 -0800
Message-ID: <7vve721ikb.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	<20071213180347.GE1224@artemis.madism.org>
	<20071213180701.GF1224@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 20:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2u4Q-0007DP-3k
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 20:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbXLMTtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764688AbXLMTtr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 14:49:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbXLMTtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 14:49:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8196A79C0;
	Thu, 13 Dec 2007 14:49:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E69795F;
	Thu, 13 Dec 2007 14:49:35 -0500 (EST)
In-Reply-To: <20071213180701.GF1224@artemis.madism.org> (Pierre Habouzit's
	message of "Thu, 13 Dec 2007 19:07:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68187>

Pierre Habouzit <madcoder@debian.org> writes:

> The other issue is that when you had --abbrev=foo or --abbrev foo, the
> first one has to generate an error, whereas the second one should just
> say "foo" is not for me. The point being that the callback is not really
> aware of how the argument got assigned to it.

That obviously needs to be fixed ("this is the next token that could be
yours" vs "this must be yours"), if we were to go the route I suggested.
