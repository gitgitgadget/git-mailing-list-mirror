From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Jun 2008 23:30:34 -0400
Message-ID: <20080630033034.GB18930@sigill.intra.peff.net>
References: <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 05:31:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDA73-0003c9-L9
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 05:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbYF3Dah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 23:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYF3Dah
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 23:30:37 -0400
Received: from peff.net ([208.65.91.99]:2225 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbYF3Dag (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 23:30:36 -0400
Received: (qmail 24710 invoked by uid 111); 30 Jun 2008 03:30:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 29 Jun 2008 23:30:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jun 2008 23:30:34 -0400
Content-Disposition: inline
In-Reply-To: <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86868>

On Sun, Jun 29, 2008 at 01:55:13AM -0700, Junio C Hamano wrote:

> * jk/maint-fetch-ref-hier (Thu Jun 26 23:59:50 2008 -0400) 1 commit
>  + fetch: report local storage errors in status table
> 
> When the remote used to have "foo" branch but now has "foo/bar", fetch
> refuses to delete the existing remote tracking branch "foo" to create a
> new remote tracking branch "foo/bar", but the error message was
> confusing.

Where do we want to take this? The conversation went something like:

   me: here's a patch where we hint about "remote prune"
  you: why not just fix the refs, it's no worse than a rewind
   me: we kill reflogs, so it is different than a rewind
  you: oh, right

So I'm not sure if that was "Oh, right, it's not a good idea to remove
the conflicting ref" or "Oh, right, but it's probably still fine."

-Peff
