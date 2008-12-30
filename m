From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc/git-send-email: mention sendemail.cc config variable
Date: Tue, 30 Dec 2008 00:00:37 -0800
Message-ID: <7vocyu3xei.fsf@gitster.siamese.dyndns.org>
References: <200812290037.25890.markus.heidelberg@web.de>
 <200812291400.08924.trast@student.ethz.ch>
 <200812291429.01822.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Dec 30 09:02:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHZYM-0000TK-I2
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 09:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbYL3IAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 03:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbYL3IAv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 03:00:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbYL3IAu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 03:00:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56B131B5C1;
	Tue, 30 Dec 2008 03:00:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 92DAA1B5C0; Tue,
 30 Dec 2008 03:00:39 -0500 (EST)
In-Reply-To: <200812291429.01822.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Mon, 29 Dec 2008 14:29:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6D91B58-D647-11DD-B85C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104167>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> It is already in next, I think a following patch should be against next
> now, shouldn't it?

Surely, and thanks.

If you look at the output of

	$ git log --first-parent origin/master..origin/next

You will find the tip of mh/maint-sendmail-cc-doc topic branch is at
bd7c6e7 (doc/git-send-email: mention sendemail.cc config variable,
2008-12-29).  I'll apply any follow-up patch to the topic on top of that
commit, and then merge the result to 'next' (and 'master'/'maint' when the
result is ready).

In rare cases when there are other topics in 'next' that touch vicinity of
the code you are modifying, a patch made against 'next' may not apply
cleanly to the topic, but I'll wiggle it to apply anyway (that is what the
maintainers do), so it would certainly be nicer if you sent a patch to the
tip of the topic you are updating, but there is no need to worry about
such conflicts too much.
