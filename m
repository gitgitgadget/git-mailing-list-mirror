From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Use parse_date_format() in revisions.c to parse the
 --date parameter
Date: Fri, 28 Sep 2007 16:22:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281622240.28395@racer.site>
References: <200709281516.05438.andyparkins@gmail.com>
 <200709281517.32030.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 17:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbHhF-00054Q-39
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 17:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbXI1PX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 11:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbXI1PX5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 11:23:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:32975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752045AbXI1PX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 11:23:57 -0400
Received: (qmail invoked by alias); 28 Sep 2007 15:23:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 28 Sep 2007 17:23:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OOJtvJmrOKAT5eF1roBiFsC25gFrBP+vdP7isFX
	bJ3KNLDROaoR7T
X-X-Sender: gene099@racer.site
In-Reply-To: <200709281517.32030.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59401>

Hi,

On Fri, 28 Sep 2007, Andy Parkins wrote:

> The --date parameter was previously handled in revisions.c with a list
> of if(strcmp()) calls; now parse_date_format() is called instead.

Since this is really more like a code move, 1/4 and 2/4 should be 
squashed.

Ciao,
Dscho
