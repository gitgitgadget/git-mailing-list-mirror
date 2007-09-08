From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sun, 9 Sep 2007 01:25:27 +0200
Message-ID: <20070908232527.GB2645@steel.home>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <Pine.LNX.4.64.0709071119510.28586@racer.site> <a1bbc6950709071732s1f15e5ev28bdfc5c1ab5877b@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOw-0004BX-Fm
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:44:18 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9nn-0007E4-8f
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:33:23 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9ng-0007fD-PG
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbXIHXZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 19:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755027AbXIHXZ3
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 19:25:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:32099 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbXIHXZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 19:25:28 -0400
Received: from tigra.home (Fae2f.f.strato-dslnet.de [195.4.174.47])
	by post.webmailer.de (fruni mo54) (RZmta 12.9)
	with ESMTP id N00de1j88LNRiu ; Sun, 9 Sep 2007 01:25:26 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 929CF277BD;
	Sun,  9 Sep 2007 01:25:26 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 77B7CBF13; Sun,  9 Sep 2007 01:25:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a1bbc6950709071732s1f15e5ev28bdfc5c1ab5877b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E31xFw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.0, required=12.0, autolearn=disabled, UIO_VGER=-3)
X-UiO-Scanned: ED09999401E5CED95AFC192E6FA4D3FC143AE014
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -29 maxlevel 200 minaction 2 bait 0 mail/h: 18 total 517775 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58144>

Dmitry Kakurin, Sat, Sep 08, 2007 02:32:09 +0200:
> On 9/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
> >
> > > Anyway I don't mean to start a religious C vs. C++ war.
> >
> > You have a very strange way of not meaning to start a C vs. C++ war.
> 
> I honestly didn't. I didn't even think it's possible. In the
> environment of mainstream commercial software development the last war
> on this subj was over 8-10 years ago.

It is because the "environment of mainstream commercial software
development" is stuck in "8-10" back from now.

> Even wars like "do we use exceptions/templates/stl" are pretty much
> over. Now days it's "do we use Boost", or "do we use template
> metaprogramming". But even more often it's Java/C# vs. C++.

Now that's a stupid argument to bring up. Commercial software
development is were the most stupid mistakes are done and repeated.

> That's why I was wondering how come C was chosen for Git.

"Just to annoy mainstream commercial software developers" would be a
good reason.
