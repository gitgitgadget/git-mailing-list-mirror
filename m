From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] git-cvsimport: Add -N option to force a new import
Date: Thu, 25 Oct 2007 21:45:39 +0200
Message-ID: <200710252145.40559.robin.rosenberg.lists@dewire.com>
References: <1193268519.8008.11.camel@mattlaptop2> <7vfxzz51d7.fsf@gitster.siamese.dyndns.org> <1193284913.2619.23.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 21:44:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il8d1-0000Q6-Gr
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 21:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbXJYToO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbXJYToO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 15:44:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4927 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbXJYToN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 15:44:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 40F39802661;
	Thu, 25 Oct 2007 21:35:27 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27320-05; Thu, 25 Oct 2007 21:35:26 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id DE0D0802653;
	Thu, 25 Oct 2007 21:35:26 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <1193284913.2619.23.camel@mattlaptop2>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62360>

torsdag 25 oktober 2007 skrev Matt McCutchen:
> On Wed, 2007-10-24 at 20:17 -0700, Junio C Hamano wrote:
> > Matt McCutchen <matt@mattmccutchen.net> writes:
> > 
> > > I had a git repository for development of rsync and wanted to start
> > > importing the upstream CVS with git-cvsimport, but git-cvsimport saw
> > > that the git repository existed and insisted on updating a previous
> > > import.  This patch adds an -N option to git-cvsimport to force a new
> > > import and updates the documentation appropriately.
> > 
> > Sounds like a useful addition.  Tests?
> 
> Are there existing tests for git-cvsimport somewhere whose example I
> could follow?  (I didn't see any in t/ .)  If not, I suppose I will just
> write a simple script that runs git-cvsimport with and without -N and
> with and without an existing, empty git repository and checks that the
> right things happen.

None, but there should be. I also think cvsps should be included in the git 
repo since it is required and AFAIK, only git people maintain it. 

Now I don't use cvsimport to import my CVS repos, so I'll pass on adding test 
cases. It is a non-trivial task 

I did it for cvsexportcommit which didn't have any tests when I started 
hacking it.

-- robin
