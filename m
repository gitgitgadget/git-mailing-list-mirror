From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 00:13:26 +0300
Message-ID: <20080827211326.GI11734@cs181140183.pp.htv.fi>
References: <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com> <20080827210555.GF18340@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Andi Kleen <andi@firstfloor.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Matthew Wilcox <matthew@wil.cx>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSMP-0007yq-Ca
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYH0VOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYH0VOV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:14:21 -0400
Received: from smtp4.pp.htv.fi ([213.243.153.38]:49836 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178AbYH0VOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:14:20 -0400
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 65C465BC026;
	Thu, 28 Aug 2008 00:14:19 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080827210555.GF18340@parisc-linux.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93952>

On Wed, Aug 27, 2008 at 03:05:56PM -0600, Matthew Wilcox wrote:
> On Wed, Aug 27, 2008 at 04:38:13PM -0400, Jeff Garzik wrote:
> > I use it to spit out a patch for a specific commit:
> > 
> > 	git-diff-tree -p $COMMIT
> > 
> > Though probably someone will now come along and tell me I'm am 
> > old-timer, and there is a shorter command that accomplishes the same 
> > thing :)
> 
> git-show -p $COMMIT ?
> 
> It also gives you the commit message, but that's not a hardship usually
> ...

I'm usually using
  git-show --pretty=oneline $COMMIT

cu
Adrian

BTW: I'd love to get a --pretty=noline

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
