From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Rebasing multiple branches
Date: Fri, 31 Dec 2010 15:55:26 +0100
Message-ID: <201012311555.26354.trast@student.ethz.ch>
References: <4D10AE5B.2080700@gmail.com> <4D121136.6050906@gmail.com> <20101230053530.GA10511@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <leonidp.lists@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: <weigelt@metux.de>
X-From: git-owner@vger.kernel.org Fri Dec 31 15:55:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYgOb-0008Aj-AF
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 15:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab0LaOz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 09:55:29 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:51200 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab0LaOz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 09:55:29 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 15:54:54 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 15:55:27 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20101230053530.GA10511@nibiru.local>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164384>

Please don't cull the Cc lists.  Unless he's subscribed, Leonid never
got your reply!

Enrico Weigelt wrote:
> * Leonid Podolny <leonidp.lists@gmail.com> wrote:
> 
> > Ah, nice. I didn't notice the -p option. However, the man page advises 
> > against using -p and -i together.
> 
> Last time I checked, -i required -p ...

-p internally implies -i, but the user doesn't have to know that ;-)

The problem is that the todo file language is not expressive enough
for what -p needs to do.  Running a rebase -p without changing the
todo file should behave reasonably.  On the other hand, if you
rearrange or extend the todo file in many cases that gives unexpected
results.

Hence the recommendation to not use it with -i.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
