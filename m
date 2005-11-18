From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 21:55:13 +0100
Message-ID: <20051118205513.GA3168@vrfy.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:55:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDGa-0007ov-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbVKRUzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161214AbVKRUzY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:55:24 -0500
Received: from soundwarez.org ([217.160.171.123]:24197 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1161199AbVKRUzY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 15:55:24 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 1ED4F684B1; Fri, 18 Nov 2005 21:55:13 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12261>

On Fri, Nov 18, 2005 at 12:22:34PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 18 Nov 2005, Ismail Donmez wrote:
> > 
> > > And git guys, please start to think again about your insane options,
> > > that cause more harm than anything good.
> > 
> > Can git maintainer(s) comment on this please? 
> 
> It's easy to say "just do the right thing", and ignore reality.

Well the reality tells that everything that is successful does not give
too many options that harm adoption. For me it's a very simple and "real"
rule.

It's all about a sane default, which git obviously doesn't have. You
guys may look at it from the very low level, but that isn't what I call
"reality".

> git commit logs have always been "8-bit data". It's actually gitweb that 
> is buggy if it claims it is UTF-8 without checking or converting it to 
> such.

Actually, the real bug is not to try to prevent binary nonsense in textual
commit logs, which are distibuted. Remember, that you provide a SCM not a
filesystem.

> I agree that UTF-8 is a good idea, but that's a totally different 
> argument.

Well, I don't see real arguments against sane a default.

Thanks,
Kay
