From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 21:14:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272113430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17892.28995.328911.23188@lisa.zopyra.com>
 <Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17892.36336.249022.904854@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8iD-0004lK-Ml
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXB0UOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXB0UOK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:14:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:54170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752538AbXB0UOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:14:09 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:14:07 -0000
X-Provags-ID: V01U2FsdGVkX194cO1xert4QO4RNHx9d7+7JSyFWS5DWnHZIvarJY
	SmoQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17892.36336.249022.904854@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40782>

Hi,

On Tue, 27 Feb 2007, Bill Lear wrote:

> On Tuesday, February 27, 2007 at 20:52:38 (+0100) Johannes Schindelin writes:
> >Hi,
> >
> >On Tue, 27 Feb 2007, Bill Lear wrote:
> >
> >> We are contemplating files on the order of 500 megabytes a piece.
> >
> >I recommend splitting the files so that no file is that large (but the sum 
> >of them can be). But I think that you really wanted to say that.
> >
> >I think the problem of large packs is tackled right now by Troy, Shawn and 
> >Nico. Troy had exactly the same problem AFAIU, and Nico and Shawn are 
> >working on a new pack file format, which would lift the 4GB limit on packs 
> >while at it.
> >
> >This should solve your problems.
> 
> Welll... it's not really a matter of capacity, though I do agree that
> lifting that limit will help.  We are more concerned with time to
> clone the repos over the (often very slow) corporate network, for
> example.  With future ratios of about 1% code to 99% test data, we
> hither and yon with little care, and a monster data repo that is
> (somehow) sanely managed with git as well.  I was just curious if
> others had run into the management problems that I mentioned with
> separating test data from code and what they may have done to surmount
> them.

Okay I misunderstood, then.

Do shallow clones help you?

Ciao,
Dscho
