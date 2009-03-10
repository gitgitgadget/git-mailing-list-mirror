From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 13:52:33 -0400
Message-ID: <20090310175233.GA26351@sigill.intra.peff.net>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh69Y-0003pn-HX
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 18:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbZCJRwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbZCJRwi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 13:52:38 -0400
Received: from peff.net ([208.65.91.99]:57377 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbZCJRwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 13:52:38 -0400
Received: (qmail 12805 invoked by uid 107); 10 Mar 2009 17:52:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 10 Mar 2009 13:52:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 13:52:33 -0400
Content-Disposition: inline
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112836>

On Mon, Mar 09, 2009 at 11:35:44PM +0100, Finn Arne Gangstad wrote:

> git push has learned two new command line options --matching and
> --current, which override any configuration.  'matching' pushes all
> branches that already exist at the remote, while 'current' pushes the
> current branch to whatever it is tracking

I have not been following this topic too closely, so can you please
explain (or point me to an explanation about) something? How do these
options interact with refspecs given on the command line? That is, why
would I choose to use:

  git push --current

over

  git push - HEAD

(assuming your earlier patch is applied, or "git push HEAD" if Junio's
suggested DWIMmery is implemented). And what does it mean to say

  git push --matching - HEAD

? Those are conflicting instructions. Is one followed and one discarded?
Are they merged?

-Peff
