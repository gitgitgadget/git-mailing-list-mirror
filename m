From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] encoding problem with format-patch + send-email
Date: Fri, 16 Nov 2007 16:48:37 -0800
Message-ID: <7vlk8xwvbu.fsf@gitster.siamese.dyndns.org>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com>
	<20071116104907.GA13087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>,
	git@vger.kernel.org, Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 01:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItBrv-00058g-W6
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 01:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761968AbXKQAsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 19:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762974AbXKQAsv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 19:48:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60135 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbXKQAsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 19:48:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 627862F2;
	Fri, 16 Nov 2007 19:49:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CBA1B96925;
	Fri, 16 Nov 2007 19:49:03 -0500 (EST)
In-Reply-To: <20071116104907.GA13087@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 16 Nov 2007 05:49:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65259>

Jeff King <peff@peff.net> writes:

> git-send-email: add charset header if we add encoded 'From'

Thanks.

> If we already had a content-type header in the mail, then we
> may need to re-encode. The logic is there to detect
> this case, but it doesn't actually do the re-encoding.

Although the charset on rfc2047 encoded header fields can be
independent of the charset in the body, I think you need to do
crazy things to do so.

Will queue.
