From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 16:45:01 +0200
Message-ID: <20050707144501.GG19781@pasky.ji.cz>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 16:49:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqXgc-0001pH-Ck
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 16:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVGGOsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 10:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVGGOqN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 10:46:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49319 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261681AbVGGOpC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 10:45:02 -0400
Received: (qmail 2228 invoked by uid 2001); 7 Jul 2005 14:45:01 -0000
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <42CBC822.30701@didntduck.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 06, 2005 at 02:01:38PM CEST, I got a letter
where Brian Gerst <bgerst@didntduck.org> told me that...
> Petr Baudis wrote:
> >  Also, I've deprecated rsync, as I explained in another mail. Use
> >cg-branch-chg to change the branch URLs to some more sensible scheme -
> >most likely HTTP, or SSH if you want to push as well.
> 
> I really question removing rsync before HTTP pulls become more 
> effecient.

It won't happen. Or rather, I hope the HTTP pulls become more efficient
soon. Actually, perhaps Linus has something done already, my workstation
is a bit derailed now so I couldn't pull from him in the last few days
(hopefully will sort that out today).

> I did a complete pull of cogito from kernel.org, and http 
> took over 50 minutes to pull everything, while rsync was done in just 
> over 1 minute.  I dared not even try to pull the full kernel at that speed.
> 
> I suspect that part of the problem is that the pull methods are doing a 
> depth first search, so we can't request the next object until the 
> current object is fully received and parsed.  Changing to a breadth 
> first search would allow multiple requests in flight and asynchronous 
> processing which should speed things up.  I am exploring using the 
> curl_multi_* functions to do this, but this will require changes to 
> common code in pull.c.

Hmm, yes, I guess Linus won't be touching the HTTP backend at all. ;-) I
suggest you to check the last development in Linus' branch and sync with
Daniel Barkalow, who promised improving the pull tools as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
