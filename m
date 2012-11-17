From: Jeff King <peff@peff.net>
Subject: Re: using multiple version of git simultaneously
Date: Sat, 17 Nov 2012 08:16:32 -0800
Message-ID: <20121117161631.GA18844@sigill.intra.peff.net>
References: <k886on$nn5$1@ger.gmane.org>
 <1353163831-ner-9354@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: arif <aftnix@gmail.com>, git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 17:17:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZl51-0002lA-B0
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 17:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab2KQQQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 11:16:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51314 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab2KQQQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 11:16:40 -0500
Received: (qmail 8270 invoked by uid 107); 17 Nov 2012 16:17:26 -0000
Received: from mcb0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.203)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Nov 2012 11:17:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2012 08:16:32 -0800
Content-Disposition: inline
In-Reply-To: <1353163831-ner-9354@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209964>

On Sat, Nov 17, 2012 at 02:50:31PM +0000, Tomas Carnecky wrote:

> On Sat, 17 Nov 2012 20:25:21 +0600, arif <aftnix@gmail.com> wrote:
> > I'm trying to use different version of git simultaneously. So how can i
> > append some suffix (like "--program-suffix=git1.8) so that i can
> > distinguish between different versions.
> 
> Install each version into its own prefix (~/git/1.8.0/, ~/git/1.7.0/ etc).

Once you have done that, you can also symlink the binary from each into
your regular PATH (e.g., ln -s ~/git/1.8.0/bin/git ~/bin/git.v1.8) to
make it easy to switch between them. The installed exec-path is baked in
at compile-time, so it finds the correct git sub-programs properly.

I keep a couple dozen built versions of git around like this for quick
regression testing of bugs we see on the list.

-Peff
