From: jlh <jlh@gmx.ch>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 16:38:18 +0200
Message-ID: <46F3D75A.2040008@gmx.ch>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>	 <Pine.LNX.4.64.0709211208440.28395@racer.site>	 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>	 <20070921125337.GA28456@diana.vm.bytemark.co.uk> <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Stahlir <peter.stahlir@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 16:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYjee-00056o-2C
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 16:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847AbXIUOiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 10:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758874AbXIUOiq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 10:38:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:47876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752986AbXIUOip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 10:38:45 -0400
Received: (qmail invoked by alias); 21 Sep 2007 14:38:44 -0000
Received: from 106.8.79.83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.8.106]
  by mail.gmx.net (mp041) with SMTP; 21 Sep 2007 16:38:44 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19IjwMT46xIFyiBwH4YzOojBiFJR26SUhJpa/SGLb
	2/1Q3yRJOC+Hsd
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
In-Reply-To: <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>
X-Enigmail-Version: 0.95.2
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58859>

Peter Stahlir wrote:
> But the thing is, I think there is a lot of redundancy in
> a) a Debian mirror or

Yes, surely.  Your idea suggests that you want any file to be
reconstructed on-the-fly whenever it's being requested.  Isn't
there the danger of killing performance, the CPU being the
bottleneck?  I imagine such a debian mirror has quite some
traffic.

> b) your disk at home.

I doubt so.  There sure is lots of redundancy within each file and
that's what compressed file systems are good for.  But what you
talk about is redundancy across (unversioned) files, and I don't
feel there is a lot of it.  Yes, I might have a few copies of the
file COPYING on my disk, and maybe some of my sources share a few
functions, but this won't save me tons of space.  All my binaries,
libraries, MP3s, videos, config files, etc don't really have any
redundancy across file boundaries.  And even if there is, finding
that redundancy is an O(whatever-but-not-n) operation that would
be rather slow.

I definitely see gitfs (or similar ideas) as potentially being
useful in some cases (maybe debian mirrors could be one), but not
for my disk at home, which I generally would prefer to be faster
than more compressed.

jlh
