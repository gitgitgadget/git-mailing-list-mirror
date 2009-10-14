From: Jeff King <peff@peff.net>
Subject: Re: git-commit feature request: pass editor command line options
Date: Wed, 14 Oct 2009 17:12:45 -0400
Message-ID: <20091014211245.GA21670@sigill.intra.peff.net>
References: <25885354.post@talk.nabble.com>
 <20091014172337.GE6115@genesis.frugalware.org>
 <7vvdihdc4f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Matthew Cline <matt@nightrealms.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 23:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyBEy-0004wC-32
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 23:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607AbZJNVNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 17:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759587AbZJNVNY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 17:13:24 -0400
Received: from peff.net ([208.65.91.99]:58208 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759548AbZJNVNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 17:13:23 -0400
Received: (qmail 32129 invoked by uid 107); 14 Oct 2009 21:16:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 14 Oct 2009 17:16:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 17:12:45 -0400
Content-Disposition: inline
In-Reply-To: <7vvdihdc4f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130340>

On Wed, Oct 14, 2009 at 12:11:28PM -0700, Junio C Hamano wrote:

> > Hmm, what is the use-case when using an option --foo is useful when
> > creating a commit, but not useful when crating a tag?
> >
> > Apart from introducing inconsistency...
> 
> Not between commit and tag, but I can see you may want to auto-wrap for
> log message but forbid auto-wrap when editing rebase insn sheet during
> "rebase -i".

I think most people who want that just have their editor automagically
recognize the different situations based on the file name or contents. I
don't think the original author is wrong to want to be able to use
command-line options to do so, but if he is using a common editor like
vim or emacs, I think such autodetection has already been written.

-Peff
