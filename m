From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-browse-help?
Date: Fri, 14 Dec 2007 09:38:05 -0800
Message-ID: <7vtzmlrxc2.fsf@gitster.siamese.dyndns.org>
References: <20071214092829.GA22725@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 18:38:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3EUt-0000Ay-4q
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 18:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbXLNRi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 12:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbXLNRi2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 12:38:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbXLNRi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 12:38:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB7ED9391;
	Fri, 14 Dec 2007 12:38:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F855938B;
	Fri, 14 Dec 2007 12:38:10 -0500 (EST)
In-Reply-To: <20071214092829.GA22725@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Dec 2007 04:28:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68320>

Jeff King <peff@peff.net> writes:

> The new 'git-browse-help' seems to purely be a helper script for "git
> help" (judging from the commit messages and the lack of documentation).
> Should it perhaps be "git--browse-help" or "git-help--browse" to follow
> our "this is not for users" convention (see add--interactive,
> fetch--tool, and rebase--interactive).
>
> I became aware of it because "br" used to tab-complete "branch" but now
> doesn't. :) And if we're going to change it, pre-1.5.4 is the time.

Good eyes and a sensible argument.  Go wild.
