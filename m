From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] more terse push output
Date: Mon, 05 Nov 2007 13:14:43 -0800
Message-ID: <7v7ikwpf7g.fsf@gitster.siamese.dyndns.org>
References: <20071105050517.GA6244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9Ho-00085H-7O
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXKEVOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbXKEVOw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:14:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50964 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbXKEVOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:14:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F3D932F0;
	Mon,  5 Nov 2007 16:15:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FB6B928B4;
	Mon,  5 Nov 2007 16:15:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63552>

Jeff King <peff@peff.net> writes:

>   - the 'ref is not up-to-date, maybe you need to push' message has gone
>     away in favor of the terse '[rejected] ... (non-fast forward)'. I
>     know there was some discussion recently of enhancing that message.
>     Is this perhaps too terse?

I kind of like this part.

I also like the part that stops mentioning the "pretend fetching
back" action.  This would mostly parrot the same set of refs for
people who do use the tracking branches anyway.
