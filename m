From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about commit message conventions
Date: Tue, 24 Oct 2006 16:08:02 +0200
Organization: At home
Message-ID: <ehl6n6$6jn$1@sea.gmane.org>
References: <200610241549.48238.t.toedter@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 24 16:10:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcMy2-00027B-8Z
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 16:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWJXOJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 10:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWJXOJG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 10:09:06 -0400
Received: from main.gmane.org ([80.91.229.2]:28864 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030262AbWJXOJD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 10:09:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcMx7-0001qS-At
	for git@vger.kernel.org; Tue, 24 Oct 2006 16:08:25 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 16:08:25 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 16:08:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29977>

Tobias Toedter wrote:

> Hi,
> 
> although I've read the documentation of git very carefully, I could not find 
> anything related to certain commit message conventions. It would be great 
> if someone here could explain a few things, maybe this could be added to 
> the wiki afterwards (<http://git.or.cz/gitwiki/CommitMessageConventions>).
> 
> First of all, what's the intended use of the "Signed-off-by:" lines? Does it 
> make sense to add my name there, even when I'm listed as the author or 
> committer of a commit? I thought that they are intended mostly to note the 
> approval of other developers.
> 
> On the other hand, concerning the approval of other developers, what's the 
> difference between "Signed-off-by:" and "Acked-by:"? Are there any 
> more "*-by:" fields that are in use?

>From Documentation/SubmittingPatches:

(6) Sign your work
[...]
The sign-off is a simple line at the end of the explanation for
the patch, which certifies that you wrote it or otherwise have
the right to pass it on as a open-source patch.


"Acked-by:" is used to notify that patch was accepted by somebody,
which usually is maintainer of part affected by patch.

I have seen exactly on "Cheered-on-by:", and there are probably some
"Noticed-by:" there.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
