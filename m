From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 17:38:40 -0800
Message-ID: <7vocxnylzz.fsf@gitster.siamese.dyndns.org>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
 <20090131071238.GC3033@coredump.intra.peff.net>
 <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
 <7vtz7f2cy6.fsf@gitster.siamese.dyndns.org>
 <885649360901311732t6e4f8651p6c3955f018b9a36c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:40:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRJl-0004nG-Lh
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbZBABis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbZBABis
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:38:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZBABis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:38:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 53CD8958AF;
	Sat, 31 Jan 2009 20:38:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B3DDC958AC; Sat,
 31 Jan 2009 20:38:42 -0500 (EST)
In-Reply-To: <885649360901311732t6e4f8651p6c3955f018b9a36c@mail.gmail.com>
 (James Pickens's message of "Sat, 31 Jan 2009 18:32:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 11AF19B4-F001-11DD-92DE-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107967>

James Pickens <jepicken@gmail.com> writes:

> ...  Sounds like I have no choice
> but to use --reference for that.

As --reference was invented exactly for that use case, I think using it to
instruct where to borrow your object from is a very sensible thing to do.
