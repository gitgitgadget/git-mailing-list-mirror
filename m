From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 22:21:12 +0200
Message-ID: <200708022221.13129.robin.rosenberg.lists@dewire.com>
References: <46AFCF3E.5010805@alum.mit.edu> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de> <46B2309E.3060804@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhCj-00008T-GF
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbXHBUXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758680AbXHBUXX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:23:23 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12387 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758272AbXHBUXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:23:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 52617802E0B;
	Thu,  2 Aug 2007 22:15:55 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18442-05; Thu,  2 Aug 2007 22:15:55 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A2583802ABF;
	Thu,  2 Aug 2007 22:15:54 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46B2309E.3060804@fs.ei.tum.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54599>

torsdag 02 augusti 2007 skrev Simon 'corecode' Schubert:
> Steffen Prohaska wrote:
> > I remember that togit reported a broken pipe. My feeling was
> > that git-fastimport aborted, which may be reason why tohg
> > worked better. I didn't try to understand more details. I never
> > read ruby code before and it was already a challenge for me to
> > get everything up and running (rcs, rbtree).
> 
> yah, that pretty much tells me it is shawn's bug :)  but without more 
details, it is very hard to diagnose.  tohg should tell you which rcs revs 
are the offenders.  be sure to use a recent fromcvs however.

If the bug is still unfixed and you haven't been able to diagnose for lack of 
repos, you could try the Eclipse CVS repo.

When I converted the Eclipse source to git I had a problem converting the 
whole repo, i.e. fastimport died. The conversion died so I excluded some 
large parts that were effectively forks and some websites. 

-- robin
