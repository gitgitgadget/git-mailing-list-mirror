From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 22:47:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102062235550.14920@xanadu.home>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102062312.51655.johan@herland.net>
 <AANLkTi=A-rh+wfg7O4KryydxVuorM8nkuGYmpbgVfVJp@mail.gmail.com>
 <201102070429.05033.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 04:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmI4R-0006PK-NJ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 04:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab1BGDrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 22:47:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60975 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1BGDrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 22:47:09 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG8004K4AHV0GB0@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 Feb 2011 22:46:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <201102070429.05033.johan@herland.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166226>

On Mon, 7 Feb 2011, Johan Herland wrote:

> In practice, this discussion boils down to whether we should use
> 
>     remote.origin.fetch = refs/tags/*:refs/remotes/origin/tags/*
> or
>     remote.origin.fetch = refs/tags/*:refs/tags/*
> 
> as the default refspec for tags. 

It clearly should be (and should have been from the start) the former 
one.

> AFAICS, we both agree that whichever 
> refspec is chosen by default, it should be possible for the user to (fairly 
> easily) override, and use the other refspec instead.

Indeed.

And as you propose, the _usage_ of tags should largely be unchanged as 
in most cases there won't be any ambiguity, and therefore using "git log 
v1.7.0" will just work even if the v1.7.0 tag is actually 
refs/remotes/origin/tags/v1.7.0.

So I hardly see what it is that people are unhappy about in this 
proposal.


Nicolas
