From: Jeff King <peff@peff.net>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Mon, 2 May 2011 16:42:35 -0400
Message-ID: <20110502204235.GA13584@sigill.intra.peff.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
 <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 22:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGzx7-0001xU-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 22:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab1EBUmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 16:42:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43431
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab1EBUmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 16:42:37 -0400
Received: (qmail 8682 invoked by uid 107); 2 May 2011 20:44:20 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 May 2011 16:44:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2011 16:42:35 -0400
Content-Disposition: inline
In-Reply-To: <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172630>

On Mon, May 02, 2011 at 01:36:24PM -0700, Junio C Hamano wrote:

> And a matching "rev-parse" update should look like this.  I wonder if we
> could share some code between the two, though...
> 
>  Documentation/revisions.txt |    7 +++++++
>  builtin/rev-parse.c         |   16 ++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)

The doc update looks good to me. The duplication in rev-parse is pretty
gross, but that is certainly not a problem you are introducing. It would
be nice to clean it up, but I don't know how painful that would be.  It
seems like rev-parse should just be calling handle_revision_arg, but I'm
sure there are some nasty corner cases. IOW, I am not volunteering. :)

-Peff
