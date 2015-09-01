From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Tue, 1 Sep 2015 18:44:31 -0400
Message-ID: <20150901224431.GA9353@sigill.intra.peff.net>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWuIN-0003ug-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbbIAWos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:44:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:53433 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750856AbbIAWod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:44:33 -0400
Received: (qmail 32061 invoked by uid 102); 1 Sep 2015 22:44:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:44:33 -0500
Received: (qmail 6979 invoked by uid 107); 1 Sep 2015 22:44:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:44:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:44:31 -0400
Content-Disposition: inline
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277069>

On Tue, Sep 01, 2015 at 10:55:38PM +0100, John Keeping wrote:

> Jeff's first patch is unmodified but I've squashed the fixed currently
> on "pu" into the second.  I also realised while adding the tests that
> "raw-local" is meaningless so I've modified the code to reject it in the
> same way as "relative-local".
> 
> Jeff King (2):
>   fast-import: switch crash-report date to iso8601
>   date: make "local" orthogonal to date format
> 
> John Keeping (4):
>   t6300: introduce test_date() helper
>   t6300: make UTC and local dates different
>   t6300: add test for "raw" date format
>   t6300: add tests for "-local" date formats

Looks like we've agreed on disallowing "raw-local"[1] for the 2nd patch.
The other 4 all look good to me, with the exception of the line-wrapping
on 3/6.  Thanks for taking care of this.

-Peff

[1] I do think the error message for "relative-local is nonsense" could
    perhaps be more explanatory, but I couldn't come up with any better
    wording. But if you have ideas, feel free to switch it.
