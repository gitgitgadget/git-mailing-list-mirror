From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fast-import
Date: Wed, 7 Feb 2007 12:17:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071216330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com>
 <20070206061817.GB10508@spearce.org> <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
 <20070207091351.GA1632@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1063159776-1170847065=:22628"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 12:17:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEkoF-0003wq-E4
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 12:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbXBGLRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 06:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbXBGLRs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 06:17:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:39068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161199AbXBGLRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 06:17:47 -0500
Received: (qmail invoked by alias); 07 Feb 2007 11:17:46 -0000
X-Provags-ID: V01U2FsdGVkX1/BjPYbgXjBrFfk+uqW+lmE88OJbvPHw1TlaVQKRY
	Kc+A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070207091351.GA1632@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38912>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1063159776-1170847065=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 7 Feb 2007, Karl Hasselström wrote:

> On 2007-02-06 23:55:46 -0500, Daniel Barkalow wrote:
> 
> > It might be nice to have a git-fast-export, which could actually be
> > potentially useful for generating a repository with systematic
> > differences from the original. (E.g., to make a repository of git's
> > Documentation directory, with just the commits that affect it)
> 
> Or to solve problems like
> 
>   Gaaah! This file we've had in the repository for the last 17 months
>   has copyright problems and we can't distribute it!
> 
> or
> 
>   Wouldn't it be nice to permanently include all that old Linux
>   history that's currently grafted onto the "real" history?
> 
> In other words, general history rewriting, but fast.

For this, it would be better to use a different approach: fast-import 
still hashes all the objects, which would not be necessary when rewriting. 
I guess that is what cogito's tool is doing.

Ciao,
Dscho

---1148973799-1063159776-1170847065=:22628--
