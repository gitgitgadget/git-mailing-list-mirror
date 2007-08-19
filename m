From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule update - don't run git-fetch if sha1 available
Date: Sun, 19 Aug 2007 13:56:28 -0700
Message-ID: <7v8x87b5vn.fsf@gitster.siamese.dyndns.org>
References: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
	<7vfy2pn9eb.fsf@assigned-by-dhcp.cox.net>
	<e7bda7770708111703u40f89c1fx17bfac4b9aed9d2e@mail.gmail.com>
	<7vfy2plfb4.fsf@assigned-by-dhcp.cox.net>
	<e7bda7770708191157v54c2c2a3k8e17208a1d5b6dc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Torgil Svensson" <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 22:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMrpH-0005jV-Im
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 22:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbXHSU4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbXHSU4k
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 16:56:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbXHSU4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 16:56:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FBF8124785;
	Sun, 19 Aug 2007 16:56:56 -0400 (EDT)
In-Reply-To: <e7bda7770708191157v54c2c2a3k8e17208a1d5b6dc9@mail.gmail.com>
	(Torgil Svensson's message of "Sun, 19 Aug 2007 20:57:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56146>

"Torgil Svensson" <torgil.svensson@gmail.com> writes:

> $ git apply junio.mail

I have no idea how you saved the junio.mail file.  "git am"
knows how to grok e-mails in mbox and maildir formats.

> ...
> Is the "-- >8 --" -line something git-apply looks for?

git-apply does not have anything to do with any of this.  You
are looking for "git am".

"git-am" does not currently pay attention to the "-- >8 --"
marker, either.  It is there primarily so that you can do the
interactive "git am -i" so that you know up to which point you
would want to remove with its [e]dit subcommand.
