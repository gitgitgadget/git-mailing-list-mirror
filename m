From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add committer and author names to top of
	COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 23:52:31 -0500
Message-ID: <20080112045231.GB5211@coredump.intra.peff.net>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com> <7v3at42avd.fsf@gitster.siamese.dyndns.org> <9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com> <7vbq7r28qo.fsf@gitster.siamese.dyndns.org> <9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com> <7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 05:53:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYMx-0002dX-CX
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 05:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbYALEwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 23:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbYALEwo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 23:52:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2035 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbYALEwn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 23:52:43 -0500
Received: (qmail 3971 invoked by uid 111); 12 Jan 2008 04:52:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 11 Jan 2008 23:52:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2008 23:52:31 -0500
Content-Disposition: inline
In-Reply-To: <7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70260>

On Fri, Jan 11, 2008 at 05:53:12PM -0800, Junio C Hamano wrote:

> The official party line to defend the existing behaviour is that
> there is no need to configure anything, when the host and gecos
> is done properly.  But I tend to agree with you that quite a lot
> of systems are not "done properly", and users cannot do much
> about it in some cases.  I think most of misconfigured systems
> are personal boxes they have control over but not all.

I think there are plenty of reasons for the host/gecos information not
being useful. Is a workstation whose hostname is not a valid mailing
address really not "done properly"?

> Perhaps we could disable the code that reads from hostname and
> gecos, and instead always force the users to configure.  But
> that kind of change is not something I'd want to be discussing
> right now.

This is obviously not 1.5.4 material, so I haven't given it that much
thought either. But perhaps Stephen's "author message" should simply
trigger any time the author is pulled from gecos? I suppose that would
annoy people who use this feature all the time, but they can silence the
"warning" with a simple git-config.

-Peff
