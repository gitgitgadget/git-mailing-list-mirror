From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: fix unmatched code fences
Date: Tue, 12 May 2015 23:45:53 -0400
Message-ID: <20150513034553.GA25025@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <xmqqk2wdcfbb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 05:46:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsNcP-0002lx-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 05:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934309AbbEMDp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 23:45:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:57562 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934202AbbEMDp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 23:45:56 -0400
Received: (qmail 30966 invoked by uid 102); 13 May 2015 03:45:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 22:45:56 -0500
Received: (qmail 6491 invoked by uid 107); 13 May 2015 03:45:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:45:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2015 23:45:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2wdcfbb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268920>

On Tue, May 12, 2015 at 08:43:52PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > With this patch and the one from Jean-Noel, the script above finds only
> > one hit, which is a false positive. It's at git-commit.txt:233, and it
> > looks like:
> >
> >     It is a rough equivalent for:
> >     ------
> >             $ git reset --soft HEAD^
> >             $ ... do something else to come up with the right tree ...
> >             $ git commit -c ORIG_HEAD
> >
> >     ------
> >
> > I have no idea how asciidoc knows that this is a code block and not a
> > title called "It is a rough...".
> 
> It obviously is not a title underline as the lengths are vastly
> different.

Yes, but Python Asciidoc allows the lengths to differ. So clearly it
uses some kind of heuristic, or this is some context in the parser that
disambiguates the case.

-Peff
