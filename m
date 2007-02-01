From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Modify/edit old commit messages
Date: Thu, 1 Feb 2007 18:17:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011816180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070201114909.GV8705@enneenne.com>
 <Pine.LNX.4.63.0702011326130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rodolfo Giometti <giometti@enneenne.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 18:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCfZ4-0007jR-Br
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXBARRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbXBARRf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:17:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:59315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751839AbXBARRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:17:34 -0500
Received: (qmail invoked by alias); 01 Feb 2007 17:17:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 01 Feb 2007 18:17:33 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702011326130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38374>

Hi,

On Thu, 1 Feb 2007, Johannes Schindelin wrote:

> On Thu, 1 Feb 2007, Rodolfo Giometti wrote:
> 
> > I'm puzzled... how can I modify or edit old commit messages? :)
> 
> Short answer: you can't.

Amendment:

You can easily, but only the latest commit, with "git commit --amend". Be 
warned though, the same as with rebase applies here: if you pushed this 
commit somewhere else, or if users fetched that branch from you (including 
the not-yet-edited commit), they _will_ have problems fetching and/or 
merging.

Ciao,
Dscho
