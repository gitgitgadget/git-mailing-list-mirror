From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH, fixed] builtin-clone: create remotes/origin/HEAD  symref,
 if guessed
Date: Mon, 3 Mar 2008 19:55:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803031955020.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LNX.1.00.0802261128360.19024@iabervon.org> <alpine.LSU.1.00.0803020556380.22527@racer.site> <alpine.LSU.1.00.0803020622190.22527@racer.site>
 <1204563913.4084.3.camel@gaara.boston.redhat.com> <20080303170942.GB23210@artemis.madism.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1443587725-1204574144=:22527"
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:57:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGmZ-0004qM-ME
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYCCT43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 14:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYCCT43
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:56:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:54960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751052AbYCCT42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:56:28 -0500
Received: (qmail invoked by alias); 03 Mar 2008 19:56:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 03 Mar 2008 20:56:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NFNF4BuXN6Nx5IswrUmyoDdomnMomuC4qTy1M5Q
	0X8xbmPksMYv9y
X-X-Sender: gene099@racer.site
In-Reply-To: <20080303170942.GB23210@artemis.madism.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75979>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1443587725-1204574144=:22527
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 3 Mar 2008, Pierre Habouzit wrote:

> On Mon, Mar 03, 2008 at 05:05:13PM +0000, Kristian Høgsberg wrote:
> > Oh and I'm wondering if
> > 
> >   strbuf_initf(&real_ref, "%s/%s", branch_top, head);
> > 
> > would be a worthwhile addition to the strbuf API...
> 
>   I don't think so, unless there are 1289 places in git that would 
> benefit from the shortcut it gives, but I really doubt it.

I think the proper question is: how many places in Git would benefit from 
strbuf_initf()?

Well, I stated already that I like it.

Ciao,
Dscho

---1463811741-1443587725-1204574144=:22527--
