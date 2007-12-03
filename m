From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Sun, 02 Dec 2007 18:40:36 -0800
Message-ID: <7v4pf0sdp7.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
	<20071203022729.GD8322@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz1F0-0003D0-N1
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbXLCCkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbXLCCkm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:40:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35447 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbXLCCkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:40:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9A5CD2F0;
	Sun,  2 Dec 2007 21:41:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B5859C501;
	Sun,  2 Dec 2007 21:40:59 -0500 (EST)
In-Reply-To: <20071203022729.GD8322@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 2 Dec 2007 21:27:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66850>

Jeff King <peff@peff.net> writes:

> IOW, it's not intended for users to use absolute paths in this way.
> However, the results for git-blame are obviously quite confusing. It
> might be worth fixing, but I suspect there are many more such traps
> waiting in other commands. I wonder if it would make sense to reject
> pathspecs starting with '/' entirely, which would at least give us a
> saner error message (and I can't think of a time when such a pathspec
> would be useful)?

All correct, except...

> Even more useful would be to convert
> /path/to/repo/file to 'file' internally.

... that might help "cut & paste from file manager" people, and I think
we had comment session for such a patch recently on the list.

Sorry, but I lost track of that the current status of that patch.  Did
it die?
