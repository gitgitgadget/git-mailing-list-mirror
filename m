From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] t1500: avoid changing working directory outside
 of tests
Date: Tue, 17 May 2016 17:52:14 -0400
Message-ID: <20160517215214.GA16905@sigill.intra.peff.net>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
 <20160517193630.10379-4-sunshine@sunshineco.com>
 <xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTAgB6DXoEeJaDVy7_J7QiqNOm6AJqZTiSowO6_jqa8_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 17 23:52:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2muc-0005Ri-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 23:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbcEQVwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 17:52:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:40976 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750821AbcEQVwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 17:52:18 -0400
Received: (qmail 16318 invoked by uid 102); 17 May 2016 21:52:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 17:52:17 -0400
Received: (qmail 18217 invoked by uid 107); 17 May 2016 21:52:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 17:52:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2016 17:52:14 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTAgB6DXoEeJaDVy7_J7QiqNOm6AJqZTiSowO6_jqa8_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294916>

On Tue, May 17, 2016 at 04:48:33PM -0400, Eric Sunshine wrote:

> On Tue, May 17, 2016 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +                     git ${dir:+-C "$dir"} rev-parse --$o >actual &&
> >
> > This is kosher POSIX, but I vaguely recall some shells had trouble
> > with the SP between -C and "$dir" in the past.  Let's see if anybody
> > screams; hopefully I am misremembering or buggy shells died out.
> 
> I also am bothered by a vague recollection of some issue (possibly
> involving the internal space and lack of quotes around the entire
> ${...}), but couldn't remember nor find a reference to the specific
> details. Perhaps someone reading the patch has a better memory than I.

Probably:

  http://thread.gmane.org/gmane.comp.version-control.git/265094

-Peff
