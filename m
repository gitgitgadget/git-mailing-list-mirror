From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more careful about updating refs
Date: Tue, 15 Jan 2008 16:29:54 -0800
Message-ID: <7vd4s2d33x.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:31:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwBJ-00041Q-OF
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYAPAaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbYAPAaK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:30:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYAPAaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 19:30:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 78AC52887;
	Tue, 15 Jan 2008 19:30:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CDAEF2886;
	Tue, 15 Jan 2008 19:30:01 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 15 Jan 2008 15:50:17 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70584>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> I'm signing off on this, but I hope people will double-check this: I 
> didn't actually test it very much.

Does "Signed-off-by:" line mean something different for you than
for other people these days?

I thought that the rule that applies to you (and only you) on
this list was that all patches from you are DCO certified and I
am free to forge your signature on them, and the other rule that
applies to everybody including you is that Signed-off-by: is
about DCO certification and not about anything else
(e.g. author's confidence level about the patch).

I am asking because you did not have S-o-b and did not say
anything about the other patch about commit object creation.
Although both patches looked sane to me.
