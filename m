From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/8] fprintf(stderr, "warning: ") -> warning() patches
Date: Thu, 19 Feb 2009 13:52:49 +0100
Message-ID: <cover.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8Q0-0000oL-3j
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbZBSMww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZBSMww
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:52:52 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47434 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbZBSMwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:52:51 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1C684580D1;
	Thu, 19 Feb 2009 13:52:51 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9F025446A6;
	Thu, 19 Feb 2009 13:52:49 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D9AC011B877C; Thu, 19 Feb 2009 13:52:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090219122104.GA4602@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110685>

On Thu, Feb 19, 2009 at 07:21:05AM -0500, Jeff King <peff@peff.net> wrote:
>   - there are several places that manually print "warning: " via
>     fprintf. I suppose those can be cleaned up to use warning(), too.

Here are 8 patches to do so. This does not contain the http-push patch I
send already in this thread, nor your patch.

Miklos Vajna (8):
  builtin-apply: use warning() instead of fprintf(stderr, "warning: ")
  builtin-checkout: use warning() instead of fprintf(stderr, "warning:
    ")
  builtin-fetch-pack: use warning() instead of fprintf(stderr,
    "warning: ")
  builtin-init-db: use warning() instead of fprintf(stderr, "warning:
    ")
  builtin-rm: use warning() instead of fprintf(stderr, "warning: ")
  builtin-show-branch: use warning() instead of fprintf(stderr,
    "warning: ")
  builtin-show-ref: use warning() instead of fprintf(stderr, "warning:
    ")
  refs: use warning() instead of fprintf(stderr, "warning: ")

 builtin-apply.c       |   15 +++++++--------
 builtin-checkout.c    |    4 ++--
 builtin-fetch-pack.c  |    2 +-
 builtin-init-db.c     |    7 +++----
 builtin-rm.c          |    3 +--
 builtin-show-branch.c |    3 +--
 builtin-show-ref.c    |    2 +-
 refs.c                |    8 +++-----
 8 files changed, 19 insertions(+), 25 deletions(-)
