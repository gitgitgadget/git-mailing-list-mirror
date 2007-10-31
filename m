From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 11:01:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710311059020.4362@racer.site>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
 <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
 <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710310227340.4362@racer.site>
 <Pine.LNX.4.62.0710311048450.13264@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 31 12:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InBLc-0004Fn-JO
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 12:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbXJaLCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 07:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbXJaLCm
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 07:02:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:47365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753567AbXJaLCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 07:02:42 -0400
Received: (qmail invoked by alias); 31 Oct 2007 11:02:40 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp010) with SMTP; 31 Oct 2007 12:02:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185IwUp71o54zUGzb0S+RbWn+ZxWYJ0/XwjKyafe0
	GP0DWY//XpMPHV
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.62.0710311048450.13264@perkele.intern.softwolves.pp.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 31 Oct 2007, Peter Karlsson wrote:

> Johannes Schindelin:
> 
> > Why should it?  This would contradict the whole "a commit sha1 hashes 
> > the commit, and by inference the _whole_ history" principle.
> 
> Does it?

Yes!  Of course!  If what you want becomes possible, I could make an evil 
change in history long gone, and slip it by you.  You could not even see 
the history which changed.

> Why can't the grafts file itself be committed to the repository and live 
> in the history?

You can do that already.  But you have to ask the people at the other end 
to actually apply the graft.

> Well, yeah, the SHA1 hashing is one of Git's main strengths, but it also
> opens up some weaknesses.

If you really think that, I doubt you understood the issues at hand.

Ciao,
Dscho
