From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 16:24:19 -0400
Message-ID: <48B5B7F3.4080803@pobox.com>
References: <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Willy Tarreau <w@1wt.eu>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:26:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRb1-0007kY-IJ
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbYH0UZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYH0UZT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:25:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57289 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbYH0UZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:25:18 -0400
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KYRYy-0006K9-Ev; Wed, 27 Aug 2008 20:24:22 +0000
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080826210631.GC3812@1wt.eu>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93941>

Willy Tarreau wrote:
> The problem is not caused by the number of commands, but by their
> complexity. I need completion because it's hard to type their very
> long names without making mistakes (not counting the long options).
> "git am" is fine with me, but "git format-patch" is quite boring to
> type. It's also interesting to note that short names are currently
> in place for less commonly used commands : git-rm, git-mv, git-gc.

Indeed.

Also, I type "git-diff-tree" quite a lot.

My fingers find that

	git SPACE diff DASH tree

is slower and less consistent than

	git DASH diff DASH tree

The same with git-format-patch...  We are going from "all dashes" to "a 
mix of space and dashes" which is increasing inconsistency.

	Jeff
