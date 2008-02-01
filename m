From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] --format=pretty: new modifiers cID, cIS, CIY
Date: Fri, 01 Feb 2008 15:29:27 -0800
Message-ID: <7vabmk8dd4.fsf@gitster.siamese.dyndns.org>
References: <7vir188ej4.fsf@gitster.siamese.dyndns.org>
	<96032.15671.qm@web39506.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tommy Thorn <tt1729@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 00:30:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL5L2-0001mI-HI
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 00:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762353AbYBAX3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762346AbYBAX3k
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 18:29:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761620AbYBAX3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 18:29:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F59A24F0;
	Fri,  1 Feb 2008 18:29:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BE6E424EF;
	Fri,  1 Feb 2008 18:29:34 -0500 (EST)
In-Reply-To: <96032.15671.qm@web39506.mail.mud.yahoo.com> (Tommy Thorn's
	message of "Fri, 1 Feb 2008 15:16:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72192>

Tommy Thorn <tt1729@yahoo.com> writes:

> [resent, sorry]
>
> --- Junio C Hamano <gitster@pobox.com> wrote:
>> I think we would very much prefer, instead of
>> piling hacks on top of the originally supported 
>> "minimum set", to introduce a truly extensible 
>> syntax, like:
>
> I concur, but pretty-please make it a super set of 
> date(1) to the extent possible. It will lessen the 
> confusion. 
>
> Maybe something like "%c(%Y-%m-%d %H:%M) ...", eg.
> such
> that if `date +<format>' is legal, so is
> "%c(<format>)".

Please read what you are replying to again.  If you said the
above with %cT(...), it might have made some sense (but then how
are you differentiate between local and original timezone?), but
%c(...) needs to show not just the timestamp.
