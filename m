From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 02:35:13 -0800
Message-ID: <7v4pdovc4e.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<7vzlvhxpda.fsf@gitster.siamese.dyndns.org>
	<5310CD2F-C3B4-404A-9C2E-1D3084B5CC96@zib.de>
	<7vejcswzad.fsf@gitster.siamese.dyndns.org>
	<20080108100818.GA17205@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 11:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCBoH-0004gS-F1
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 11:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbYAHKfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 05:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYAHKfX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 05:35:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbYAHKfW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 05:35:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 904E6996D;
	Tue,  8 Jan 2008 05:35:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 02D699965;
	Tue,  8 Jan 2008 05:35:14 -0500 (EST)
In-Reply-To: <20080108100818.GA17205@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 8 Jan 2008 05:08:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69860>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 07, 2008 at 11:29:30PM -0800, Junio C Hamano wrote:
>
>> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:
>
> I'm not sure what's causing it, but all of the addresses in your message
> (including cc headers) got munged.

I think Steffen's original got munged (I just replied to it) by
gmane's mail relaying interface.

>> > I'm asking the last question because every Unix developer should
>> > think about the option, too.  Neither Unix or Windows are causing
>> > the problem alone.
>> 
>> That's the logical conclusion.
>> 
>> If you are introducing crlf = warn, that means you are declaring
>> that CRLF should be treated as a disease, and that should apply
>> everywhere, not just on Windows (which some people may consider
>> a disease itself, but that is a separate topic).
>
> It's unclear to me: is such a warning only supposed to happen when we
> see CRLF _after_ we have determined that a file is not actually binary?

Oh, I agree.  I thought that was what Steffen was proposing.
