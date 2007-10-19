From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git push bug?
Date: Fri, 19 Oct 2007 16:47:35 +0200
Organization: Transmode AB
Message-ID: <1192805255.1875.25.camel@gentoo-jocke.transmode.se>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>
	 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
	 <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
	 <Pine.LNX.4.64.0710181720010.25221@racer.site>
	 <1192725116.4954.7.camel@gentoo-jocke.transmode.se>
	 <Pine.LNX.4.64.0710182259190.25221@racer.site>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:47:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iit8i-000385-Ms
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760082AbXJSOrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760004AbXJSOrj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:47:39 -0400
Received: from mail.transmode.se ([83.241.175.147]:48499 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759933AbXJSOri (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:47:38 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 19 Oct 2007 16:47:36 +0200
In-Reply-To: <Pine.LNX.4.64.0710182259190.25221@racer.site>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61722>

On Thu, 2007-10-18 at 23:00 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> 
> > On Thu, 2007-10-18 at 17:21 +0100, Johannes Schindelin wrote:
> > 
> > > On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> > > 
> > > > Seems like it is a bit too easy to make mistakes here. Why can I 
> > > > delete a branch with :linus but not create one with linus:linus?
> > > 
> > > I wonder why you bother with the colon at all.  Just
> > > 
> > > 	git push <remote> linus
> > > 
> > > and be done with it.  The colon is only there to play interesting 
> > > games, not something as simple as "push this branch" or "push this 
> > > tag".
> > 
> > First, I didn't know that I could do that. Secondly, I was also looking 
> > do v2.6.23:linus refspecs
> 
> 
> First, then our documentation could be better.  How?

Well, it isn't clear to me how all this is supposed to work and
what is bugs. Clearifying that would help.

For instances I did a push with v2.6.23:refs/heads/linus and now
I got a branch with the SHA1 of v2.6.23 tag(0b8bc8b91cf6befea20fe78b90367ca7b61cfa0d)
in it. Makes gitk display that branch as "linus^{}".

> 
> Second, why not "git checkout -b linus v2.6.23 && git push origin linus"?

An extra checkout that takes time but works. Doesn't make the above
"weiredness" go away though.

 Jocke

> 
> Ciao,
> Dscho
> 
> 
