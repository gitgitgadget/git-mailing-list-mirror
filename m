From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Wed, 24 Jan 2007 02:57:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701240251230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <200701231506.32396.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701231624.41716.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701230852270.32200@woody.linux-foundation.org>
 <Pine.LNX.4.63.0701231805100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkjtkxlm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 02:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9XOH-0006Iw-AS
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbXAXB5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965609AbXAXB5a
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:57:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:50255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965608AbXAXB53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:57:29 -0500
Received: (qmail invoked by alias); 24 Jan 2007 01:57:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 24 Jan 2007 02:57:28 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkjtkxlm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37595>

Hi,

On Tue, 23 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Linus wrote:
> >
> >> All the other uses seem to be just a case of
> >> 
> >> 	git-merge-index -o git-merge-one-file -a
> >> 
> >> and wouldn't it be beautiful if the default action for git-merge-index (if 
> >> you do _not_ specify a merger program) was to do the simple one-file 
> >> three-way merge that we can already do for real merges?
> >
> > If you think that's a new dream:
> >
> > http://article.gmane.org/gmane.comp.version-control.git/32046/match=git-merge-one-file
> 
> I've thought about it when I was really bored, but noticed that we have 
> no serious users of git-merge-index/git-merge-one-file combinations 
> anymore in-tree (octopus does not count, and it is trivial to make it 
> use merge-recursive if somebody is twisted enough).

Hah! You just pulled the last serious user! That's cheating.

Seriously again, the users of merge-index are

(git-checkout, which you pulled)
git-merge, which I do not really understand
git-merge-octopus, which you already discussed
git-merge-resolve, which is (hopefully) superseded by -recursive
git-merge-stupid, which is stupid
git-resolve, which is deprecated.

What I am nervous about is git-merge. I do not even fully understand in 
which circumstances it calls merge-index at all. (Too tired to read that 
now, anyway.)

Ciao,
Dscho
