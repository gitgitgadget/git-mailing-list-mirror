From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Fri, 7 Mar 2014 12:19:36 -0500
Message-ID: <20140307171936.GC23587@sigill.intra.peff.net>
References: <20140305185212.GA23907@sigill.intra.peff.net>
 <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
 <53183506.5080002@alum.mit.edu>
 <20140306155626.GB18519@sigill.intra.peff.net>
 <5318A537.4010400@alum.mit.edu>
 <20140306174803.GA30486@sigill.intra.peff.net>
 <08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
 <531904E1.6010606@alum.mit.edu>
 <xmqqob1ivqv4.fsf@gitster.dls.corp.google.com>
 <CAP8UFD0UnUGZb9hWyLS1vPJ6fh3QR-g_p5HNQk79Gqhs9YWi0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:19:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLyQx-00073z-71
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 18:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbaCGRTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 12:19:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:34852 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754033AbaCGRTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 12:19:38 -0500
Received: (qmail 27921 invoked by uid 102); 7 Mar 2014 17:19:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Mar 2014 11:19:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Mar 2014 12:19:36 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD0UnUGZb9hWyLS1vPJ6fh3QR-g_p5HNQk79Gqhs9YWi0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243619>

On Fri, Mar 07, 2014 at 08:08:37AM +0100, Christian Couder wrote:

> > Be it graft or replace, I do not think we want to invite people to
> > use these mechansims too lightly to locally rewrite their history
> > willy-nilly without fixing their mistakes at the object layer with
> > "commit --amend", "rebase", "bfg", etc. in the longer term.  So in
> > that sense, adding a command to make it easy is not something I am
> > enthusiastic about.
> >
> > On the other hand, if the user does need to use graft or replace
> > (perhaps to prepare for casting the fixed history in stone with
> > filter-branch), it would be good to help them avoid making mistakes
> > while doing so and tool support may be a way to do so.
> >
> > So, ... I am of two minds.
> 
> Maybe if we add a new command (or maybe a script) with a name long and
> cryptic-looking enough like "git create-replacement-object" it will
> scare casual users from touching it, while power users will be happy
> to benefit from it.

I do not think the features we are talking about are significantly more
dangerous than "git replace" is in the first place. If we want to make
people aware of the dangers, perhaps git-replace.1 is the right place to
do it.

-Peff
