From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 16:32:03 -0800
Message-ID: <7vir215hj0.fsf@gitster.siamese.dyndns.org>
References: <C3AC3E6F.10D42%jefferis@gmail.com>
	<alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 01:32:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD7pJ-0000sP-1T
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 01:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbYAKAcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 19:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYAKAcU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 19:32:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYAKAcT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 19:32:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AE18E3319;
	Thu, 10 Jan 2008 19:32:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 161273318;
	Thu, 10 Jan 2008 19:32:09 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 10 Jan 2008 16:02:43 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70112>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (Side note: if there are known filetype extensions that have problems with 
> the git guessing, we sure as heck could take the filename into account 
> when guessing! There's absolutely nothing that says that we only have to 
> look at the contents when guessing about the text/binary thing!)

You do not have to yell.

Instead, just give yourself a pat in the back for having a
brilliant foresight to give "path" parameter when you did
6c510bee2013022fbce52f4b0ec0cc593fc0cc48 (Lazy man's auto-CRLF)
to convert_to_git() function, even though the code originally
did not use it back then ;-).
