From: Petr Baudis <pasky@suse.cz>
Subject: Re: [cogito] cg-merge does not remove files removed upstream on fast-forward
Date: Wed, 9 Nov 2005 23:54:09 +0100
Message-ID: <20051109225409.GH30496@pasky.or.cz>
References: <200511090108.51776.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:57:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZypg-00028o-4t
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbVKIWyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbVKIWyO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:54:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:8634 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161044AbVKIWyL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 17:54:11 -0500
Received: (qmail 7030 invoked by uid 2001); 9 Nov 2005 23:54:09 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Content-Disposition: inline
In-Reply-To: <200511090108.51776.blaisorblade@yahoo.it>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11428>

Dear diary, on Wed, Nov 09, 2005 at 01:08:33AM CET, I got a letter
where Blaisorblade <blaisorblade@yahoo.it> said that...
> Once again, (not the first time) when doing "cg-merge origin" (or cg-update I 
> guess, too) I find a tons of files which were removed upstream and cogito 
> didn't remove. It was a fast-forward merge on Linus' tree:
> 
> $ cg merge origin
> Fast-forwarding d83c671fb7023f69a9582e622d01525054f23b66 -> 
> a52e8381c430896d3bd6065a34fda99cb5c74c82
>         on top of d83c671fb7023f69a9582e622d01525054f23b66...

Strange. I've just added a test against this, and it seems to work fine
for me. Hmm.

Could you please test any post-1936f62c0756d8051bd3a8ee4214e058f168d395
Cogito version?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
