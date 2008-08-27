From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 16:38:13 -0400
Message-ID: <48B5BB35.8090606@pobox.com>
References: <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Willy Tarreau <w@1wt.eu>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:40:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRog-0004La-57
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYH0UjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYH0UjV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:39:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42383 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbYH0UjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:39:21 -0400
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KYRmQ-0006O1-Vz; Wed, 27 Aug 2008 20:38:16 +0000
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080827202707.GA25233@coredump.intra.peff.net>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93946>

Jeff King wrote:
> On Wed, Aug 27, 2008 at 04:24:19PM -0400, Jeff Garzik wrote:
> 
>> Indeed.
>>
>> Also, I type "git-diff-tree" quite a lot.
>>
>> My fingers find that
>>
>> 	git SPACE diff DASH tree
>>
>> is slower and less consistent than
>>
>> 	git DASH diff DASH tree
>>
>> The same with git-format-patch...  We are going from "all dashes" to "a  
>> mix of space and dashes" which is increasing inconsistency.
> 
> I have also found the SPACE-DASH slightly harder to type. However, I'm
> curious: what are you doing frequently from the commandline with
> git-diff-tree that is not just as easily done with git-diff?

I use it to spit out a patch for a specific commit:

	git-diff-tree -p $COMMIT

Though probably someone will now come along and tell me I'm am 
old-timer, and there is a shorter command that accomplishes the same 
thing :)

Regards,

	Jeff
