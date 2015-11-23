From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Mon, 23 Nov 2015 13:58:12 -0500
Message-ID: <20151123185812.GC2597@sigill.intra.peff.net>
References: <20151120140937.GA17079@sigill.intra.peff.net>
 <CAOLa=ZRpvd-Nd9HiZMt6aZF9bi5i1MHNDZUSdUsGC9C-t+2bSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0wJk-00049Y-NL
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 19:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbbKWS6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 13:58:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:32927 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755134AbbKWS6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 13:58:14 -0500
Received: (qmail 18229 invoked by uid 102); 23 Nov 2015 18:58:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Nov 2015 12:58:14 -0600
Received: (qmail 4858 invoked by uid 107); 23 Nov 2015 18:58:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Nov 2015 13:58:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2015 13:58:12 -0500
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRpvd-Nd9HiZMt6aZF9bi5i1MHNDZUSdUsGC9C-t+2bSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281591>

On Mon, Nov 23, 2015 at 12:02:35AM +0530, Karthik Nayak wrote:

> > * kn/for-each-branch-remainder (2015-10-02) 9 commits
> >  - branch: implement '--format' option
> >  - branch: use ref-filter printing APIs
> >  - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
> >  - ref-filter: introduce format_ref_array_item()
> >  - ref-filter: adopt get_head_description() from branch.c
> >  - ref-filter: modify "%(objectname:short)" to take length
> >  - ref-filter: add support for %(path) atom
> >  - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
> >  - ref-filter: implement %(if), %(then), and %(else) atoms
> >
> >  More unification among "branch -l", "tag -l" and "for-each-ref --format".
> >
> >  Expecting a reroll.
> >  ($gmane/278926)
> >
> 
> This series is supposed to follow this:
> http://thread.gmane.org/gmane.comp.version-control.git/281180 which I
> recently sent.
> So replace "for-each-branch-remainder" with this in "Whats cooking"?

Thanks, it was on my "leftover topics to pick up" list. I'll make sure
it gets updated in the next cycle.

-Peff
