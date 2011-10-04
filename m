From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Wed, 5 Oct 2011 00:34:45 +0200
Message-ID: <201110050034.46334.chriscool@tuxfamily.org>
References: <20110929142027.GA4936@zelva.suse.cz> <20111004103056.GB11236@sigill.intra.peff.net> <7vfwj8dbn0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michal Vyskocil <mvyskocil@suse.cz>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 00:35:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBDZo-0003rA-Ar
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 00:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933508Ab1JDWe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 18:34:58 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36445 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933278Ab1JDWe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 18:34:57 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F37FBA61CB;
	Wed,  5 Oct 2011 00:34:47 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <7vfwj8dbn0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182810>

Hi,

On Tuesday 04 October 2011 17:22:59 Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> > On Mon, Oct 03, 2011 at 10:00:25AM -0700, Junio C Hamano wrote:
> > 
> > And the --started-to would literally be implemented as flipping the
> > meaning of "git bisect yes" and "git bisect no", and nothing more. IOW,
> > it's just another way of spelling "git bisect --reverse".
> 
> Yes, if we wanted to also implement the flipping of the mapping between
> yes/no and good/bad, I do not have any problem with --used-to/--started-to
> pair of options.

If we decide to go with yes/no, an option like:

--yes-means=<it behaves like this>

seems to me easier to understand. Though I recognize that it doesn't tell that 
the behavior changed.

And before responding to this thread I wanted to have another look at the 
unfinished patch that Dscho sent a few years ago, but I did not have much time 
these past few days, and I could not find it anymore.

Thanks,
Christian.
