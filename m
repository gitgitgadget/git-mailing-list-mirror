From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of
 "packfile"
Date: Tue, 19 May 2015 18:24:28 -0400
Message-ID: <20150519222427.GA994@peff.net>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
 <xmqqwq04745w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:24:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupwB-0005kG-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbbESWYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:24:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:32891 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751268AbbESWYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:24:31 -0400
Received: (qmail 19911 invoked by uid 102); 19 May 2015 22:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 17:24:30 -0500
Received: (qmail 18208 invoked by uid 107); 19 May 2015 22:24:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 18:24:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 18:24:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq04745w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269426>

On Tue, May 19, 2015 at 12:34:03PM -0700, Junio C Hamano wrote:

> A quick "git grep packfile" vs "git grep pack-file" inside
> Documentation/ directory indicates that we seem to use 'packfile'
> primarily in the lower-level technical documents that are not
> end-user facing.  Almost half of them are in the release notes
> that we won't bother "fixing", so it might make sense to go the
> other way around, consistently using "pack-file" that may be more
> familiar to end-users.
> 
> What do others think?

If I saw "pack-file" (outside of this discussion) I would think it was
wrong. That's just my opinion, of course.

Searching for "packfile" on the list yields 2145 messages. Searching for
"pack-file" yields 764. Searching for "pack file" yields 2007 (maybe
more, as my grep did not take into account line breaks).

-Peff
