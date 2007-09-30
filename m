From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] fork/exec removal series
Date: Sun, 30 Sep 2007 22:14:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302212160.28395@racer.site>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:16:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic68r-0003YC-F6
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbXI3VPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbXI3VPu
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:15:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:38591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751618AbXI3VPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:15:50 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:15:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp013) with SMTP; 30 Sep 2007 23:15:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/B9E5s9Q/s7L6TPKl8XyGcl6pWC/9XebR2KpmEx
	Yx/wbXEElE03sX
X-X-Sender: gene099@racer.site
In-Reply-To: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59566>

Hi,

On Sun, 30 Sep 2007, Johannes Sixt wrote:

> You can regard this as the beginning of the MinGW port integration.

Thank you very much!  This effort cannot be praised enough.

> There still remain a few forks, which fall into these categories:
> 
> - They are in tools or code that are not (yet) ported to MinGW.[*]

The nice thing about the integration effort: It does not need to be done 
in one go.

> - The fork()s are not followed by exec(). These need a different
>   implementation. I am thinking of a start_coroutine()/finish_coroutine()
>   API that is implemented with threads in MinGW. (Suggestions of a better
>   as well as implementations are welcome.)

Is there more than the case I introduced with shallow clones?

Thanks,
Dscho
