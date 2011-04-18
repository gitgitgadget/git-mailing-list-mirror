From: Jeff King <peff@peff.net>
Subject: Re: Git notes list/show <revision-range>
Date: Mon, 18 Apr 2011 14:27:24 -0400
Message-ID: <20110418182724.GB11250@sigill.intra.peff.net>
References: <4DAC80CF.8020704@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>, bebarino@gmail.com,
	johan@herland.net
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBtAa-0001ZO-7m
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 20:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1DRS12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 14:27:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48725
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab1DRS11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 14:27:27 -0400
Received: (qmail 2902 invoked by uid 107); 18 Apr 2011 18:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Apr 2011 14:28:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Apr 2011 14:27:24 -0400
Content-Disposition: inline
In-Reply-To: <4DAC80CF.8020704@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171753>

On Mon, Apr 18, 2011 at 08:19:59PM +0200, Vincent van Ravesteijn wrote:

> When a feature/patch is proposed, it will "cook" for a while in "pu"
> and "next". During this period people can comment on the patch. These
> comments can be stored in git notes added to the commits on which is
> commented.

If you haven't already seen it, you might find the "notes/*" refs here:

  git://repo.or.cz/git/trast.git

They reference the messages discussing the patch on the mailing list by
message-id and gmane link.

> That's why I want to (try to) implement the feature that 'git notes
> list' and 'git notes show' accept a revision range and collect all
> notes for the commits in this range.

You can do more-or-less what you want with something like:

  git log --format="%h %s%n%N"
