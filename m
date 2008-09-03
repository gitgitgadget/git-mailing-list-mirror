From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 03 Sep 2008 01:07:59 -0700
Message-ID: <7vljy9d540.fsf@gitster.siamese.dyndns.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <200809022339.20123.johan@herland.net>
 <20080902214428.GA20355@sigill.intra.peff.net>
 <200809030945.08619.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Stephan Beyer <s-beyer@gmx.net>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 10:11:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KanQb-0000VL-8a
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 10:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbYICIIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 04:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbYICIIM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:08:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYICIIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:08:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 95E05724E4;
	Wed,  3 Sep 2008 04:08:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8F9EF724E2; Wed,  3 Sep 2008 04:08:00 -0400 (EDT)
In-Reply-To: <200809030945.08619.johan@herland.net> (Johan Herland's message
 of "Wed, 03 Sep 2008 09:45:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 72409F3E-798F-11DD-B4E3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94759>

Johan Herland <johan@herland.net> writes:

> It seems to have been suggested (in various forms) by several people and 
> generally well-received in the original thread, but nothing seems to have 
> come of it (at least nothing that has survived till today).

You are masochistic enough to have noticed that people were talking about
the safety in the context of "HEAD lacks its own reflog"?  Yes, we had
reflogs on each refs/*, but HEAD itself did not have one.

The situation has changed --- HEAD has its own reflog these days, which
not only helps this particular issue but is useful in contexts that never
involves a detached HEAD.
