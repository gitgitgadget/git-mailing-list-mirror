From: Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: git clone --depth and git describe
Date: Fri, 10 May 2013 10:42:03 +0200
Message-ID: <201305101042.04232.sweet_f_a@gmx.de>
References: <201305100107.59115.sweet_f_a@gmx.de> <CACsJy8D=getgkDV9A57=_N+u-XPPy8Cxdx5W+QADnCiGZxFRWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 10:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaiu8-0002mv-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 10:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab3EJImJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 04:42:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:61213 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab3EJImH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 04:42:07 -0400
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lj83k-1TyeG31bX4-00dDMw for
 <git@vger.kernel.org>; Fri, 10 May 2013 10:42:05 +0200
Received: (qmail invoked by alias); 10 May 2013 08:42:05 -0000
Received: from dslb-088-073-076-227.pools.arcor-ip.net (EHLO dslb-088-073-076-227.pools.arcor-ip.net) [88.73.76.227]
  by mail.gmx.net (mp010) with SMTP; 10 May 2013 10:42:05 +0200
X-Authenticated: #11967524
X-Provags-ID: V01U2FsdGVkX1/BEFA1IOrBeF/YvRph6ScGlQphFEL6rwBUr70Lpt
	JrMVPwb/oaf7BN
User-Agent: KMail/1.9.10
In-Reply-To: <CACsJy8D=getgkDV9A57=_N+u-XPPy8Cxdx5W+QADnCiGZxFRWQ@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223825>

On Friday 10 May 2013, Duy Nguyen wrote:
> On Fri, May 10, 2013 at 6:07 AM, Ruediger Meier <sweet_f_a@gmx.de> 
wrote:
> > Hi,
> >
> > I have a use case where I'd like to improve performance using "git
> > clone --depth". But I also need "git describe" working on that
> > clone.
> >
> > So something like
> >  git clone --depth=describable
> > would be nice to have.
>
> What does --depth=describable do?

I mean automatically getting the minimum depth which gives us the 
history back to the last (annotated) tag. So that "git describe" and 
possibly other project specific administrative scripts (like 
git-version-gen or gitlog-to-changelog) would work safely on that 
shallow clone.

Or maybe --depth could just generally accept a revspec as argument 
instead of number only. This would be more useful anyway IMO. Then 
perhaps something like "last_tag" could be a general magic revspec, 
probably useful for many other git commands too.


> > Would it be possible to add such feature?
>

cu,
Rudi
