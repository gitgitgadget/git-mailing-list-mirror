From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: Jobs and skipSubmitEdit
Date: Tue, 17 Jul 2012 21:03:04 -0400
Message-ID: <20120718010304.GA24602@padd.com>
References: <CAFLRbop2aETNp0-6AdvSTx7Jmh7epYZ6rQc6hhFHbxZrGdEo9g@mail.gmail.com>
 <20120624202445.GA27664@padd.com>
 <CAFLRbootAje0BvLOYiH2xOagfUsQ+a_d+9YeTuG1C0a1Pg__Rg@mail.gmail.com>
 <20120626112115.GA3439@padd.com>
 <CAFLRbooDpeE0U+sysa=OZ2a1sPvPo9MYTi4KLRgfJxkxw2HQyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <mike@horowitz.name>
X-From: git-owner@vger.kernel.org Wed Jul 18 03:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrIg0-0006Pu-5a
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 03:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab2GRBDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 21:03:14 -0400
Received: from honk.padd.com ([74.3.171.149]:50113 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab2GRBDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 21:03:09 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 4B8331E43;
	Tue, 17 Jul 2012 18:03:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E47E43145F; Tue, 17 Jul 2012 21:03:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAFLRbooDpeE0U+sysa=OZ2a1sPvPo9MYTi4KLRgfJxkxw2HQyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201640>

mike@horowitz.name wrote on Tue, 17 Jul 2012 04:49 -0400:
> I gave the patch a try, and it seems to work great.
> 
> Only problem I realized is that it means that the git commit message
> and the p4 log message end up different, because to p4 the jobs lines
> are special and get stripped out, but in git it just stays part of the
> commit message.  So, when you do a p4 sync/rebase, the commits come
> back without it.  This doesn't make much of difference now, because
> the commit messages come back modified with the p4 path and changelist
> number anyway, but if Luke tries to do that change to store the p4
> path/changelist in notes instead, then we wouldn't want any
> differences in the commit messages, because then the commits hashes
> won't match again.
> 
> Not sure what the best thing to do here is, but I guess it doesn't
> matter until this mythical notes thing happens.

Glad it works.

I didn't think about trying to make the commit messages exact.
That isn't required for, e.g. "git cherry", but might be nice
just to make git/p4 view of the changes more similar.

Okay if we wait and see how the notes stuff goes, like you
suggest.  Could be that Jobs ends up in a note too.

Thanks for testing.

		-- Pete
