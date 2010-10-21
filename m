From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 21 Oct 2010 07:20:07 -0400
Message-ID: <1287660007.24161.10.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <m3ocar5fmo.fsf@localhost.localdomain>  <4CBFFD79.1010808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 21 13:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8tCD-0005ui-68
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 13:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047Ab0JULU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 07:20:27 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:51435 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183Ab0JULU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 07:20:27 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9LBKCxX009608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 07:20:12 -0400
In-Reply-To: <4CBFFD79.1010808@alum.mit.edu>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9LBKCxX009608
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288264815.93256@uJRQrDcg2vjLD4JfAZiJgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159493>


On Thu, 2010-10-21 at 10:44 +0200, Michael Haggerty wrote:
> On 10/18/2010 11:57 PM, Jakub Narebski wrote:
> > Well, there is different suggestion: make `git stage`, `git track` and
> > `git mark-resolved` to be *specializations* of `git add`, with added
> > safety checks: 'git stage' would work only on files known to git /
> > under version control already, 'git track' would work only on
> > untracked files (and do what 'git add -N' does), and 'git mark-resolved'
> > would work only on files which were part of a merge conflict.
> 
> I think that is a great idea.  The thing that I found most confusing
> when learning git is that variations on a single command often have very
> different effects.  

Ok, so what will "git stage" do when a change of a file is already
staged and it is executed again (on new changes)? The point of "git add"
is that it is adding the current state to the index, not that it is
adding a file to version control (in contrast to most other VCS/SCM).
Adding a "git stage" that acts as if "git add" permanently adds a file
to version control merely confuses this issue in my opinion.

(Comments about checkout will come in another message, granted I come up
with the time to write them down...)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
