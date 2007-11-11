From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Obscure commit message formatting issue
Date: Sun, 11 Nov 2007 14:01:36 -0800
Message-ID: <7vprygbfwf.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711111559220.29952@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKsO-0005Ba-UA
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbXKKWBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbXKKWBm
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:01:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48848 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbXKKWBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:01:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 14C632F0;
	Sun, 11 Nov 2007 17:02:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E192944CE;
	Sun, 11 Nov 2007 17:02:00 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711111559220.29952@iabervon.org> (Daniel
	Barkalow's message of "Sun, 11 Nov 2007 16:28:19 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64523>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The current code drops extra blank lines between the first line of a 
> commit message (the summary line) and the remainder.

The patch application side does even more.  It not just strips
off the leading or trailing blank lines, but duplicate blank
lines in the middle and trailing whitespaces at the end of each
line.

I am of two minds about the formatting side.

The behaviour you found does not go far enough to correct all of
the above whitespace breakage the application side will fix up
on the generation side -- it only corrects one of them.  We
might want to do more, instead of less that you seem to be
implying to favor.
