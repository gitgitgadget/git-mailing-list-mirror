From: Jeff King <peff@peff.net>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 05:08:18 -0500
Message-ID: <20080108100818.GA17205@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <7vzlvhxpda.fsf@gitster.siamese.dyndns.org> <5310CD2F-C3B4-404A-9C2E-1D3084B5CC96@zib.de> <7vejcswzad.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 11:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCBOI-00061C-15
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 11:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbYAHKI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 05:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYAHKIY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 05:08:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1044 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbYAHKIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 05:08:21 -0500
Received: (qmail 16490 invoked by uid 111); 8 Jan 2008 10:08:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 08 Jan 2008 05:08:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2008 05:08:18 -0500
Content-Disposition: inline
In-Reply-To: <7vejcswzad.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69858>

On Mon, Jan 07, 2008 at 11:29:30PM -0800, Junio C Hamano wrote:

> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:

I'm not sure what's causing it, but all of the addresses in your message
(including cc headers) got munged.

> > I'm asking the last question because every Unix developer should
> > think about the option, too.  Neither Unix or Windows are causing
> > the problem alone.
> 
> That's the logical conclusion.
> 
> If you are introducing crlf = warn, that means you are declaring
> that CRLF should be treated as a disease, and that should apply
> everywhere, not just on Windows (which some people may consider
> a disease itself, but that is a separate topic).

It's unclear to me: is such a warning only supposed to happen when we
see CRLF _after_ we have determined that a file is not actually binary?
Otherwise, it seems like we are punishing people on sane platforms who
use binary files (although even with that check, I am slightly
uncomfortable given reports of incorrect guessing).

-Peff
