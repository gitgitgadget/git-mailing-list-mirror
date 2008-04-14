From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH 2/3] Prepare testsuite for a "git clone" that packs refs
Date: Mon, 14 Apr 2008 10:00:09 +0200
Message-ID: <200804141000.09515.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
 <200803220213.06359.johan@herland.net>
 <alpine.LNX.1.00.0804140205040.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:01:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJcx-0006Wk-1M
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbYDNIAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756538AbYDNIAi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:00:38 -0400
Received: from smtp.getmail.no ([84.208.20.33]:63280 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702AbYDNIAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:00:38 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZB00M3J28MPO00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:00:22 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB009JI289SJ40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:00:09 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB00K1J289KJA0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:00:09 +0200 (CEST)
In-reply-to: <alpine.LNX.1.00.0804140205040.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79482>

On Monday 14 April 2008, Daniel Barkalow wrote:
> On Sat, 22 Mar 2008, Johan Herland wrote:
> 
> > diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
> > index 31c1081..4569a13 100755
> > --- a/t/t5515-fetch-merge-logic.sh
> > +++ b/t/t5515-fetch-merge-logic.sh
> > @@ -143,6 +143,7 @@ do
> >  			rm -f .git/refs/heads/*
> >  			rm -f .git/refs/remotes/rem/*
> >  			rm -f .git/refs/tags/*
> > +			rm -f .git/packed-refs
> >  			git fetch "$@" >/dev/null
> >  			cat .git/FETCH_HEAD
> >  		} >"$actual" &&
> 
> I was just looking over this again, and it doesn't actually work, because 
> it removes the copies of refs/remotes/origin/*, which the tests are 
> expecting to find.

Yes, I also found that (after rebasing on current 'next'). :)

Will shortly post a new series making builtin-clone do packed refs,
suitable for current 'next'.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
