From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: multiple-commit cherry-pick?
Date: Sun, 9 Nov 2008 11:25:28 +0100
Message-ID: <20081109102528.GA5463@blimp.localdomain>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain> <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzb9D-0003sK-96
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 19:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYKJSEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 13:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbYKJSEp
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 13:04:45 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:23966 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbYKJSEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 13:04:44 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8A081oLA=
Received: from tigra.home (Fac0f.f.strato-dslnet.de [195.4.172.15])
	by post.webmailer.de (klopstock mo40) (RZmta 17.18)
	with ESMTP id L06558kAAHJB2y ; Mon, 10 Nov 2008 19:04:40 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 4BB58277D0;
	Mon, 10 Nov 2008 19:04:40 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 0E8DA36D27; Sun,  9 Nov 2008 11:25:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100537>

Linus Torvalds, Fri, Nov 07, 2008 19:08:36 +0100:
> On Fri, 7 Nov 2008, Alex Riesen wrote:
> > 
> > Does not work if there are ranges given :-/
> > It'd be very nice to have: git show #c1..$c2 $c3 $c4 $c5..$c6
> 
> Yeah, we've very fundamentally never supported that. Not for show, but 
> also not for anything else (ie "gitk a..b c..d" does _not_ give you two 
> ranges).
> 
> It's easy to see why once you understand what 'a..b' really means (ie it 
> just expands to '^a' and 'b'), and how it's not really a "range" operation 
> as much as a set operation that interacts with all the other arguments 
> too. But unless you're very aware of that, it can be surprising.
> 

Oh, I am. But it is just so convenient to have range support for
commands which just show commits. Besides, git-show just errors out,
instead of producing the commits like git-log does.
