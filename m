From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 09:22:51 -0700
Message-ID: <20080912162251.GM22960@spearce.org>
References: <19449377.post@talk.nabble.com> <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com> <20080912145804.GF10544@machine.or.cz> <200809121754.30277.jnareb@gmail.com> <20080912160538.GB10360@machine.or.cz> <20080912160854.GL22960@spearce.org> <20080912162037.GC10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeBRA-0000w1-KW
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYILQWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbYILQWw
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:22:52 -0400
Received: from george.spearce.org ([209.20.77.23]:39817 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbYILQWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:22:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9D2E63835C; Fri, 12 Sep 2008 16:22:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080912162037.GC10360@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95750>

Petr Baudis <pasky@suse.cz> wrote:
> > 
> > Disk IO and network IO consumed probably.  The kernel.org folks are
> > hoping the smart HTTP server can lower their loads a bit by being
> > more careful about what we send to the client.
> 
> To check whether it actually matters for me, I have counted HTTP
> requests for info/refs: 42 per hour for the last 5.5 days. So it might.
> 28% of the requests are web crawlers.
> 
> For objects/../, it is more fun - 1942 requests per hour. 46% is
> accounted for web crawlers. I will put up a robots.txt. ;-)

Is Googlebot trying to make those loose objects searchable?
I wonder what byte sequence I should try in the search bar...

;-)

-- 
Shawn.
