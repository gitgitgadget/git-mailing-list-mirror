From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Sun, 6 May 2007 22:05:30 +0200
Organization: Dewire
Message-ID: <200705062205.34814.robin.rosenberg.lists@dewire.com>
References: <200705012346.14997.jnareb@gmail.com> <200705031216.19817.robin.rosenberg.lists@dewire.com> <46a038f90705030348o260fbe6cwc92d07778269c937@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Florian Weimer" <fw@deneb.enyo.de>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 22:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkmzX-00067X-Ry
	for gcvg-git@gmane.org; Sun, 06 May 2007 22:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbXEFUFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755228AbXEFUFm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 16:05:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29468 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbXEFUFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 16:05:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id ED85E8028AF;
	Sun,  6 May 2007 21:59:35 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10653-10; Sun,  6 May 2007 21:59:35 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id F2C44802655;
	Sun,  6 May 2007 21:59:34 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46a038f90705030348o260fbe6cwc92d07778269c937@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46371>

torsdag 03 maj 2007 skrev Martin Langhoff:
> [resend - correcting a couple of typos and addressing git@vger
> correctly - apologies]
> 
> On 5/3/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > The reason is simple. I have a lousy one gigabyte RAM only, while
> > git wants 1.7GB virtual to do the diff-stat.  and 800 MB resident. The swap is having a party,
> 
> That is true, unfortunately. git will fly if it can fit its working
> set plus the kernel stat cache for your working tree in memory. And
> the underlying assumption is that for large trees you'll have gobs of
> RAM. If things don't fit, it does get rather slow...
> 
> But... just to put things in perspective, how long does it take to
> *compile* that checkout on that same laptop. I remember reading
> instructions to the tune of "don't even try to compile this with less
> than 4GB RAM, a couple of CPUs and 12hs". Those were for the OSX build
> IIRC.
No idea. I wouldn't try it without distcc and ccache anyway which makes the
capabilities of this particular machine less relevant. 

> Ah - it's moved to the general instructions: "Building OOo takes some
> time (approx 10-12 hours on standard desktop PC) ":
> http://wiki.services.openoffice.org/wiki/Building_OpenOffice.org#Starting_the_real_build
> 
> So I don't think anyone working on projects the size of the kernel or
> OO.org is going to be happy with 1GB RAM.

The kernel 2.6 repo isn't in the same ball park wrt to size.  Hacking the kernel is quite fine
on this machine and even smaller though the first compile takes some time. Having more 
is always fun though. 

Consider another huge project like Eclipse. Similar operations take a loong time (not anywhere
near the eons that CVS need, but...)  and building Eclipse with 1GB i very reasonable so sheer
project size does not per se demand powerful computers. KDE is another huge project that
is reasonable to build with 1GB. The first time is somewhat painful, but rebuilding is not.

-- robin
