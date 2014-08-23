From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] fix pack-refs pruning of refs/foo
Date: Sat, 23 Aug 2014 03:46:11 -0400
Message-ID: <20140823074611.GA23670@peff.net>
References: <20140823052334.GA17813@peff.net>
 <53F842E0.8000603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 23 09:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL61h-0000hS-LK
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 09:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbaHWHqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 03:46:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:57316 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752440AbaHWHqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 03:46:13 -0400
Received: (qmail 20752 invoked by uid 102); 23 Aug 2014 07:46:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 02:46:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 03:46:11 -0400
Content-Disposition: inline
In-Reply-To: <53F842E0.8000603@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255739>

On Sat, Aug 23, 2014 at 09:29:36AM +0200, Michael Haggerty wrote:

> >   [1/5]: git-prompt: do not look for refs/stash in $GIT_DIR
> >   [2/5]: pack-refs: prune top-level refs like "refs/foo"
> >   [3/5]: fast-import: clean up pack_data pointer in end_packfile
> >   [4/5]: fast-import: fix buffer overflow in dump_tags
> >   [5/5]: fast-import: stop using lock_ref_sha1
> 
> +1 on patches 1 and 2
> Patch 3 is outside of my area of competence
> +1 on patch 4, which looks trivially correct.
> +1 on patch 5, though I agree with peff that it can be omitted in
> deference to Ronnie's work.

Thanks.

> By the way, while cleaning up in patch 5 you might take the chance to
> rename the local variable ref_name to refname to be consistent with most
> of our code, but this is by no means required.

I had the exact same inclination, but dismissed it as me being too
picky. :)

I'll change it if I re-roll, but I think we'll end up just dropping that
patch entirely.

-Peff
