From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merging a foreign tree into a bare repository.
Date: Wed, 9 Jul 2008 02:40:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807090238561.5277@eeepc-johanness>
References: <1215562468.4199.26.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Dave Quigley <dpquigl@tycho.nsa.gov>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNkZ-00028V-Mx
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYGIAkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 20:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYGIAkl
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:40:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:43744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752131AbYGIAkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 20:40:41 -0400
Received: (qmail invoked by alias); 09 Jul 2008 00:40:39 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp022) with SMTP; 09 Jul 2008 02:40:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aQCVp0q0aAGSf8G9kOwRBjmubpxQm0wWZI8Y/km
	xJCXcRE9FI0vIE
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1215562468.4199.26.camel@moss-terrapins.epoch.ncsc.mil>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87821>

Hi,

On Tue, 8 Jul 2008, Dave Quigley wrote:

> I tried to then merge them but you need a working directory to merge the 
> changes which makes sense.

Of course it does.  Merging runs the risk of conflicts, and you need a 
working directory for that.

> How would one go about doing this with a bare repository?

Very easy: clone it ("non-barely"), merge, and push back the results.

You _need_ a working directory for the merge.

Hth,
Dscho "who wonders what No Such Agency does with Git..."
