From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] limit the usage of the default remote "origin" to
	the minimum
Date: Tue, 29 Apr 2008 19:12:01 -0400
Message-ID: <20080429231201.GA22646@sigill.intra.peff.net>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <20080429193536.GA19340@sigill.intra.peff.net> <7vwsmg5nqv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	spearce@spearce.org, johannes.schindelin@gmx.de, srb@cuci.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:12:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqz0F-0004y5-T9
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbYD2XME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755144AbYD2XME
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:12:04 -0400
Received: from peff.net ([208.65.91.99]:1769 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791AbYD2XMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:12:03 -0400
Received: (qmail 23284 invoked by uid 111); 29 Apr 2008 23:12:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 19:12:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 19:12:01 -0400
Content-Disposition: inline
In-Reply-To: <7vwsmg5nqv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80767>

On Tue, Apr 29, 2008 at 02:56:24PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... The principle of "remove defaults from code, and
> > put them into the automatically generated config file" makes sense to
> > me. It gives users an easy place to look to understand and change such
> > behavior. So even without the rest of the patches, I think this is an
> > improvement.
> 
> If the removal of defaults do not break expectations of users of an
> existing repository, I'd agree.  Is it the case, or the lack of default
> that is supposed to be there now suddenly makes the tool do unexpected
> things?

I think in the case of patches 1 and 2 (but without the later patches)
it becomes redundant. And of course, Paolo's idea is that it opens us up
to changing the default later, in which case it will cease to be
redundant. But I think even in the meantime that it gives the user
a clue when looking in the config file about what can be tweaked.

> > ... I
> > assume people still with ancient .git/remotes files? Are those actually
> > deprecated?
> 
> No.
> 
> Neither .git/branches.  When you interact with hundreds of remote
> repositories, one interesting branch per each, like akpm does, the format
> of one-file-per-remote is far easier and simpler to work with.

Then in that case, I think the warning is definitely bogus.

-Peff
