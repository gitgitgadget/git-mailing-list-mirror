From: Jeff King <peff@peff.net>
Subject: Re: Notes in format-patch (was: Re: [PATCHv3] replace: parse
 revision argument for -d)
Date: Tue, 13 Nov 2012 08:38:35 -0500
Message-ID: <20121113133834.GB20361@sigill.intra.peff.net>
References: <50A0B896.8050700@drmicha.warpmail.net>
 <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net>
 <50A2213B.4060505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 14:39:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYGhs-0005tt-5f
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 14:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab2KMNil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 08:38:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47307 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754986Ab2KMNik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 08:38:40 -0500
Received: (qmail 23661 invoked by uid 107); 13 Nov 2012 13:39:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 08:39:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 08:38:35 -0500
Content-Disposition: inline
In-Reply-To: <50A2213B.4060505@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209600>

On Tue, Nov 13, 2012 at 11:30:19AM +0100, Michael J Gruber wrote:

> Michael J Gruber venit, vidit, dixit 12.11.2012 15:18:
> > 'git replace' parses the revision arguments when it creates replacements
> > (so that a sha1 can be abbreviated, e.g.) but not when deleting
> > replacements.
> > 
> > Make it parse the argument to 'replace -d' in the same way.
> > 
> > Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> > ---
> > 
> > Notes:
> >     v3 safeguards the hex buffer against reuse
> >  builtin/replace.c  | 16 ++++++++++------
> >  t/t6050-replace.sh | 11 +++++++++++
> >  2 files changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/builtin/replace.c b/builtin/replace.c
> 
> By the way - Junio, is that the intented outcome of "format-patch
> --notes"? I would rather put the newline between the note and the
> diffstat (and omit the one after the ---) but may have goofed up a rebase:

I do not know was intended, but the above quoted output is hard to read,
and your suggested change looks way better.

-Peff
