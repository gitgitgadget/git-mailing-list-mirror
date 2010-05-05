From: Eli Barzilay <eli@barzilay.org>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current
 directory.
Date: Wed, 5 May 2010 18:33:09 -0400
Message-ID: <19425.61989.608102.77250@winooski.ccs.neu.edu>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
	<19425.9169.537598.876589@winooski.ccs.neu.edu>
	<7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	<19425.54504.163875.379151@winooski.ccs.neu.edu>
	<19425.58290.42871.986460@winooski.ccs.neu.edu>
	<1273098179.723.10.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Thu May 06 00:33:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9n9q-0005hp-E5
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 00:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab0EEWd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 18:33:29 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:34557 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab0EEWd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 18:33:28 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9n9R-0002mI-Jy; Wed, 05 May 2010 18:33:09 -0400
In-Reply-To: <1273098179.723.10.camel@dreddbeard>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146428>

On May  5, Will Palmer wrote:
> On Wed, 2010-05-05 at 17:31 -0400, Eli Barzilay wrote:
> > With "!"-prefixed shell aliases, the shell command not only gets
> > executed at the repository top level, but there is no way to know the
> > current directory of the original call.  This adds "!!"-prefixed aliases
> > as a similar variant for "!"-prefixed ones, but the commands are
> > executed in the original directory instead of the top level.
> > 
> > Signed-off-by: Eli Barzilay <eli@barzilay.org>
> 
> Is there any precedent for the "!!" syntax? Something like ".!",
> "./!", or "!(.)" would make the intention more clear, I'd think, as
> well as leaving room for other extensions to be added later, and
> some explicit-opposite, like "/!", to complement it. (It's not like
> people are going around with binaries called "!", is it?)

[

The first time I saw the "!" syntax, it was slightly confusing to me
in that it's similar to various shells using "!" for history expansion
-- especially given that these things are popular with shell aliases
made it hard to remember.

An alternative character that wouldn't have confused me, and even
suggests shell commands is ";".  So my preference would be for shell
aliases to start with it and to be invoked in the original working
directory, perhaps deprecating the "!" syntax.

But I'm new enough to be safely ignored...  So this is all a
parenthetical comment...

]

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
