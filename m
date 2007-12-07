From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 07 Dec 2007 14:03:44 -0800
Message-ID: <7vprxiyxfj.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
	<7v63za4yic.fsf@gitster.siamese.dyndns.org>
	<7vwsrq3iox.fsf@gitster.siamese.dyndns.org>
	<20071207213414.GA11688@coredump.intra.peff.net>
	<20071207213541.GA11723@coredump.intra.peff.net>
	<7vtzmuyyc3.fsf@gitster.siamese.dyndns.org>
	<20071207215514.GA11784@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0lJN-00056Z-8S
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 23:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbXLGWEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 17:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432AbXLGWEV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 17:04:21 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:39355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbXLGWEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 17:04:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 626E43F69;
	Fri,  7 Dec 2007 17:04:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8068E3F68;
	Fri,  7 Dec 2007 17:04:11 -0500 (EST)
In-Reply-To: <20071207215514.GA11784@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 7 Dec 2007 16:55:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67478>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 07, 2007 at 01:44:12PM -0800, Junio C Hamano wrote:
>
>> Well, I think "git view" should not be just "predefined alias that the
>> user can override wholesale", which is what you currently have.  I think
>> it can just be an example in "git config" manpage (i.e. "If you want to,
>> you can alias 'view' to 'gitk' or 'gitview'") and I do not think we need
>> core-side support for that.
>
> Sure, but regular aliases already do that. The point of making it a
> "builtin" alias is that we can depend on it being there. But who is
> depending?

Nobody is depending.

And I think the reason nobody depends on it is because there is no
compelling reason to.  Perhaps the behaviour is not useful enough.  It
surely is the case for "bisect view".
