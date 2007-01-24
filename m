From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 11:14:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241110240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17846.53626.895660.762096@lisa.zopyra.com>
 <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701232012450.3606@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 11:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9f9F-0005tb-Tc
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 11:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbXAXKO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 05:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbXAXKO2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 05:14:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:39425 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750943AbXAXKO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 05:14:27 -0500
Received: (qmail invoked by alias); 24 Jan 2007 10:14:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 24 Jan 2007 11:14:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0701232012450.3606@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37619>

Hi,

On Tue, 23 Jan 2007, Linus Torvalds wrote:

> It would be kind of cool to have the whole "merge-recursive" logic 
> (which can handle multiple ancestors etc - unlike the above) able to do 
> this, but that's a whole 'nother kettle of fish.

You'd lose all the renaming logic when doing it strictly on a file level. 
So I suggest opening a sidebranch, doing the merge, and just pick the new 
file as you proposed with "git checkout -f sidebranch file".

Ciao,
Dscho
