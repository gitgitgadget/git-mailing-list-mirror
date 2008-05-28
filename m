From: Jeff King <peff@peff.net>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 18:38:58 -0400
Message-ID: <20080528223858.GA15107@sigill.intra.peff.net>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com> <7v1w3muw8j.fsf@gitster.siamese.dyndns.org> <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com> <7vod6qtgfs.fsf@gitster.siamese.dyndns.org> <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com> <7v3ao2tawd.fsf@gitster.siamese.dyndns.org> <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Thu May 29 00:39:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1UJH-0007hO-NN
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 00:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbYE1WjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 18:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbYE1WjB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 18:39:01 -0400
Received: from peff.net ([208.65.91.99]:4838 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbYE1WjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 18:39:01 -0400
Received: (qmail 31668 invoked by uid 111); 28 May 2008 22:38:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 28 May 2008 18:38:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 May 2008 18:38:58 -0400
Content-Disposition: inline
In-Reply-To: <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83141>

On Wed, May 28, 2008 at 02:14:59PM -0700, Geoffrey Irving wrote:

> > In manual pages, "SEE ALSO" section is a more appropriate place to do this
> > kind of thing.
> 
> Here's an improved patch.

The usual way to include a cover letter in a patch is either:

  Subject: [PATCH] commit message subject

  commit message

  ---
  your cover letter

  diffstat + diff

or (and I often use this in a reply where it makes sense to read the
cover letter first):

  Subject: Re: your mail

  cover letter

  -- >8 -- (any visual separator that is _not_ "---")
  commit message subject

  commit message

  ---
  diffstat + diff

In the second case, I believe Junio just manually deletes everything
above the separator.

> +See Also
> +--------
> +'git-patch-id(1)'::
> +       The mechanism git-cherry uses to compare changesets.
> +

This should be

  linkgit:git-patch-id[1]::

which will turn it into the text you wrote for a manpage, or a link in
the HTML version. Looks like we already have a few of the style you used
that should probably be fixed, though.

-Peff
