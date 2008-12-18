From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rsync deprecated?
Date: Wed, 17 Dec 2008 19:20:59 -0800
Message-ID: <7vljuei2xw.fsf@gitster.siamese.dyndns.org>
References: <200812180041.10312.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Thu Dec 18 04:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9T3-0003I2-73
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYLRDVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYLRDVJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:21:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYLRDVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:21:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B3ED7881AA;
	Wed, 17 Dec 2008 22:21:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E1FD9881A4; Wed,
 17 Dec 2008 22:21:04 -0500 (EST)
In-Reply-To: <200812180041.10312.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Thu, 18 Dec 2008 00:41:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E90E0266-CCB2-11DD-831C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103426>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> in the "Merging external work" section of the gitcore-tutorial it is
> stated that the rsync transport is deprecated. The description was added
> in commit 914328a (Update tutorial., 2005-08-30) together with the
> "deprecated" note. Having never heard/read this before and since this
> commit is quite old, I wonder if it is still the case or there was a
> solution for this problem.

Sorry, I do not quite understand what you perceive as "this problem".

It has been deprecated for too long a time.  Maybe it is time to remove
the support, instead of carrying the deprecated command forever?  Is that
the problem you are talking about?

I tend to agree that rsync transport way outlived its usefulness, and not
maintained at all.  There may be unnoticed and undiagnosed bugs lurking,
but nobody knows about it because nobody uses it.

But the next release (1.6.1) won't be a good timing for removal.  Perhaps
we can make an announcement now that it will be removed in a future major
update, and actually remove it in 1.7.0 or so.
