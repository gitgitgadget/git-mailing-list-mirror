From: Max Horn <postbox@quendi.de>
Subject: Re: gitpacker progress report and a question
Date: Thu, 15 Nov 2012 23:35:10 +0100
Message-ID: <877E14DE-313D-4863-980B-13D077230F7F@quendi.de>
References: <20121115212818.GA21558@thyrsus.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Thu Nov 15 23:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ8Iz-00028C-5U
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 23:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab2KOWwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 17:52:51 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:49292 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794Ab2KOWwu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 17:52:50 -0500
X-Greylist: delayed 1055 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Nov 2012 17:52:50 EST
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.27]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TZ81g-00087Z-5g; Thu, 15 Nov 2012 23:35:12 +0100
In-Reply-To: <20121115212818.GA21558@thyrsus.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;postbox@quendi.de;1353019970;a2851f1a;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209851>


On 15.11.2012, at 22:28, Eric S. Raymond wrote:

> Some days ago I reported that I was attempting to write a tool that could
> (a) take a git repo and unpack it into a tarball sequence plus a metadata log,
> (b) reverse that operation, packing a tarball and log sequence into a repo.

Ah, I could have used such a tool a year or so ago. Sounds useful to me, anyway :)

> 
> Thanks in part to advice by Andreas Schwab and in part to looking at the
> text of the p4 import script, this effort has succeeded.  A proof of
> concept is enclosed.  It isn't documented yet, and has not been tested
> on a repository with branches or merges in the history, but I am confident
> that the distance from here to a finished and tested tool is short. 
> 
> The immediate intended use is for importing older projects that are
> available only as sequences of release tarballs, but there are other
> sorts of repository surgery that would become easier using it.
> 
> I'm still looking for a better name for it and would welcome suggestions.

Isn't "gitar" the kind of natural choice? ;) At least for a stand-alone tool, not for a git subcommand.


Cheers,
Max

> 
> Before I do much further work, I need to determine how this will be shipped.
> I see two possibilities: either I ship it as a small standalone project,
> or it becomes a git subcommand shipped with the git suite. How I document 
> it and set up its tests would differ between these two cases.
> 
> Is there a process for submitting new subcommands?  What are the 
> test-suite and documentation requirements?
> -- 
> 		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
> <gitpacker.txt>
