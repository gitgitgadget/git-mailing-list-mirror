From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Jun 2008 01:33:02 -0400
Message-ID: <20080630053302.GA23786@sigill.intra.peff.net>
References: <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <20080630033034.GB18930@sigill.intra.peff.net> <7vwsk74hgr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 07:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDC1d-000815-2M
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 07:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbYF3FdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 01:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbYF3FdG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 01:33:06 -0400
Received: from peff.net ([208.65.91.99]:3179 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbYF3FdF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 01:33:05 -0400
Received: (qmail 25264 invoked by uid 111); 30 Jun 2008 05:33:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 30 Jun 2008 01:33:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2008 01:33:02 -0400
Content-Disposition: inline
In-Reply-To: <7vwsk74hgr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86875>

On Sun, Jun 29, 2008 at 10:31:00PM -0700, Junio C Hamano wrote:

> > Where do we want to take this? The conversation went something like:
> >
> >    me: here's a patch where we hint about "remote prune"
> >   you: why not just fix the refs, it's no worse than a rewind
> >    me: we kill reflogs, so it is different than a rewind
> >   you: oh, right
> >
> > So I'm not sure if that was "Oh, right, it's not a good idea to remove
> > the conflicting ref" or "Oh, right, but it's probably still fine."
> 
> It is "Oh right, it is Ok.  Let's cook it in 'next', have it in 'master'
> and then backmerge to 'maint'".

Sorry if I'm being slow, but what is "it" here? The "warning" patch I
sent, or a to-be-posted patch that deletes the conflicting ref?

-Peff
