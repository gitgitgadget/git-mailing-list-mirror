From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 11:23:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221120300.27959@racer.site>
References: <20071121105517.GA11875@denkbrett.schottelius.org>
 <7vabp79hjt.fsf@gitster.siamese.dyndns.org> <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
 <7vd4u28z90.fsf@gitster.siamese.dyndns.org> <7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:23:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvA9r-0008HZ-0S
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbXKVLX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbXKVLX3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:23:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:43341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751596AbXKVLX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:23:28 -0500
Received: (qmail invoked by alias); 22 Nov 2007 11:23:26 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp004) with SMTP; 22 Nov 2007 12:23:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zzZRm5YhzJWfZ+BlFYtc15vtlwbcxEVk7y+0X3O
	84Dh6gV3CSxAmm
X-X-Sender: gene099@racer.site
In-Reply-To: <7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65796>

Hi,

On Thu, 22 Nov 2007, Steffen Prohaska wrote:

> 	git checkout -b foo origin/master
>         work work work
> 	git checkout -b bar origin/master
> 	work work work
> 	git checkout foo
> 	git pull   # or git fetch; git rebase
> 	git push
> 	git checkout bar
> 	git branch -d foo
>         work work, ... and later push bar, too

I have to say that I slowly grow an antipathy for "git push" without 
parameters.  _All_ of the confusions with push that I saw stem from being 
too lazy to say where and what you want to push.  (Okay, there is this 
other thing where people say "git push origin master:master" and I still 
do not know where they got _that_ from.)

I would _never_ teach people to be sloppy here.  Even if you introduce 
whatever appears convenient to you.  IMHO this is not only giving rope, 
but close to putting the noose around the neck.

Ciao,
Dscho
