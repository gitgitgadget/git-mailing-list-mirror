From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Fri, 28 Sep 2007 17:45:30 -0700
Message-ID: <7v1wcinvth.fsf@gitster.siamese.dyndns.org>
References: <87ir5us82a.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 02:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbQSm-0002cO-W0
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 02:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbXI2Api (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 20:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754584AbXI2Api
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 20:45:38 -0400
Received: from rune.pobox.com ([208.210.124.79]:56571 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbXI2Aph (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 20:45:37 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 76CAA13DCC6;
	Fri, 28 Sep 2007 20:45:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B689E13DCC5;
	Fri, 28 Sep 2007 20:45:54 -0400 (EDT)
In-Reply-To: <87ir5us82a.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	28 Sep 2007 16:07:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59435>

Thanks for starting this.  It was an interesting read.

----------------------------------------------------------------

#2.2.1

"git help init" would give man page.  The time when the short
help is given is when you mistype options, as in:

	$ git init --huh?

#2.4

	By default this command prints a brief paragraph of output...

Not really.  The default is to give you the entire log message,
unless you somehow made --pretty=short the default with your
copy of git.

	The "git log" tool doesn't display the Committer...

You can ask it to, so "by default" is missing.

#2.7.1

	But some poepl, (notably Linus...

typo.

#2.7.6

	for which "git commit --amend" was

was what?  "invented" perhaps?


#2.8.3

	Using "git remote" to pull changes other repositories

"changes from other repositories".

----------------------------------------------------------------
