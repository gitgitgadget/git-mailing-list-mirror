From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 12:05:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511251200190.30119@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4386DD45.6030308@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 12:06:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfbOx-0004Pj-14
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 12:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVKYLF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 06:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKYLF4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 06:05:56 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37765 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751445AbVKYLF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 06:05:56 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D033A13FD8B; Fri, 25 Nov 2005 12:05:54 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B79529F412; Fri, 25 Nov 2005 12:05:54 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A31269F3D4; Fri, 25 Nov 2005 12:05:54 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 944CB13FD8B; Fri, 25 Nov 2005 12:05:54 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4386DD45.6030308@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12735>

Hi,

On Fri, 25 Nov 2005, Andreas Ericsson wrote:

> It's worse than the perl version because;
> 1. It doesn't thread the patch-series (which I personally prefer anyway since
> it's easier to follow a thread on a particular patch that way).

I think you can do that easily by providing a Message-ID: and a 
References: header. The id could be made up by "git-$commit_id" to be 
reasonably unique.

> 2. The patches sent within the same second arrive in random order.

I have that all the time. Sometimes, I send emails to the git list 
several minutes apart, and they come out in the wrong order. So it is no 
problem.

> Sorry about the attachment btw. Thunderbird seems to wrap lines no 
> matter what I tell it.

The hints in SubmittingPatches did not help?

> Thoughts? Comments?

I find it very cool. And easy to read. Just a few nits: You could use 
git-sh-setup.sh to ensure that you're in a valid git repository. Also, you 
could reuse the "die" function contained therein instead of a new 
function, "abort".

Ciao,
Dscho
