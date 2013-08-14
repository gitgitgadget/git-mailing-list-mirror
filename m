From: Jeff King <peff@peff.net>
Subject: Re: Possible git bug
Date: Wed, 14 Aug 2013 02:53:40 -0400
Message-ID: <20130814065339.GA3744@sigill.intra.peff.net>
References: <9c9e5ea8a9d7e8ef37201cfb8ca9dcc3@davenport.net.nz>
 <CACx-yZ3Ba2vU4Jhjdtp1Ko=VjwarDkdHtN7ZFCzrU9Pz7-+S_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hugh Davenport <hugh@davenport.net.nz>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Daniel Knittl-Frank <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 08:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Uxn-0001Xd-0R
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 08:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab3HNGxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 02:53:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:35183 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab3HNGxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 02:53:42 -0400
Received: (qmail 3154 invoked by uid 102); 14 Aug 2013 06:53:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 01:53:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 02:53:40 -0400
Content-Disposition: inline
In-Reply-To: <CACx-yZ3Ba2vU4Jhjdtp1Ko=VjwarDkdHtN7ZFCzrU9Pz7-+S_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232262>

On Wed, Aug 14, 2013 at 07:42:11AM +0200, Daniel Knittl-Frank wrote:

> > So would that be a bug? Or maybe a feature? I would like it that
> > when you do a rebase and select no commits, it will rebase ontop of
> > the commit you chose, and remove all the commits not shown in the
> > interactive listing (so all).
> 
> You can just use `git reset --hard <commit to rollback to>`  to
> discard all commits after the given commit (Unless they're part of
> another branch, of course). `git reset --soft` if you want to keep the
> state of your current working directory.

You can also use a "noop" line in the rebase instruction list rather
than a completely blank list to mean "yes, really, do not apply any
commits".

-Peff
