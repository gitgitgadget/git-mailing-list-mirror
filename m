From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual.txt: fix a few mistakes
Date: Wed, 14 Nov 2007 13:13:37 -0500
Message-ID: <20071114181337.GG14254@fieldses.org>
References: <87bq9x7w4d.fsf@osv.gnss.ru> <7vlk91mgz6.fsf@gitster.siamese.dyndns.org> <87ir455713.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 19:14:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsMkO-0005tA-IM
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 19:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbXKNSNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 13:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbXKNSNk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 13:13:40 -0500
Received: from mail.fieldses.org ([66.93.2.214]:35496 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870AbXKNSNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 13:13:40 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IsMk5-0007QW-PR; Wed, 14 Nov 2007 13:13:37 -0500
Content-Disposition: inline
In-Reply-To: <87ir455713.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64994>

On Wed, Nov 14, 2007 at 03:46:32PM +0300, Sergei Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Sergei Organov <osv@javad.com> writes:
> >
> >> Signed-off-by: Sergei Organov <osv@javad.com>
> >> ---
> >>  Documentation/user-manual.txt |    8 ++++----
> >>  1 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> >> index d99adc6..a169ef0 100644
> >> --- a/Documentation/user-manual.txt
> >> +++ b/Documentation/user-manual.txt
> >> @@ -475,7 +475,7 @@ Bisecting: 3537 revisions left to test after this
> >>  If you run "git branch" at this point, you'll see that git has
> >>  temporarily moved you to a new branch named "bisect".  This branch
> >>  points to a commit (with commit id 65934...) that is reachable from
> >> -v2.6.19 but not from v2.6.18.  Compile and test it, and see whether
> >> +"master" but not from v2.6.18.  Compile and test it, and see whether
> >>  it crashes.  Assume it does crash.  Then:
> >>  
> >>  -------------------------------------------------
> >
> > Thanks.
> >
> > This hunk and the last hunk I do not have any problem with.
> >
> >> @@ -1367,7 +1367,7 @@ If you make a commit that you later wish you hadn't, there are two
> >>  fundamentally different ways to fix the problem:
> >>  
> >>  	1. You can create a new commit that undoes whatever was done
> >> -	by the previous commit.  This is the correct thing if your
> >> +	by the old commit.  This is the correct thing if your
> >>  	mistake has already been made public.
> >>  
> >>  	2. You can go back and modify the old commit.  You should
> >
> > But is this an improvement or just a churn?
> 
> I believe this is an improvement. It's more precise. With this change
> it's crystal clear that both (1) and (2) above mean the same commit by
> calling it "the old commit". Before the change, when I read this the
> first time, I've got the term "previous" here literally, i.e., as the
> last commit made, and I thought that if the commit in question is the
> last one, I should do (1), otherwise -- (2). This confusion admittedly
> vanished rather quickly, but it did happen.

I think it's a good fix, yes, thanks.--b.
