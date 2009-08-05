From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is
 given
Date: Wed, 05 Aug 2009 13:39:31 -0700
Message-ID: <7vhbwm0zcs.fsf@alter.siamese.dyndns.org>
References: <20090805201937.GB9004@coredump.intra.peff.net>
 <20090805202326.GC23226@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnH4-0000y7-Lz
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbZHEUjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZHEUjm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:39:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZHEUjm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:39:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C94C1226A4;
	Wed,  5 Aug 2009 16:39:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DB974226A3; Wed, 
 5 Aug 2009 16:39:33 -0400 (EDT)
In-Reply-To: <20090805202326.GC23226@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 5 Aug 2009 16\:23\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1AC092DA-8200-11DE-A347-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124972>

Jeff King <peff@peff.net> writes:

> When --quiet is given, the user generally only wants to see
> errors.

That does not match what my cron job at day job expects.

I'd welcome the warm and fuzzy feeling of seeing "ah, yes, we had changes
on those branches to push out last night".

Maybe it is just me, but my gut feeling is that it would be more
appropriate to squelch only "already up to date" refs at least, at the
default level of quietness.
