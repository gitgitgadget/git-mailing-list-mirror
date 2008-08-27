From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 15:05:56 -0600
Message-ID: <20080827210555.GF18340@parisc-linux.org>
References: <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:07:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSEV-0005G8-9G
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYH0VGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbYH0VGJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:06:09 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:43929 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbYH0VGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:06:08 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id 8ADF0494005; Wed, 27 Aug 2008 15:05:56 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <48B5BB35.8090606@pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93951>

On Wed, Aug 27, 2008 at 04:38:13PM -0400, Jeff Garzik wrote:
> I use it to spit out a patch for a specific commit:
> 
> 	git-diff-tree -p $COMMIT
> 
> Though probably someone will now come along and tell me I'm am 
> old-timer, and there is a shorter command that accomplishes the same 
> thing :)

git-show -p $COMMIT ?

It also gives you the commit message, but that's not a hardship usually
...

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
