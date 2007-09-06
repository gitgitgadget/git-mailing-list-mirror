From: Miles Bader <miles.bader@necel.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 06 Sep 2007 11:30:50 +0900
Message-ID: <buotzq8o78l.fsf@dhapc248.dev.necel.com>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:35:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7DS-0000sH-FA
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424AbXIFCfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbXIFCfa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:35:30 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:53993 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbXIFCf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:35:29 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l862UYWX022907;
	Thu, 6 Sep 2007 11:30:34 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Thu, 6 Sep 2007 11:30:34 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Thu, 6 Sep 2007 11:30:34 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 388B158A; Thu,  6 Sep 2007 11:30:51 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <vpq642pkoln.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed\, 05 Sep 2007 19\:29\:24 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57803>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> and if people decide that git needs a non-trivial string library,
> writting/testing more code in strbuf.c would probably be more work
> than just reading what bsstring code does to become familiar enough
> with it to even be able to maintain it later.

>From what I've seen (by perusing the bstring website), bstring is kind
of ugly though....

-Miles

-- 
"Suppose we've chosen the wrong god. Every time we go to church we're
just making him madder and madder." -- Homer Simpson
