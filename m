From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 07 Dec 2007 13:44:12 -0800
Message-ID: <7vtzmuyyc3.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
	<7v63za4yic.fsf@gitster.siamese.dyndns.org>
	<7vwsrq3iox.fsf@gitster.siamese.dyndns.org>
	<20071207213414.GA11688@coredump.intra.peff.net>
	<20071207213541.GA11723@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:45:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0l0D-00052Y-Pa
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbXLGVoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbXLGVoa
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:44:30 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbXLGVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:44:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 525FA2B80;
	Fri,  7 Dec 2007 16:44:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E6FC29AB;
	Fri,  7 Dec 2007 16:44:19 -0500 (EST)
In-Reply-To: <20071207213541.GA11723@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 7 Dec 2007 16:35:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67473>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 07, 2007 at 04:34:14PM -0500, Jeff King wrote:
>
>> On Fri, Dec 07, 2007 at 02:25:34AM -0800, Junio C Hamano wrote:
>> 
>> > git-bisect visualize: work in non-windowed environments better
>> 
>> Isn't this more or less the use case for the "git view" alias?
>
> Which isn't to say that I don't think your solution is nicer; it is. But
> if we don't use it here, then perhaps "git view" really is a solution in
> search of a problem.

Well, I think "git view" should not be just "predefined alias that the
user can override wholesale", which is what you currently have.  I think
it can just be an example in "git config" manpage (i.e. "If you want to,
you can alias 'view' to 'gitk' or 'gitview'") and I do not think we need
core-side support for that.

If it becomes cleverer, that's a different story.  Noticing if the user
is in windowing environment or not, and acting differently, would make
it a single command that acts sensibly and in context sensitive way.
