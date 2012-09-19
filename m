From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Wed, 19 Sep 2012 21:12:01 +0100
Message-ID: <20120919201201.GD19246@atlantic.linksys.moosehall>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
 <20120917201119.GB24888@sigill.intra.peff.net>
 <505A24EC.1000203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:12:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQd4-0008KP-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab2ISUMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:12:05 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45126 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab2ISUME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:12:04 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 1AA142E39E;
	Wed, 19 Sep 2012 21:12:02 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <505A24EC.1000203@gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205991>

On Wed, Sep 19, 2012 at 10:02:52PM +0200, Stefano Lattarini wrote:
> On 09/17/2012 10:11 PM, Jeff King wrote:
> > On Mon, Sep 17, 2012 at 12:50:37PM +0100, Adam Spiers wrote:
> > 
> >> The end result of these changes is that:
> >>
> >>   - red is _only_ used for things which have gone unexpectedly wrong:
> >>     test failures, unexpected test passes, and failures with the
> >>     framework,
> >>
> >>   - yellow is _only_ used for known breakages, and
> >>
> >>   - green is _only_ used for things which have gone to plan and
> >>     require no further work to be done.
> > 
> > Sounds reasonable, and I think the new output looks nice. I notice that
> > skipped tests are still in green. I wonder if they should be in yellow,
> > too.
> >
> What about blue instead?   This would keep the colouring scheme more
> consistent with the one used by prove:
>   <http://search.cpan.org/~ovid/Test-Harness/bin/prove>
> by autotest:
>   <http://www.gnu.org/software/autoconf/manual/autoconf.html#Using-Autotest>
> and by the Automake-generated test harness:
>   <http://www.gnu.org/software/automake/manual/automake.html#Scripts_002dbased-Testsuites>

Sounds good to me!  Blue is the conventional color for informational
signs, so seems like a natural fit for skipped tests.  Not sure
whether it should be bold or not though?  I'll wait for a more solid
group consensus before re-rolling yet another patch :-)
