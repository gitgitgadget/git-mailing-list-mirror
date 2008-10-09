From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Implement git clone -v
Date: Thu, 9 Oct 2008 08:20:28 -0700
Message-ID: <20081009152028.GA29829@spearce.org>
References: <20081008060257.GA15240@spearce.org> <1223509232-3520-1-git-send-email-vmiklos@frugalware.org> <7vr66qown3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnxKf-0005Ti-9R
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239AbYJIPU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757211AbYJIPU3
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:20:29 -0400
Received: from george.spearce.org ([209.20.77.23]:48743 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbYJIPU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 11:20:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A158138360; Thu,  9 Oct 2008 15:20:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vr66qown3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97860>

Junio C Hamano <gitster@pobox.com> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > The new -v option forces the progressbar, even in case the output is not
> > a terminal.
> >
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> 
> The patch made me wonder why this new feature had to be implemented in the
> first place and had me look up the message the patch was an follow-up to.
> For somebody who would not recall the original request-for-feature (that
> includes you 6 months from now), it would have been easier to understand
> the context if the commit message said what the intended purpose of this
> (i.e. "have it read by an IDE").

I'm amending the message as the following:

--8<--
Implement git clone -v

The new -v option forces the progressbar, even in case the output
is not a terminal.  This can be useful if the caller is an IDE or
wrapper which wants to scrape the progressbar from stderr and show
its information in a different format.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
--

-- 
Shawn.
