From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Use regex for :/ matching
Date: Wed, 05 Dec 2007 22:33:49 -0800
Message-ID: <7vaboogwmq.fsf@gitster.siamese.dyndns.org>
References: <20071203043258.GA16658@coredump.intra.peff.net>
	<Pine.LNX.4.64.0712031052410.27959@racer.site>
	<20071203173022.GA19219@coredump.intra.peff.net>
	<7vbq97iqxd.fsf@gitster.siamese.dyndns.org>
	<20071206055200.GA23309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AJP-0008QF-Nc
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbXLFGd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbXLFGd6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:33:58 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57429 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbXLFGd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:33:57 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BE5682EF;
	Thu,  6 Dec 2007 01:34:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 370C09B818;
	Thu,  6 Dec 2007 01:34:14 -0500 (EST)
In-Reply-To: <20071206055200.GA23309@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Dec 2007 00:52:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67255>

Jeff King <peff@peff.net> writes:

> Obviously the overall design and usage of :/ is going to take some
> thinking and is not 1.5.4 material. However, we do have it in its
> current form, and I think regex versus prefix string matching is
> orthogonal to the range issues. Should I post my rebased :/ regex patch,
> or do you want to just leave it for post-1.5.4?

Making what was string match to regex using the same syntax is a
regression, isn't it?  I do not use :/ very often myself, so I
personally would not mind but people who are used to using :/ may get
upset about the change.  I do not feel strongly enough for changing it
to regex to declare such a change unilaterally.
