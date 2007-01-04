From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-reset --hard: tell the user what the HEAD was reset
 to
Date: Thu, 4 Jan 2007 13:59:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701041357380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <emcf17$esj$1@sea.gmane.org>
 <Pine.LNX.4.63.0612211525070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <459BACE1.5020406@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 14:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2SCT-0001dR-3U
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 14:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbXADM74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 07:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbXADM74
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 07:59:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:46671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964818AbXADM74 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 07:59:56 -0500
Received: (qmail invoked by alias); 04 Jan 2007 12:59:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 04 Jan 2007 13:59:54 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <459BACE1.5020406@shadowen.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35930>

Hi,

On Wed, 3 Jan 2007, Andy Whitcroft wrote:

> I think we need to delimit the name better, probabally we need to quote
> it.  Perhaps something like:
> 
>   HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".

Fine. But this is "git log --pretty=oneline --abbrev-commit". I don't know 
how many things break if you change _that_.

Alternatively, you could pipe that into a sed command adding the colon and 
the quotes.

Ciao,
Dscho
