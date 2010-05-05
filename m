From: Eli Barzilay <eli@barzilay.org>
Subject: Re: [PATCH] Set GIT_PATHNAME_PREFIX with aliases.
Date: Wed, 5 May 2010 03:52:49 -0400
Message-ID: <19425.9169.537598.876589@winooski.ccs.neu.edu>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 05 09:54:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9ZR0-0001Vh-8a
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 09:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab0EEHxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 03:53:08 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:45026 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756879Ab0EEHxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 03:53:07 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9ZPV-0005rJ-Hi; Wed, 05 May 2010 03:52:49 -0400
In-Reply-To: <20100505070131.GA11265@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146381>

On May  5, Jeff King wrote:
> On Wed, May 05, 2010 at 08:53:35AM +0200, Johannes Sixt wrote:
> 
> > Am 5/5/2010 2:51, schrieb Jeff King:
> > > On Tue, May 04, 2010 at 08:25:22PM -0400, Jared Hance wrote:
> > > 
> > >> The environment variable GIT_PATHNAME_PREFIX passes on the
> > >> current working directory (where the git command was called from)
> > >> to shell aliases (aliases that begin with "!"). This allows these
> > >> shell aliases to know the directory that the git command was called
> > >> from.
> > > 
> > > Seems like a reasonable goal, but...
> > 
> > Sorry, I disagree.
> > [reasons why it sucks]
> 
> Yes, I agree it sucks. The problem is that this information is
> totally lost now for shell aliases, so you can't even do these
> painful things.  Your alias simply doesn't have access to that
> information at all. I am open to better interfaces (my "reasonable"
> above was not a ringing endorsement, but rather "I can see why you
> might want to do this").

Something that Jonathan suggested earlier is a different magic
character instead of "!" that will do the cd -- perhaps a second
character would be more acceptable, something like "!!"...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
