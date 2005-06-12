From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Rewrite cg-diff colorization, add diffstat and reverse
Date: Sun, 12 Jun 2005 09:29:27 +0200
Message-ID: <20050612072927.GA6620@pasky.ji.cz>
References: <42A8280A.3070607@gmail.com> <42A826D7.1060507@gmail.com> <20050611000255.GI22111@pasky.ji.cz> <42AAF54C.3010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 09:25:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhMqS-00043H-EE
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 09:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVFLH3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFLH3f
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 03:29:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65463 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261901AbVFLH3a (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 03:29:30 -0400
Received: (qmail 7348 invoked by uid 2001); 12 Jun 2005 07:29:27 -0000
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42AAF54C.3010908@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 11, 2005 at 04:29:32PM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> Petr Baudis wrote:
> >Dear diary, on Thu, Jun 09, 2005 at 01:24:07PM CEST, I got a letter
> >where Dan Holmsand <holmsand@gmail.com> told me that...
> >
> >I'm sorry, but those two patches are still way too big and therefore
> >basically unreviewable. Could you please split them further to a
> >per-feature patches?
> >
> >A good place to start would be changing the [PATCH 2/6] color refactor
> >to actually _replace_ the color stuff of cg-log and cg-diff with the new
> >common cg-Xlib code - but please don't change the default colors in that
> >patch yet (that is because you shouldn't assume in your earlier patches
> >that later patches will be applied, or applied in the form you send
> >them; I don't know about the less search thing yet, since I didn't test
> >it, since I don't have a focused patch for it).,
> 
> Ok, here's another one to start with.
> 
> cg-diff only, this time around. It's much simpler, since cg-diff got a 
> lot more similar to your stuff due to your excellent optparse-ification.
> 
> If this is still too big, I'm not really sure how to go about this.

Well, would it be a problem to first do the color handling separately,
as I suggested? Also, you bundle in a bunch of non-vital cleanups -
nothing wrong about them but they are really cluttering the patch up and
you could do them separately.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
