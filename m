From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] user-manual: be consistent in illustrations to 'git
	rebase'
Date: Tue, 28 Sep 2010 15:08:39 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20100928110839.GA5752@tugrik.mns.mnsspb.ru>
References: <1285662024-4992-1-git-send-email-kirr@mns.spb.ru> <7vy6amtd1a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 13:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Y13-0002Qa-6l
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab0I1LG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 07:06:27 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:41241 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab0I1LG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 07:06:27 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1P0Y0t-0003se-He; Tue, 28 Sep 2010 15:06:23 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1P0Y35-0001V4-Tt; Tue, 28 Sep 2010 15:08:39 +0400
Content-Disposition: inline
In-Reply-To: <7vy6amtd1a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157404>

On Tue, Sep 28, 2010 at 02:47:45AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > Since we use a-b-c for mywork commits in one place, I think it would be
> > logical to also use a-b-c too in other illustration on this topic.
> >
> > Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> > ---
> >  Documentation/user-manual.txt |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> > index fecc4eb..87ca1a7 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -2424,41 +2424,41 @@ Keeping a patch series up to date using git rebase
> >  --------------------------------------------------
> >  
> >  Suppose that you create a branch "mywork" on a remote-tracking branch
> >  "origin", and create some commits on top of it:
> >  
> >  -------------------------------------------------
> >  $ git checkout -b mywork origin
> >  $ vi file.txt
> >  $ git commit
> >  $ vi otherfile.txt
> >  $ git commit
> >  ...
> >  -------------------------------------------------
> >  
> >  You have performed no merges into mywork, so it is just a simple linear
> >  sequence of patches on top of "origin":
> >  
> >  ................................................
> >   o--o--o <-- origin
> >          \
> > -         o--o--o <-- mywork
> > +         a--b--c <-- mywork
> >  ................................................
> 
> Perhaps you would want to make the origin commit "O" while you are at it
> (I can locally fix it up)?

Yes, please do, and thanks.
