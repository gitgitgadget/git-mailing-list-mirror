From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: Re: Working towards a common review format for git
Date: Fri, 8 Jan 2016 19:23:39 +0000
Message-ID: <20160108192339.GA3514@salo>
References: <20160108140831.GA10200@salo>
 <CAD0k6qRFPMZxLh4MtwkXwrk4GCjf64vWEd=9NPn-t_-uVHWz9g@mail.gmail.com>
 <CAD0k6qQBcfq0++d=-uyGpakmd+bsxuWYUWcn8auYJPy_HLddTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Edwin Kempin <ekempin@google.com>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 20:23:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHcdW-0001FO-O8
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 20:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbcAHTXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 14:23:41 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:42233 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630AbcAHTXk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 14:23:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id C20E34622BE;
	Fri,  8 Jan 2016 19:23:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jkqHg52bilzL; Fri,  8 Jan 2016 19:23:36 +0000 (GMT)
Received: from salo (salo.dyn.ducie.codethink.co.uk [10.24.2.138])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 41EA546082F;
	Fri,  8 Jan 2016 19:23:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAD0k6qQBcfq0++d=-uyGpakmd+bsxuWYUWcn8auYJPy_HLddTg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283576>

On Fri, Jan 08, 2016 at 09:53:53AM -0500, Dave Borowitz wrote:
> On Fri, Jan 8, 2016 at 9:24 AM, Dave Borowitz <dborowitz@google.com> wrote:
> > On Fri, Jan 8, 2016 at 9:08 AM, Richard Ipsum
> > <richard.ipsum@codethink.co.uk> wrote:
> >> Hi,
> >>
> >> In a prior email I mentioned in passing a library I've been working
> >> on to try to reach a common format for storing review content in git:
> >> perl-notedb.[1]
> >>
> >> I'm making reasonable progress with this but my work has uncovered
> >> necessary (and trivial) modifications to Notedb, the first[2] is a
> >> trivial modification to ensure the 'Status' trailer gets written
> >> to the commit when a change's status changes.
> >
> > I would consider this a bugfix, and will respond on that review.
> >
> >> The second[3] is an RFC
> >> where I suggest adding a 'Commit' trailer so that it is always
> >> possible to reference the commit under review by its sha.
> >
> > I think this is probably fine but I'll have to think about it some more.
> >
> >> With these patches applied to gerrit it's possible for perl-notedb to parse
> >> all meta content from notedb and map it to the actual git content
> >> under review. However, my concern at present is that I'm already
> >> operating under a fork of notedb which defeats the objective of
> >> collaborating to produce a standard format, let's try to avoid[4]
> >
> > I hope I can assuage some of your concerns by saying that since Gerrit
> > notedb is such a work in progress, literally nobody is running it in
> > the wild, so even if the formats diverge temporarily I don't see it as
> > being a long-term issue. But thank you for caring about it, I do
> > appreciate your proactive considerations.

Thanks, that's good to know,
thanks also for reviewing the modifications I mentioned. :)

> 
> You know what would probably also be a good idea would be to spec out
> the entire format in a standalone document. That way when Gerrit
> doesn't have something implemented, it's clear that Gerrit is wrong,
> not that it's trying to fork the format.

I think that would be good, I could attempt to write a spec for the format
and post it here for review? I expect I'll want to work a little more on
perl-notedb before I do that though.
