From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-1.4.1.1-1 git-clone-pack: unable to read from git-index-pack
Date: Tue, 25 Jul 2006 16:57:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251655360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <1153829608.2258.32.camel@Homer.simpson.net> <1153829908.2258.34.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 16:58:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5OLw-0000Dm-3s
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 16:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWGYO5l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 10:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWGYO5l
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 10:57:41 -0400
Received: from mail.gmx.net ([213.165.64.21]:29384 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750792AbWGYO5k (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 10:57:40 -0400
Received: (qmail invoked by alias); 25 Jul 2006 14:57:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 25 Jul 2006 16:57:39 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Mike Galbraith <efault@gmx.de>
In-Reply-To: <1153829908.2258.34.camel@Homer.simpson.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24175>

Hi,

On Tue, 25 Jul 2006, Mike Galbraith wrote:

> On Tue, 2006-07-25 at 14:13 +0200, Mike Galbraith wrote:
> > Greetings,
> > 
> > Having finally acquired DSL (only 400kbps, but at least I'm in the
> > twentieth century [not typo]), I decided to finally give git a try.  I
> > installed git-1.4.1.1-1, and armed myself with Jeff's how-to.  I didn't
> > get far before git saved me the trouble of truly testing my resolve :)
> > 
> > 	-Mike
> > 
> > git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> 
> Oops, missed a line.
> 
> fatal: packfile '/usr/local/src/tmp/linux-2.6/.git/objects/pack/tmp-nE9k3G' SHA1 mismatch
> 
> > error: git-clone-pack: unable to read from git-index-pack
> > error: git-index-pack died with error code 128
> > clone-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed

Was this after about 10 minutes? I had the impression that this was fixed 
with the 1.4.1.1 version _on the server side_. See

http://www.kernel.org/git/gitweb.cgi?p=git/git.git;a=commit;h=a0764cb838c2f1885fb58ca794c21523fb05c825

for details. So, please be patient until kernel.org's server is updated.

Hth,
Dscho
