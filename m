X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn: follow parent after the fact?
Date: Tue, 19 Dec 2006 13:36:59 -0800
Message-ID: <45885B7B.6060308@midwinter.com>
References: <45873D0A.1040804@midwinter.com> <20061219074745.GA31338@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 21:36:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <20061219074745.GA31338@localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34853>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwmdi-0001Pj-NA for gcvg-git@gmane.org; Tue, 19 Dec
 2006 22:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933029AbWLSVgo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 16:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932959AbWLSVgo
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 16:36:44 -0500
Received: from tater.midwinter.com ([216.32.86.90]:46047 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S933029AbWLSVgn
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 16:36:43 -0500
Received: (qmail 1171 invoked from network); 19 Dec 2006 21:36:42 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 19 Dec 2006 21:36:42
 -0000
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong wrote:
> The final set of files at the latest (svn) revision was inconsistent?
> That should never happen...  If so, I'd very much like to look into this.
>   

Yes, that's right; there are about 50 files that were in the original 
trunk before it was renamed but weren't in the branch that became the 
new trunk. Those files are present in the git repo if I use plain 
git-svn fetch, but they're not there in an svn client or in a git repo 
where I've used --follow-parent.

So far I haven't been able to come up with a from-scratch test case to 
demonstrate this behavior. The svn repository in question, 
unfortunately, isn't a public one. I've asked the person in charge of 
the repo if he remembers what exactly he did at the time of the branch 
reorganization; so far every permutation I've tried in my test repo has 
worked fine and not had the problem, so something odd must have happened 
in that repo's history.

I'll follow up if/when I manage to get a good test case.

