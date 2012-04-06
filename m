From: Jeff King <peff@peff.net>
Subject: Re: Status shows untracked directory without any untracked file in it
Date: Fri, 6 Apr 2012 18:04:01 -0400
Message-ID: <20120406220401.GA31346@sigill.intra.peff.net>
References: <CAGAhT3n3hHV+UhT+D1o60OAS23WFmx+Lxg=aqYMGC=U-LR1QUA@mail.gmail.com>
 <20120406061447.GC25301@sigill.intra.peff.net>
 <CAGAhT3nmOtZLusT8DXy9iWQsNkH2Pqc3YCf-22FZJ-fhHf38cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 00:04:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGHGL-0007Tg-OZ
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 00:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223Ab2DFWEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 18:04:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52804
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab2DFWED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 18:04:03 -0400
Received: (qmail 12634 invoked by uid 107); 6 Apr 2012 22:04:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 18:04:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 18:04:01 -0400
Content-Disposition: inline
In-Reply-To: <CAGAhT3nmOtZLusT8DXy9iWQsNkH2Pqc3YCf-22FZJ-fhHf38cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194916>

[Please keep replies on the list, so others can benefit from the
 discussion. And please don't top-post.]

On Fri, Apr 06, 2012 at 09:30:20AM -0700, Alexander Kostikov wrote:

> Windows. 1.7.9.msysgit.0
> 
> On Thu, Apr 5, 2012 at 11:14 PM, Jeff King <peff@peff.net> wrote:
> >
> > Maybe. What git version and what platform are you on? There was a bug in
> > versions of git earlier than v1.7.8 that showed the symptom you describe
> > on case-insensitive filesystems. It was fixed by commit 2548183, which
> > contains more details.

Your version should have the fix, so it may be a new issue. Is it easily
reproducible? Can you share a short reproduction recipe, or possibly
share the repo showing the problem?

-Peff
