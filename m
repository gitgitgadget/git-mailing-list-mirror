From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] chain kill signals for cleanup functions
Date: Fri, 30 Jan 2009 16:28:39 -0800
Message-ID: <7vd4e49v48.fsf@gitster.siamese.dyndns.org>
References: <20090122042643.GB31427@coredump.intra.peff.net>
 <20090122060235.GC30133@coredump.intra.peff.net>
 <20090130075552.GA27716@coredump.intra.peff.net>
 <4982B68C.2070207@viscovery.net>
 <20090130082101.GA28809@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 01:30:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT3kb-0002Nb-TB
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 01:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbZAaA2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 19:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757005AbZAaA2u
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 19:28:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775AbZAaA2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 19:28:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A4C4A2A1C5;
	Fri, 30 Jan 2009 19:28:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8FE572A1C6; Fri,
 30 Jan 2009 19:28:41 -0500 (EST)
In-Reply-To: <20090130082101.GA28809@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 30 Jan 2009 03:21:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1EE1A63E-EF2E-11DD-BBF7-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107891>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 30, 2009 at 09:13:00AM +0100, Johannes Sixt wrote:
>
>> Jeff King schrieb:
>> > One fix would be to just "signal(SIGINT, SIG_DFL)" at the top. But I
>> > think it makes the test cleaner to just switch to a more reliable
>> > signal. The patch would look something like what is below. But I need to
>> > know what exit code Windows generates for SIGTERM. Johannes?
>> 
>> The same as with SIGINT: 3.
>
> Hmm. Clever.
>
> Junio, can you apply this on top of the jk/signal-cleanup topic?

Will do, but I've been sick today, haven't caught up with the list
traffic, and I do not think I'll be reading my mails for the rest of the
day either.  It may take some time for it to appear in the public
repositories.

Thanks.
