From: Jeff King <peff@peff.net>
Subject: Re: [commit 4ecbc178704] Incosistency?
Date: Wed, 15 Jul 2009 05:42:52 -0400
Message-ID: <20090715094252.GA26048@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0907142335210.31779@cube>
 <20090714214852.GA2786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0907151028050.10773@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Unknown <borg@uu3.net>
X-From: git-owner@vger.kernel.org Wed Jul 15 11:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR10v-0007BR-QT
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 11:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbZGOJm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 05:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbZGOJm5
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 05:42:57 -0400
Received: from peff.net ([208.65.91.99]:33259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbZGOJm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 05:42:56 -0400
Received: (qmail 12437 invoked by uid 107); 15 Jul 2009 09:44:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Jul 2009 05:44:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jul 2009 05:42:52 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0907151028050.10773@cube>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123295>

On Wed, Jul 15, 2009 at 10:32:32AM +0200, Unknown wrote:

> > 1. "git-add" still goes in exec-dir. It's just not the magic one we do
> >    separately (see how we no longer need to use filter-out?).
> Right. but git-add now is a link to git. Now we have one more file
> out there.

Sorry, I don't understand the significance. Is having 'git' in the
execdir causing some kind of problem?

I agree that it shouldn't be necessary for most sane setups, but sadly
there are some insane ones, and I don't think this solution should be
hurting anyone else. Am I wrong?

-Peff
