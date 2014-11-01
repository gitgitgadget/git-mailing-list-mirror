From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2014, #08; Fri, 31)
Date: Sat, 1 Nov 2014 00:09:32 -0400
Message-ID: <20141101040932.GC8307@peff.net>
References: <xmqqzjccrm53.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 05:09:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkQ0Q-0005BV-QQ
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 05:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaKAEJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2014 00:09:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:35616 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbaKAEJe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2014 00:09:34 -0400
Received: (qmail 15127 invoked by uid 102); 1 Nov 2014 04:09:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Oct 2014 23:09:34 -0500
Received: (qmail 18111 invoked by uid 107); 1 Nov 2014 04:09:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Nov 2014 00:09:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Nov 2014 00:09:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjccrm53.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 31, 2014 at 01:59:20PM -0700, Junio C Hamano wrote:

> --------------------------------------------------
> [Discarded]
> 
> * jk/tag-contains (2014-06-30) 8 commits
>  . perf: add tests for tag --contains
>  . tag: use commit_contains
>  . commit: provide a fast multi-tip contains function
>  . string-list: add pos to iterator callback
>  . add functions for memory-efficient bitmaps
>  . paint_down_to_common: use prio_queue
>  . tag: factor out decision to stream tags
>  . tag: allow --sort with -n
> 
>  Expecting a reroll.

Seems reasonable.  I am still planning to re-roll this eventually, but I
do not think there is a deep need to carry it in your tree for the time
being.

> * jk/makefile (2014-02-05) 16 commits
>  . FIXUP
>  . move LESS/LV pager environment to Makefile
>  . Makefile: teach scripts to include make variables
>  . FIXUP
>  . Makefile: auto-build C strings from make variables
>  . Makefile: drop *_SQ variables
>  . FIXUP
>  . Makefile: add c-quote helper function
>  . Makefile: introduce sq function for shell-quoting
>  . Makefile: always create files via make-var
>  . Makefile: store GIT-* sentinel files in MAKE/
>  . Makefile: prefer printf to echo for GIT-*
>  . Makefile: use tempfile/mv strategy for GIT-*
>  . Makefile: introduce make-var helper function
>  . Makefile: fix git-instaweb dependency on gitweb
>  . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS
> 
>  Simplify the Makefile rules and macros that exist primarily for
>  quoting purposes, and make it easier to robustly express the
>  dependency rules.
> 
>  Expecting a reroll.

I was surprised you carried this in your tree for so long. I do like the
direction it was going, but I was not 100% convinced that it was
something _other_ people liked, and I never really prioritized getting
back to it. Did you actually like it and really wanted to see it
finished, or did just kind of hang around because you had never bothered
to drop it?

Or do you not remember enough anymore to have an opinion? :)

-Peff
