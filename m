From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 16:27:07 -0400
Message-ID: <20080827202707.GA25233@coredump.intra.peff.net>
References: <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Willy Tarreau <w@1wt.eu>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRcl-0008NI-Md
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYH0U1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbYH0U1K
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:27:10 -0400
Received: from peff.net ([208.65.91.99]:3832 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbYH0U1K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:27:10 -0400
Received: (qmail 16202 invoked by uid 111); 27 Aug 2008 20:27:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 27 Aug 2008 16:27:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 16:27:07 -0400
Content-Disposition: inline
In-Reply-To: <48B5B7F3.4080803@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93942>

On Wed, Aug 27, 2008 at 04:24:19PM -0400, Jeff Garzik wrote:

> Indeed.
>
> Also, I type "git-diff-tree" quite a lot.
>
> My fingers find that
>
> 	git SPACE diff DASH tree
>
> is slower and less consistent than
>
> 	git DASH diff DASH tree
>
> The same with git-format-patch...  We are going from "all dashes" to "a  
> mix of space and dashes" which is increasing inconsistency.

I have also found the SPACE-DASH slightly harder to type. However, I'm
curious: what are you doing frequently from the commandline with
git-diff-tree that is not just as easily done with git-diff?

-Peff
