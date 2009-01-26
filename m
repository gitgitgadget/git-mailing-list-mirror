From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Common ancestor in merge diffs?
Date: Mon, 26 Jan 2009 19:59:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261958320.25749@intel-tinevez-2-302>
References: <alpine.LNX.1.00.0901261318030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWi4-0003hK-Rn
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbZAZS76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 13:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbZAZS75
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 13:59:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:52467 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752144AbZAZS75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 13:59:57 -0500
Received: (qmail invoked by alias); 26 Jan 2009 18:59:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp031) with SMTP; 26 Jan 2009 19:59:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OWU0CbQfOHWZK523qqh3Uxrs/6KC6cFW/mk2TTL
	sd8CcDE3FjfTBP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.1.00.0901261318030.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107247>

Hi,

On Mon, 26 Jan 2009, Daniel Barkalow wrote:

> I was just doing an annoying merge (I'd reorganized code while other 
> people made changes to it), and I kept having the problem that it was hard 
> to figure out what each side had done. Is there some way to ask git for 
> the diffs between the common ancestor (which is unique in my case, so it's 
> actually useful) and each of the sides of the merge?

How about

	git diff HEAD...MERGE_HEAD

and

	git diff MERGE_HEAD...HEAD

?  I might have misunderstood, though.

Ciao,
Dscho
