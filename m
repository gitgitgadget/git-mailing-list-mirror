From: Camille Moncelier <moncelier@devlife.org>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Thu, 4 Nov 2010 15:16:37 +0100
Message-ID: <20101104151637.076ac021@cortex>
References: <20101104125641.2ef90853@cortex>
 <AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 15:17:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE0cx-0006kw-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 15:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab0KDORN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 10:17:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:45989 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471Ab0KDORM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 10:17:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PE0co-0006bj-Ew
	for git@vger.kernel.org; Thu, 04 Nov 2010 15:17:10 +0100
Received: from arennes-258-1-39-42.w90-31.abo.wanadoo.fr ([90.31.190.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:17:10 +0100
Received: from moncelier by arennes-258-1-39-42.w90-31.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:17:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: arennes-258-1-39-42.w90-31.abo.wanadoo.fr
In-Reply-To: <AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160722>

On Thu, 4 Nov 2010 14:55:12 +0100
Christian Couder <christian.couder@gmail.com> wrote:

> Could you try to cherry-pick with other strategies?
> For example with:
> 
> git cherry-pick --strategy resolve test1

~/repo1$ git --version
git version 1.7.3.1

~/repo1$ git cherry-pick --strategy resolve test1
Trying simple merge.
Simple merge failed, trying Automatic merge.
[master da2d5bf] New file in test1
 1 files changed, 1 insertions(+), 
 create mode 100644 new_file_test1

Seems it is working using the resolve strategy. I may have found a
message on this list posted a while ago:

"cherry-picking a commit clobbers a file which is a directory in the
target commit"

Which seems to deal with the same kind of problems maybe something is
missing in the patch in order to handle this particular case.

> I remember there were some problems with the default "recursive"
> strategy and I am not sure they were fixed.
> By the way could you tell which version of git you are using?

I'm using ubuntu's 1.7.1 version on my laptop which doesn't support
--strategy and a v1.7.3.1 on another computer, both expose the same
problem.

> 
> Thanks,
> Christian.

--
Camille Moncelier
http://devlife.org
