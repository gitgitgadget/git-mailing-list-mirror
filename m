From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 19:49:54 -0400
Message-ID: <48B5E822.1020901@pobox.com>
References: <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com> <alpine.LFD.1.10.0808271420210.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUnx-0004NK-Nc
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbYH0Xui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbYH0Xui
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:50:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50059 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbYH0Xuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:50:37 -0400
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KYUlw-0007Qu-H5; Wed, 27 Aug 2008 23:49:59 +0000
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.LFD.1.10.0808271420210.3363@nehalem.linux-foundation.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93991>

Linus Torvalds wrote:
> 
> On Wed, 27 Aug 2008, Jeff Garzik wrote:
>> I use it to spit out a patch for a specific commit:
>>
>> 	git-diff-tree -p $COMMIT
> 
> Use
> 
> 	git show $COMMIT
> 
> instead, which is shorter and gives you the log too, and uses a pager by 
> default. And defaults to HEAD, so you don't even need to say $COMMIT if 
> you want to see the top one. IOW, much nicer is so many ways.
> 
> Yeah, the "much nicer" obviously does mean "different". If you _rely_ on 
> the fact that you don't get a pager (you just want to scroll youself), or 
> you really don't want to see what the commit message was all about, then 
> 'git diff-tree' is obviously "better".

'git show' is quite sufficient, as long as I can pipe its output into 
patch(1) or write it to a foo.patch file, which appears to be the case.

git-diff-tree -p was from the old days; I readily admit being a git 
old-timer :)

Anything that reduces my typing is great, and 'git show' is certainly an 
improvement in that regard.

	Jeff, typing with a sprained finger (puppies can be a handful)
