From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc5
Date: Mon, 28 Jan 2008 20:29:45 -0500
Message-ID: <20080129012945.GA7884@coredump.intra.peff.net>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <7vsl0r3nvc.fsf@gitster.siamese.dyndns.org> <7vk5lutdzq.fsf@gitster.siamese.dyndns.org> <20080128183851.GB31140@coredump.intra.peff.net> <7vprvls9ro.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 02:30:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJfIp-0001H4-Tc
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 02:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbYA2B3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 20:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753991AbYA2B3t
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 20:29:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2532 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbYA2B3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 20:29:48 -0500
Received: (qmail 2185 invoked by uid 111); 29 Jan 2008 01:29:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 28 Jan 2008 20:29:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2008 20:29:45 -0500
Content-Disposition: inline
In-Reply-To: <7vprvls9ro.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71913>

On Mon, Jan 28, 2008 at 05:25:31PM -0800, Junio C Hamano wrote:

> Heh, that's aonly a week ago but already you need to dig almost
> 500 messages back to get there.  That MacOSX thread really
> killed our human performance.
> 
> [1/3] is Ok, probably even for 1.5.4.
> 
> [2/3] The use of "test -e" slightly ticked my compatibility
> worry (instead use "test -f" or "test -d" when able) but non
> prehistoric POSIX systems should grok it just fine these days.
> 
> [3/3] as you said was questionable in its introduction of a flag
> that used primarily for testing.  Since the whole point of [2/3]
> is to make [3/3] possible, I was inclined to put both on hold.

That all sounds reasonable. I will rebase and resubmit after 1.5.4, with
2/3 using "test -f" and 3/3 matching Gustaf's fix (and 1/3 included if
you do not apply it beforehand).

Thanks for the response.

-Peff
