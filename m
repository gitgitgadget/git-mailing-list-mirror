From: Johan Herland <johan@herland.net>
Subject: Re: Commit annotations (was:: Octopus merge: unique (?) to git,
 but is it useful?)
Date: Wed, 04 Jun 2008 01:59:28 +0200
Message-ID: <200806040159.28603.johan@herland.net>
References: <200806030314.03252.jnareb@gmail.com>
 <200806032227.02951.jnareb@gmail.com>
 <alpine.DEB.1.00.0806032131300.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 02:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3gQm-000702-U7
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 02:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbYFCX7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 19:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYFCX7w
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 19:59:52 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52393 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbYFCX7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 19:59:51 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K1W00K01VZDS800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 01:59:37 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1W007OFVZ4G940@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 01:59:29 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1W000YFVZ4S0C0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 01:59:28 +0200 (CEST)
In-reply-to: <alpine.DEB.1.00.0806032131300.13507@racer.site.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83732>

On Tuesday 03 June 2008, Johannes Schindelin wrote:
> On Tue, 3 Jun 2008, Jakub Narebski wrote:
> > By the way, what is status of git-notes / commit annotations?  Did it
> > got abandoned, on hiatus, or what?
> 
> You probably meant to Cc: me, and Linus, right?
> 
> I all but abandoned it.  It works, but I do not need it, and kind of 
> waited for the guy who wanted them to chime in, so that I did not waste my 
> time in vain.
> 
> IIRC it was Johan Herland, but I could be wrong.

Yes, I made the first (severely misguided) implementations [1][2] which
prompted Dscho to create an alternative implementation [3]. Although Dscho's
design was certainly more Git-esque than mine (keeping the notes in a
(pseudo)branch instead of creating a totally separate infrastructure for
note storage), at some point his efforts stalled (due to a combination of
scalability problems and/or lack of interest, IIRC).

I was happy to see some of this work recently resumed by Geoffrey Irving
[4].

(Side note: It is funny how Geoffrey's patch-id cache can be seen as yet
another instance of the reverse-mapping softref mechanism I proposed as
part of the first git-notes implementation [5])

>From the initial interest in git-notes, and the sporadic requests that have
been posted since its first mention, it seems that git-notes would be a
useful feature for many Git users. However, neither me nor Dscho have the
time/interest to keep pushing it. Maybe it's time for someone else to pick
up the torch?


Have fun! :)

...Johan


[1]: http://thread.gmane.org/gmane.comp.version-control.git/46770/focus=48540
[2]: http://thread.gmane.org/gmane.comp.version-control.git/49052
[3]: http://thread.gmane.org/gmane.comp.version-control.git/52598
[4]: http://thread.gmane.org/gmane.comp.version-control.git/83484
[5]: http://thread.gmane.org/gmane.comp.version-control.git/49052/focus=49592

-- 
Johan Herland, <johan@herland.net>
www.herland.net
