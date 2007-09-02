From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sun, 02 Sep 2007 00:02:48 -0700
Message-ID: <7vfy1xr1lz.fsf@gitster.siamese.dyndns.org>
References: <200709010925.27926.johannes.sixt@telecom.at>
	<7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
	<7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
	<85abs5v9q1.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 09:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRjU4-0001yL-H7
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 09:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXIBHC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 03:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbXIBHC4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 03:02:56 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:33827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbXIBHCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 03:02:55 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A72F112CC1C;
	Sun,  2 Sep 2007 03:03:11 -0400 (EDT)
In-Reply-To: <85abs5v9q1.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	02 Sep 2007 08:53:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57300>

David Kastrup <dak@gnu.org> writes:

> Just for the record: I believe that \{1,\} might be portable.

Yeah, I obviously looked at the page I quoted that describes
what's in and what's not in BRE definition ;-)

But in practice, I do not recall ever seeing an older sed that
did not understand one-or-more \+ *and* understood \{1,\}.  Do
you?

I had to deal with autoconf (hence various flavours of UNIX
implementations) in my previous life, but that was an ancient
history (back then the effect of SysV vs BSD war was still
felt).  As a maintainer of a public project I understand you
have to deal with the current set of variations, and you might
know better than me about the current portability situation.
