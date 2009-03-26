From: Jeff King <peff@peff.net>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 22:27:58 -0400
Message-ID: <20090326022757.GC5835@coredump.intra.peff.net>
References: <49CA78BF.2020101@fastmail.fm> <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Raman Gupta <rocketraman@fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 03:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmfLi-0000Ds-Eq
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 03:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbZCZC2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 22:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZCZC2K
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 22:28:10 -0400
Received: from peff.net ([208.65.91.99]:57194 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbZCZC2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 22:28:10 -0400
Received: (qmail 10324 invoked by uid 107); 26 Mar 2009 02:28:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 22:28:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 22:27:58 -0400
Content-Disposition: inline
In-Reply-To: <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114708>

On Wed, Mar 25, 2009 at 12:30:31PM -0700, Junio C Hamano wrote:

> I do not answer "generally" part, but in git.git, I do not publish heads
> of individual topic branches.  I could, but simply I don't, because that
> has been the way I've operated so far, and I am too lazy to change my
> configuration.

I don't think it is a big problem in practice. But every once in a while
I have had to dig through pu to re-create a topic branch manually. And I
believe Thomas Rast posted a script to do so automatically. So I think
there is some indication that people might find this information useful,
but I don't feel too strongly about it.

> Also I suspect it would make my life more cumbersome
> because I have to prune stale topics from the public repositories from
> time to time.

Mirror mode would handle this automatically, but it unfortunately also
ignores your push refspec. So any cruft or work-in-progress refs in your
repository would be pushed.

-Peff
