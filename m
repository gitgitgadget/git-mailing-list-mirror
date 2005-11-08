From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-daemon enabled on kernel.org
Date: Tue, 8 Nov 2005 13:02:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511081259210.2649@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43554D4F.7040403@zytor.com> <20051107231157.GX1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 13:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZSBC-0006RB-JH
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 13:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVKHMCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 07:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbVKHMCT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 07:02:19 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44252 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964892AbVKHMCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 07:02:18 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7DAF213F27C; Tue,  8 Nov 2005 13:02:17 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61D939F1DD; Tue,  8 Nov 2005 13:02:17 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4BC9D9F1D7; Tue,  8 Nov 2005 13:02:17 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C3A5313F27C; Tue,  8 Nov 2005 13:02:16 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051107231157.GX1431@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11329>

Hi,

On Tue, 8 Nov 2005, Petr Baudis wrote:

> Dear diary, on Tue, Oct 18, 2005 at 09:30:23PM CEST, I got a letter
> where "H. Peter Anvin" <hpa@zytor.com> told me that...
> > I consider this experimental so far, and if it imposes an unacceptable 
> > load I'll have to disable it.  It currently runs with an inetd-imposed 
> > limits of 10 instances per server.
> 
> I'm curious - how well does it do wrt. the load so far? Do you have any
> statistics about the number of users and how CPU-intensive is it?

I have a simple statistics to contribute out of my head. A while ago (when 
people complained about gitweb.cgi taking too much load), a simple pull 
where my local repo was up-to-date took about 4 seconds. Now it takes just 
1 second.

I choose to believe that this is a sign of not too much load.

Ciao,
Dscho
