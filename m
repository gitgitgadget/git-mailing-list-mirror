From: Greg KH <greg@kroah.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Fri, 6 Jun 2008 14:54:00 -0700
Message-ID: <20080606215359.GA4914@kroah.com>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com> <20080604154523.GA25747@kroah.com> <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org> <20080605040315.GA21798@kroah.com> <7vabi05xl1.fsf@gitster.siamese.dyndns.org> <20080605050855.GA22825@kroah.com> <alpine.LNX.1.00.0806051546480.19665@iabervon.org> <7vzlpzzi8c.fsf@gitster.siamese.dyndns.org> <20080606204814.GE11209@kroah.com> <7vd4muth2e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 00:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4k6C-0008UR-6S
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 00:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbYFFWG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 18:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYFFWG5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 18:06:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39232 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbYFFWG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 18:06:57 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1K4k4g-000438-Cz; Fri, 06 Jun 2008 22:06:27 +0000
Content-Disposition: inline
In-Reply-To: <7vd4muth2e.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84122>

On Fri, Jun 06, 2008 at 02:00:09PM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Thu, Jun 05, 2008 at 02:26:11PM -0700, Junio C Hamano wrote:
> >
> >> However, I think /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ would
> >> result in the same breakage, and that is something I consider gravely
> >> broken.
> >
> > Yeah, especially as I never realized that /pub/ was a symlink in the
> > first place :)
> 
> And it was even worse than that.  Even if you knew /pub was a symlink, you
> could not have done anything about it, short of editing the alternates
> file in the resulting repository by hand.

Heh, true :)

> Up until now, that is.
> 
> Daniel's patch seems to fix the issue for me and it will be included in
> tonight's pushout among other fixes.

Great, thanks a lot for the fix everyone.

greg k-h
