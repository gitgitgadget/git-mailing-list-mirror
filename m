From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 22:50:27 -0500
Message-ID: <20090216035027.GA12689@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 04:52:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuWU-0002Ve-Jw
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693AbZBPDub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756668AbZBPDua
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:50:30 -0500
Received: from peff.net ([208.65.91.99]:47044 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627AbZBPDu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:50:29 -0500
Received: (qmail 12945 invoked by uid 107); 16 Feb 2009 03:50:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 22:50:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 22:50:27 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110128>

On Sun, Feb 15, 2009 at 05:33:59PM -0800, david@lang.hm wrote:

>> It is already implemented; the proposal is about setting the default.
>> The plans for 1.6.2 are already to issue a warning and ask the user to
>> set the config variable to shut it up.
>
> if this is going to be done the timeframe for making the change should be  

I don't know that a particular timeframe for switching the default has
been chosen at this point. There is a short warning in 1.6.1, and a much
more comprehensive warning will be in 1.6.2 (which should be released
shortly).

> quite long. think in terms of debian stable or RHEL, whatever version they 
> ship is what their users are going to use. it doesn't matter how many new  
> versions and what warnings you have the produce in the meantime, the users 
> won't see them.

Sadly, Debian 5.0 just shipped with git 1.5.6.5, which has no warning
(and dashed commands!).

> note that this isn't always stupid to do, if you are deploying them on a  
> network with no Internet access the stability of knowing that things are  
> _exactly_ what you tested may be worth more than updates that close bugs  
> that you don't hit or add features that you aren't using (or introduce  
> unexpected changes like spitting warnings or errors for things that the  
> old version didn't, which is exactly what is being proposed.

I'm not sure I understand your argument here. If you have a machine that
needs to do _exactly_ what you have tested, then wouldn't you be
concerned about upgrading git 1.5.6.5 to (for example) git 1.7? Or since
you are probably looking at a more macro-level, upgrading Debian 5.0 to
Debian 6.0?

-Peff
