From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Sun, 9 Jun 2013 14:13:02 -0400
Message-ID: <20130609181302.GD810@sigill.intra.peff.net>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
 <20130609060807.GA8906@sigill.intra.peff.net>
 <vpq38srtun7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	celestin.matte@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulk75-00025V-O8
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab3FISNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:13:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:37259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab3FISNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:13:06 -0400
Received: (qmail 18755 invoked by uid 102); 9 Jun 2013 18:13:55 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 13:13:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 14:13:02 -0400
Content-Disposition: inline
In-Reply-To: <vpq38srtun7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227080>

On Sun, Jun 09, 2013 at 01:01:48PM +0200, Matthieu Moy wrote:

> > I also wonder if it would be useful to be able to specify not only files
> > in the filesystem, but also arbitrary blobs. So in 4b above, you could
> > "git mw preview origin:page.mw" to see the rendered version of what
> > upstream has done.
> 
> Next step could even be "git mw diff $from $to", using the wiki to
> render the diff. Not a priority, but could be funny.

I was actually thinking along the same lines. I often do something
similar with Git's documentation. When you are tweaking the formatting
or an asciidoc knob, it is useful to diff the rendered output to check
that the changes had the effect you wanted.

I usually have done so by hand, but I actually wonder if "git difftool"
could be used as a wrapper for this (I suspect not, because you have to
deal with the whole build tree, not just individual blobs).

-Peff
