From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use resolve in git-pull if NO_PYTHON
Date: Tue, 14 Mar 2006 18:26:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603141825200.22344@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1142356355-4772-markhollomon@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 18:34:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJDI3-0006Rr-FY
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 18:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWCNR0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 12:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWCNR0Y
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 12:26:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63706 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751350AbWCNR0X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 12:26:23 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 128CF1CA0;
	Tue, 14 Mar 2006 18:26:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0526EACB;
	Tue, 14 Mar 2006 18:26:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DD0C11CA0;
	Tue, 14 Mar 2006 18:26:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Mark Hollomon <markhollomon@comcast.net>
In-Reply-To: <1142356355-4772-markhollomon@comcast.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17593>

Hi,

On Tue, 14 Mar 2006, Mark Hollomon wrote:

> git-pull is hardcoded to use the recursive merge strategy
> for the twohead case. But if git has been built with NO_PYTHON,
> that strategy is not available. Teach git-pull to use resolve
> if built with NO_PYTHON.

D'oh. I forgot to send that patch when I was doing the NO_PYTHON stuff. 
But I did it differently: There is no good reason that git-pull should 
insist on its own default strategy when git-merge already has one.

Ciao,
Dscho
