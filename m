From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext
Date: Sun, 4 Nov 2012 08:45:03 -0500
Message-ID: <20121104134503.GB31623@sigill.intra.peff.net>
References: <20121029094207.deafafed22ea70fbc4fbd4bb@lavabit.com>
 <20121102145425.GC11170@sigill.intra.peff.net>
 <20121102141809.caf5cbc07f08769fd6a302ad@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: rh <richard_hubbe11@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV0Vr-000608-W3
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 14:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab2KDNpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 08:45:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56604 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839Ab2KDNpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 08:45:05 -0500
Received: (qmail 23821 invoked by uid 107); 4 Nov 2012 13:45:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 04 Nov 2012 08:45:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Nov 2012 08:45:03 -0500
Content-Disposition: inline
In-Reply-To: <20121102141809.caf5cbc07f08769fd6a302ad@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209028>

On Fri, Nov 02, 2012 at 02:18:09PM -0700, rh wrote:

> > I think the patch itself looks OK, but:
> > 
> >   1. It isn't formatted to apply with git-am. Please use
> >      git-format-patch.
> 
> git format-patch command wouldn't work for me. I can see that you
> don't need more stuff to do but not knowing git I couldn't find the
> correct incantation to do this part. A problem with the files not
> being in a git repo I think. I'll spare you details.

The usual procedure is:

  1. hack hack hack

  2. git commit

  3. git format-patch

And if you are not in a git repo, step 0 is "git init". :)

-Peff
