From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Wed, 6 Feb 2008 00:56:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802060053570.8543@racer.site>
References: <ve53xwob.fsf@blue.sea.net>  <alpine.LSU.1.00.0802051524580.8543@racer.site> <prvbxfhl.fsf@blue.sea.net>  <alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>  <alpine.LSU.1.00.0802052236220.8543@racer.site>
 <1202253890.26144.8.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1356554364-1202259368=:8543"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:57:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYbK-00079Y-6A
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbYBFA4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbYBFA4t
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:56:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:49598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbYBFA4s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:56:48 -0500
Received: (qmail invoked by alias); 06 Feb 2008 00:56:46 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp020) with SMTP; 06 Feb 2008 01:56:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19eJwhhhYpeRxQIQ12KfoxDO1chRkdjvz1rx/McEH
	SOpEnEH0sOy7/f
X-X-Sender: gene099@racer.site
In-Reply-To: <1202253890.26144.8.camel@gaara.boston.redhat.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72736>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1356554364-1202259368=:8543
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 5 Feb 2008, Kristian Høgsberg wrote:

> I think there's a correlation here: anybody who's meddling with git 
> implementation details (yes, I'm talking about .dotest here) is probably 
> also subscribed to this list :)  Seriously though, in git there is often 
> no clear line between implementation details and supported features, so 
> it's way to easy to claim everything is set in stone and that the world 
> will break if we change it.  Especially if you've written a script that 
> happens to reach a little to far into the git guts.

I think you are being unfair here:

Imagine git-am stops somewhere because the patch fails.  What to do?  
Where to look?  What to fix?

Exactly.  You have _only_ one option.  You look into .dotest/.

So yes, it is an implementation detail.  But one that we could not 
_possibly_ hide.

What's so wrong with using a symlink first, trying hard not to break 
peoples' assumptions, then tell them that they should change their scripts 
(which they can do lazily now, since both .dotest/ _and_ .git/rebase/ 
are valid)?

How is being nice to people wrong?

Ciao,
Dscho

---1463811741-1356554364-1202259368=:8543--
