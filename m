From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: interactive rebase not rebasing
Date: Wed, 1 Oct 2008 12:13:21 -0500
Organization: Exigence
Message-ID: <20081001121321.5761fc7e.stephen@exigencecorp.com>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com>
	<48E078BF.5030806@op5.se>
	<20081001010306.01cc34eb.stephen@exigencecorp.com>
	<48E32BD4.1050107@op5.se>
	<20081001095225.d28de16a.stephen@exigencecorp.com>
	<48E396AF.2000100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 01 19:14:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl5Hc-0004WU-0d
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 19:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYJARN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 13:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbYJARN1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 13:13:27 -0400
Received: from smtp202.sat.emailsrvr.com ([66.216.121.202]:53569 "EHLO
	smtp202.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYJARN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 13:13:26 -0400
Received: from relay10.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id A115811B388A;
	Wed,  1 Oct 2008 13:13:24 -0400 (EDT)
Received: by relay10.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 3D32A11B234E;
	Wed,  1 Oct 2008 13:13:24 -0400 (EDT)
In-Reply-To: <48E396AF.2000100@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97249>


> > I've attempted to do that. Now that I sent in the patch, if you could
> > review it, I would appreciate your feedback.
> 
> I'm heading home from work now. I'll look it over tonight or tomorrow
> morning.

Cool, thanks.

Question: how taboo is it to just add another test file?

I'm attempting to integrate my test into t3404, which is the existing
interactive rebase test. The two test_expect_success's I added worked
when I ran them at the start of the test and then reset --hard the
branches back for the other tests, but if I paste my tests where they
should probably be, in the middle after the other -p tests, they break
because the 10 or tests before this have screwed with the DAG already.

I can suffer through getting it to work, but a t3409 would be much
easier, and probably easier to read as well as a I could setup my own
DAG instead of hacking onto 3404s.

> Thanks for the confidence :-)

No problem. :-)

- Stephen
