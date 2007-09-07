From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 11:56:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709071155570.28586@racer.site>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com>
 <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
 <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbWp-0007Zg-JT
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbXIGK5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 06:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbXIGK5B
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:57:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:51474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965120AbXIGK5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:57:00 -0400
Received: (qmail invoked by alias); 07 Sep 2007 10:56:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 07 Sep 2007 12:56:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/th2VmIZzt0759AU7FU2l++m9DBnPlZ1YOJy6gyz
	VkyKfHoIxpAOmF
X-X-Sender: gene099@racer.site
In-Reply-To: <46E0EEC6.4020004@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58022>

Hi,

On Fri, 7 Sep 2007, Andreas Ericsson wrote:

> Wincent Colaiuta wrote:
> > El 7/9/2007, a las 2:21, Dmitry Kakurin escribi?:
> > 
> > > I just wanted to get a sense of how many people share this "Git should
> > > be in pure C" doctrine.
> > 
> > Count me as one of them. Git is all about speed, and C is the best choice
> > for speed, especially in context of Git's workload.
> > 
> 
> Nono, hand-optimized assembly is the best choice for speed. C is just
> a little more portable ;-)

I have a buck here that says that you cannot hand-optimise assembly (on 
modern processors at least) as good as even gcc.

Ciao,
Dscho
