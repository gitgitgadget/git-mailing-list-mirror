From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Sun, 9 Jul 2006 00:15:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607090011000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
 <e8p8pj$jk3$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 00:15:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzL5B-00046M-Sx
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 00:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWGHWPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 18:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWGHWPU
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 18:15:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:54950 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751184AbWGHWPS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 18:15:18 -0400
Received: (qmail invoked by alias); 08 Jul 2006 22:15:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 09 Jul 2006 00:15:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e8p8pj$jk3$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23515>

Hi,

On Sat, 8 Jul 2006, Jakub Narebski wrote:

> moreau francis wrote:
> 
> > Hi GIT folks.
> > 
> > I'm a complete newbie on git development so excuse me if
> > this idea is completely stupid.
> > 
> > Would it be possible to let the user stick a short explanation
> > on  what a branch is supposed to implement during its creation.
> 
> It would be possible when/if branch and remotes config would migrate
> to .git/config. Currently too many I think relies on refs/heads being
> simple sha1 of "top" commit.

But it does not need a change of existing practice at all! Just add the 
information provided by --topic as branch."pathname".description to the 
config. And make format-patch aware of that.

Ciao,
Dscho
