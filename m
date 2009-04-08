From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and
	spaces
Date: Tue, 7 Apr 2009 22:02:52 -0400
Message-ID: <20090408020252.GA18244@coredump.intra.peff.net>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <1239139522-24118-2-git-send-email-mfwitten@gmail.com> <1239139522-24118-3-git-send-email-mfwitten@gmail.com> <1239139522-24118-4-git-send-email-mfwitten@gmail.com> <1239139522-24118-5-git-send-email-mfwitten@gmail.com> <1239139522-24118-6-git-send-email-mfwitten@gmail.com> <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com> <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com> <20090407220048.GB18144@coredump.intra.peff.net> <49DBCF5D.6070404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <exon@op5.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:04:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrN9R-0002ul-S7
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbZDHCC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbZDHCC4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:02:56 -0400
Received: from peff.net ([208.65.91.99]:58491 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbZDHCC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:02:56 -0400
Received: (qmail 11594 invoked by uid 107); 8 Apr 2009 02:02:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 22:02:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 22:02:52 -0400
Content-Disposition: inline
In-Reply-To: <49DBCF5D.6070404@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116016>

On Wed, Apr 08, 2009 at 12:10:37AM +0200, Andreas Ericsson wrote:

>>   2. Make a new command to compete with send-email instead of using the
>>      same name. This means that people who are really put off by
>>      CPAN dependencies from (1) above won't be negatively impacted. And
>>      you can drop any historical interface warts if you want to.
>>
>
> 3. Make it capable of sending email directly from commits rather than
>   than having to generate them as files first. For bonus-points, use
>   git sequencer or some other "git rebase -i"-esque mangling thing
>   first, with capabilities of adding a cover-letter for patch-series.

As Tomas noted, this is already possible (this was due to some patches
from Pierre a few months ago, I think). But IIRC, there are some corner
cases where send-email has to guess whether you mean rev-list options or
a file (or maybe there is some way to signal, I don't remember). And
that is exactly the sort of thing that you could clean up via (2) above.

-Peff
