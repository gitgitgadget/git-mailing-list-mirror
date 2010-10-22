From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Fri, 22 Oct 2010 07:51:04 -0400
Message-ID: <1287748264.31218.18.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <m3ocar5fmo.fsf@localhost.localdomain> <4CBFFD79.1010808@alum.mit.edu>
	 <1287660007.24161.10.camel@drew-northup.unet.maine.edu>
	 <buoeibi6fab.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 13:52:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9GAP-0002NM-Ib
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 13:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab0JVLvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 07:51:50 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:47078 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab0JVLvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 07:51:48 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MBpAn3026916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 07:51:15 -0400
In-Reply-To: <buoeibi6fab.fsf@dhlpc061.dev.necel.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=5
	Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MBpAn3026916
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288353081.44189@erZLUZxujEXxoBhExfZW0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159682>


On Fri, 2010-10-22 at 13:07 +0900, Miles Bader wrote:
> Drew Northup <drew.northup@maine.edu> writes:
> > Ok, so what will "git stage" do when a change of a file is already
> > staged and it is executed again (on new changes)?
> 
> It stages the newly updated file?
> 
> This seems entirely obvious and intuitive, far more so than "git add"...

Whether "git add" or "git stage" makes any sense (or either one more
than the other) depends on the user having some specific knowledge of
how VCS/SCM works and in particular some knowledge specific to git. For
me, "git add" was virtually automatic having had some exposure to CVS
and SVN (thankfully CVS only in the past!). Once I got to the part of
the instructions where it was made clear that git does not PERPETUALLY
AND AUTOMATICALLY CAPTURE the state of CONTENT known to it the idiom of
"git add" working to ADD THE CURRENT STATE of content in a file made
perfect sense to me.
The idiom of "git stage" is likewise. One must understand that in git
all changes must be staged to the index manually before they can be
acted upon in a commit.
Neither one is particularly obvious to somebody who hasn't attempted to
understand how git works yet--just as the traffic concept of
right-of-way oft befuddles teenagers as if they were martians visiting
Times Square.

What I was asking, specifically, was how "git stage" was to act in the
given scenario. In particular I wanted to make sure that the workflow of
"make known to git, modify, add/stage changes to index, <repeat previous
two if needed>, commit, etc." did not change to include some sort of
PERPETUAL AUTOMATIC TRACKING as done with CVS/SVN (and frankly at times
a rather annoying prospect). Obviously I could not just ask that
outright and expect to get some idea of what my interlocutor was
thinking and how he internally conceived the idiom as well as an answer
to the direct question at hand.

How's that for a long answer to a seemingly simple question?

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
