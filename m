From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Minor portability patch to git-submodule
Date: Mon, 17 Dec 2007 22:54:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712172253150.9446@racer.site>
References: <Pine.LNX.4.64.0712171639420.24957@fractal.phys.lafayette.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Dougherty <doughera@lafayette.edu>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OrV-0001H6-5r
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbXLQWyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbXLQWyh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:54:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:50847 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752964AbXLQWyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:54:36 -0500
Received: (qmail invoked by alias); 17 Dec 2007 22:54:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 17 Dec 2007 23:54:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+T3JskbP+3+gQppLXwtbxNCCOQ2LReQvNzGKDnf
	dIKXTYu9HwBBR7
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712171639420.24957@fractal.phys.lafayette.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68645>

Hi,

On Mon, 17 Dec 2007, Andy Dougherty wrote:

> -	git ls-files --stage -- "$@" | grep -e '^160000 ' |
> +	git ls-files --stage -- "$@" | egrep -e '^160000 ' |

Nack.  egrep is not available on all platforms.  But then I have to wonder 
why not saying "grep '^160000 '" instead?

Ciao,
Dscho
