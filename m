From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc5
Date: Mon, 28 Jan 2008 17:25:31 -0800
Message-ID: <7vprvls9ro.fsf@gitster.siamese.dyndns.org>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
	<7vsl0r3nvc.fsf@gitster.siamese.dyndns.org>
	<7vk5lutdzq.fsf@gitster.siamese.dyndns.org>
	<20080128183851.GB31140@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 02:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJfEy-0000Nj-3n
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 02:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYA2BZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 20:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775AbYA2BZt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 20:25:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbYA2BZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 20:25:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B8C3221F;
	Mon, 28 Jan 2008 20:25:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BDB99221B;
	Mon, 28 Jan 2008 20:25:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71911>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 28, 2008 at 02:56:41AM -0800, Junio C Hamano wrote:
>
>> Gustaf Hendeby (1):
>>       send-email, fix breakage in combination with --compose
>
> I submitted a followup test for this problem, but there was no
> response. Can I please get an ACK/NAK/"resend after 1.5.4"?
>
> For reference, the original message-id was:
>
>   <20080122032353.GB24758@coredump.intra.peff.net>

Heh, that's aonly a week ago but already you need to dig almost
500 messages back to get there.  That MacOSX thread really
killed our human performance.

[1/3] is Ok, probably even for 1.5.4.

[2/3] The use of "test -e" slightly ticked my compatibility
worry (instead use "test -f" or "test -d" when able) but non
prehistoric POSIX systems should grok it just fine these days.

[3/3] as you said was questionable in its introduction of a flag
that used primarily for testing.  Since the whole point of [2/3]
is to make [3/3] possible, I was inclined to put both on hold.
