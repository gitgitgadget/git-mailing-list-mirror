From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 20:15:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701302013420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17855.35058.967318.546726@lisa.zopyra.com>
 <17855.36470.309129.391271@lisa.zopyra.com>
 <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
 <200701301950.00195.jnareb@gmail.com> <Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
 <17855.39008.920685.62837@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBySQ-0007YQ-Mo
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXA3TPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbXA3TPk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:15:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:50033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751665AbXA3TPj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:15:39 -0500
Received: (qmail invoked by alias); 30 Jan 2007 19:15:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 30 Jan 2007 20:15:38 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17855.39008.920685.62837@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38190>

Hi,

On Tue, 30 Jan 2007, Bill Lear wrote:

> On Tuesday, January 30, 2007 at 11:04:57 (-0800) Linus Torvalds writes:
> 
> >Anyway, it's certainly easy to fix. Bill, you can either:
> >
> > - just rename the "topic" branch to "master"
> 
> I don't think I want this.  I want to know I'm on the topic branch of 
> that repo, anything else really makes me nervous.

The name in the bare repository does not matter as much as your _local_ 
name.

> > - change the HEAD to point to "topic" rather than "master".
> 
> Same for this...[Thanks for the advice, nevertheless.]

If you have only _one_ branch in the upstream repo, why don't you let 
"HEAD" (in that repo) point to that branch, but to a non-existent 
"master"? That does not make sense.

Ciao,
Dscho
