From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add committer and author names to top of
	COMMIT_EDITMSG.
Date: Sat, 12 Jan 2008 00:32:25 -0500
Message-ID: <20080112053225.GA6059@coredump.intra.peff.net>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com> <7v3at42avd.fsf@gitster.siamese.dyndns.org> <9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com> <7vbq7r28qo.fsf@gitster.siamese.dyndns.org> <9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com> <7vejcnzu5z.fsf@gitster.siamese.dyndns.org> <20080112045231.GB5211@coredump.intra.peff.net> <7vprw7y6mz.fsf@gitster.siamese.dyndns.org> <7vlk6vy5jj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:33:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYzQ-0000Ak-VH
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762320AbYALFcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762283AbYALFcd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:32:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2181 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762088AbYALFcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:32:32 -0500
Received: (qmail 4252 invoked by uid 111); 12 Jan 2008 05:32:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 12 Jan 2008 00:32:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2008 00:32:25 -0500
Content-Disposition: inline
In-Reply-To: <7vlk6vy5jj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70267>

On Fri, Jan 11, 2008 at 09:30:24PM -0800, Junio C Hamano wrote:

> I think what we could do if we wanted to protect people from
> unconfigured identity is to stop pulling names from gecos and
> hostname, and respect _only_ environment and config.

I am fine with that, as I have always set up the configuration manually
anyway. But I think it would need a significant comment period from the
list (ISTR that Linus _likes_ pulling the hostname from gecos).

-Peff
