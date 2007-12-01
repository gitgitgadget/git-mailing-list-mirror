From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Fri, 30 Nov 2007 18:37:01 -0800
Message-ID: <7vmysv87jm.fsf@gitster.siamese.dyndns.org>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu>
	<7v3aup291c.fsf@gitster.siamese.dyndns.org>
	<7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIEg-0003qY-NX
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758673AbXLAChJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758669AbXLAChI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:37:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40332 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636AbXLAChG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:37:06 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1A1F42F9;
	Fri, 30 Nov 2007 21:37:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CAC69B9F0;
	Fri, 30 Nov 2007 21:37:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66685>

Michael Witten <mfwitten@MIT.EDU> writes:

>> I gave only a very cursory look; looks Ok to me.  This makes me wonder
>> if post-update wants to run as well.
>
> Seems like post-receive is supposed to supersede post-update anyhow,
> so might as well leave post-update out at this point?

I'll queue your patch, but I think it should be enhanced to support
post-update for consistency.  I do not think anybody said anything about
deprecating let alone dropping support for post-update so far.

When we talk about deprecation and later removal of post-update hook, we
should drop that additional support from cvsserver and receive-pack at
the same time, but not before that.
