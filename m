From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merging .gitignore
Date: Wed, 3 Oct 2007 13:41:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710031314530.28395@racer.site>
References: <20071001130314.GA5932@lapse.madduck.net> <20071002195148.GA14171@lapse.madduck.net>
 <200710030923.22767.andyparkins@gmail.com> <200710031128.56472.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	martin f krafft <madduck@madduck.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 14:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id3Yz-0005xs-HQ
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 14:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbXJCMmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 08:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbXJCMml
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 08:42:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:42949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752648AbXJCMml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 08:42:41 -0400
Received: (qmail invoked by alias); 03 Oct 2007 12:42:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 03 Oct 2007 14:42:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ABUdZav7Aba4DZLh7NDSXT3oFlKykTChQmXHqOZ
	yt9JA8YP4b61X/
X-X-Sender: gene099@racer.site
In-Reply-To: <200710031128.56472.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59834>

Hi,

On Wed, 3 Oct 2007, Johan Herland wrote:

> - Teach the .gitignore parser to ignore conflict markers (i.e. regard them 
> as comments)

You might be delighted to know that in practice, it works already (because 
you usually do not have a file named "<<<<<< blablub" or "======" or 
">>>>>> blablub"...

Ciao,
Dscho
