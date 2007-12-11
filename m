From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 01:17:43 -0500
Message-ID: <20071211061743.GA21718@coredump.intra.peff.net>
References: <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:18:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yRS-0006uu-MD
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbXLKGRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbXLKGRq
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:17:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4612 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbXLKGRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:17:45 -0500
Received: (qmail 6556 invoked by uid 111); 11 Dec 2007 06:17:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 01:17:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 01:17:43 -0500
Content-Disposition: inline
In-Reply-To: <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67798>

On Mon, Dec 10, 2007 at 05:27:17PM -0800, Junio C Hamano wrote:

> > And perhaps not a regression, but I think we should bring git-svn's
> > handling of color.* in line with the changes to the rest of the code
> > before 1.5.4. I posted a "last resort" patch, but I think with your
> > changes to "git config --colorbool" it might be possible to use that.
> > I'll try to work up a new patch.
> 
> Thanks for a reminder.  Anything else?

2-patch series will follow momentarily. 1/2 gives --get-colorbool the
necessary information for implementing color.pager, and 2/2 fixes
git-svn.

Very light testing by me, since I'm not actually a git-svn user, but it
does pass the test scripts. Acks from svn-using people would be nice.

-Peff
