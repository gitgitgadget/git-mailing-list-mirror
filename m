From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9600: require cvsps 2.1 to perform tests
Date: Tue, 04 Dec 2007 21:44:38 -0800
Message-ID: <7v3auh3dbt.fsf@gitster.siamese.dyndns.org>
References: <20071202163426.GA29781@coredump.intra.peff.net>
	<47533D75.1090002@gmail.com>
	<Pine.LNX.4.64.0712022340250.27959@racer.site>
	<20071203015954.GB8322@coredump.intra.peff.net>
	<47548CEC.6010701@gmail.com>
	<7vir3fe54c.fsf@gitster.siamese.dyndns.org>
	<20071204014145.GA20145@coredump.intra.peff.net>
	<7v1wa3aukt.fsf@gitster.siamese.dyndns.org>
	<20071204154454.GA2994@coredump.intra.peff.net>
	<7vhciy5pg0.fsf@gitster.siamese.dyndns.org>
	<20071205010202.GA4713@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 06:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izn4H-0008Oc-1U
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 06:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbXLEFos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 00:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbXLEFos
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 00:44:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34494 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLEFor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 00:44:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 323872F0;
	Wed,  5 Dec 2007 00:45:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 922199AF04;
	Wed,  5 Dec 2007 00:45:02 -0500 (EST)
In-Reply-To: <20071205010202.GA4713@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Dec 2007 20:02:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67102>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 04, 2007 at 09:39:59AM -0800, Junio C Hamano wrote:
>
>> You are right about "we may be depending on what 2.1 has other than
>> -A".  Will apply as-is.
>> 
>> Thanks, both.
>> 
>> The primary reason I asked about '\[-A\]' was what will happen if
>> somebody uses 2.2.
>
> Yes, it would be nice to be able to easily check >2.1. GNU expr seems to
> handle this ok:
>
>   $ expr 2.2 '>' 2.1
>   1
>   $ expr 2.0 '>' 2.1
>   0
>
> but POSIX seems to mention only integers and string comparison (though
> if all are of the form "x.y", string comparison works). I have no idea
> how portable this is.

Yeah, but it is the same thing -- we know 2.1 works, we do not know if
2.2 will break things for us ;-)

We'll worry about it when somebody with 2.2 complains.
