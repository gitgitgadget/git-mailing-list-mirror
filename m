From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Thu, 18 Jan 2007 11:49:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jan 18 11:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Uq9-0004Ci-J3
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 11:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXARKtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 05:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXARKtv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 05:49:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:49011 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751023AbXARKtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 05:49:51 -0500
Received: (qmail invoked by alias); 18 Jan 2007 10:49:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 18 Jan 2007 11:49:49 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37078>

Forwarded, since I forgot to add the list

---------- Forwarded message ----------
Date: Thu, 18 Jan 2007 11:46:05 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Lose perl dependency.

Hi,

On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:

>  for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
> -			| @@PERL@@ -e 'print reverse <>'`
> +			| sed -ne '1!G;$p;h'`

Why not teach the revision machinery to output in reverse with 
"--reverse"?

Ciao,
Dscho
