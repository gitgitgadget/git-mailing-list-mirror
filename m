From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb atom feeds broken (on repo.or.cz only?)
Date: Wed, 14 Oct 2009 16:40:50 +0200
Message-ID: <20091014144050.GP6695@machine.or.cz>
References: <4ABFA258.8020301@hartwork.org>
 <be6fef0d0909280023x46522d91oc786feef23cb226a@mail.gmail.com>
 <4AC0CBBE.7020603@hartwork.org>
 <4AD46F38.30100@hartwork.org>
 <20091014141744.GO6695@machine.or.cz>
 <4AD5E1A5.7020909@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My53M-0001mI-Gx
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933809AbZJNOl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 10:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933793AbZJNOl2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:41:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52408 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231AbZJNOl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 10:41:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5D6FF86201B; Wed, 14 Oct 2009 16:40:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AD5E1A5.7020909@hartwork.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130295>

On Wed, Oct 14, 2009 at 04:35:17PM +0200, Sebastian Pipping wrote:
> Petr Baudis wrote:
> > On Tue, Oct 13, 2009 at 02:14:48PM +0200, Sebastian Pipping wrote:
> >> Petr, any news on this one?
> >>
> >> I just check and it still seems broken.
> > 
> > Fixed, it's a HTML::Email::Obfuscate bug.
> 
> Though the feed works in Firefox now I wouldn't call it fixed, yet,
> 
> As I elaborated earlier in this thread the Atom you generate is not
> valid.  I cannot put it better than feedvalidator:
> 
> http://feedvalidator.org/check.cgi?url=http%3A%2F%2Frepo.or.cz%2Fw%2Fdottout.git%3Fa%3Datom
> 
> Please fix that, too.

I'm sorry, I don't have time for fixing that. Feel free to send me a
patch.

Kind regards,

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
