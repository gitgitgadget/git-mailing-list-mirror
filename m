From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 23:58:29 +0400
Message-ID: <20080416195829.GB4762@martell.zuzino.mipt.ru>
References: <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <4804765B.2070300@davidnewall.com> <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <20080416132634.GA545@cs181133002.pp.htv.fi> <20080416120247.c665859c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@kernel.org>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	jmorris@namei.org, viro@zeniv.linux.org.uk, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	davidn@davidnewall.com
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:09:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDrH-0000Uc-9p
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYDPUDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYDPUDH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:03:07 -0400
Received: from hu-out-0506.google.com ([72.14.214.235]:49183 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYDPUDG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:03:06 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1902650hue.21
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=027ML8V5h71ebb2EP2VALkgy5pT8Cogiyd+EB50Xl1w=;
        b=R6iUwbirlvajhy+8ESBRsiCxLYd+AqEzVvfXP624JRkuaalu9VM2IVS7v3tPH+jhSzSRzK0OosB20uH1OyfJ6cskEAt7S6t79SuLqrjJWVt0bk03VdCk3phFDXfi1Jbi5h9/reKMIgnBTNSVWyWLRFqMyx54LBvPq//RWPNDQyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Fo45VALNLkqcXLgMIZkaI7bGFPGfNj0D2s+viK+5Lja7St9DVYckh4hWmByU9tPgtMPqj4VBjmrGWEvQ58RkA5QUNa+HhcPhEO0upJQBDKjZLdDhAQcgHqN6XQTCDT/ks80V9gnsbgGBEnHzTVt8OOPWiV8If3xCyEjQtmhlf6E=
Received: by 10.86.31.18 with SMTP id e18mr818965fge.38.1208376183292;
        Wed, 16 Apr 2008 13:03:03 -0700 (PDT)
Received: from gmail.com ( [217.67.117.64])
        by mx.google.com with ESMTPS id l19sm8210326fgb.0.2008.04.16.13.03.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 13:03:02 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Wed, 16 Apr 2008 23:58:32 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20080416120247.c665859c.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79733>

On Wed, Apr 16, 2008 at 12:02:47PM -0700, Andrew Morton wrote:
> On Wed, 16 Apr 2008 16:26:34 +0300
> Adrian Bunk <bunk@kernel.org> wrote:
> 
> > On Wed, Apr 16, 2008 at 02:15:22PM +0200, Sverre Rabbelier wrote:
> > > I'm not subscribed to the kernel mailing list, so please include me in
> > > the cc if you don't reply to the git list (which I am subscribed to).
> > > 
> > > Git is participating in Google Summer of Code this year and I've
> > > proposed to write a 'git statistics' command. This command would allow
> > > the user to gather data about a repository, ranging from "how active
> > > is dev x" to "what did x work on in the last 3 weeks".

These are pointy-hairy questions.

> > > It's main
> > > feature however, would be an algorithm that ranks commits as being
> > > either 'buggy', 'bugfix' or 'enhancement'. (There are several clues
> > > that can aid in determining this, a commit msg along the lines of
> > > "fixes ..." being the most obvious.)
> > >...
> 
> Sounds like an interesting project.

The interesting (and answerable) questions are:

1) How many bugs one non-merge commit brings on average
2) What is average time between buggy commit entering Linus's tree and
   fix entering the same tree.
3) Graphs of #1 and #2 over time.
4) rough division of bugs a-la refcounting, locking, hw, hw workaround.
5) if other OS have such statistics, comparison with them
   (little finger for this)

#1 alone can shred OSDL and LWN induced PDFs into innumerable pieces!
