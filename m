From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Wed, 6 Apr 2011 18:21:12 +0530
Message-ID: <20110406124235.GA5881@kytes>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-2-git-send-email-artagnon@gmail.com>
 <4D9C4E0F.8050302@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 14:52:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7SDe-0007UF-OY
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 14:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab1DFMwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 08:52:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56306 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab1DFMwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 08:52:17 -0400
Received: by iyb14 with SMTP id 14so1390148iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JafRmBeilEX/EqZfEFM47QADDefRGWD38cyeONiPgbk=;
        b=hGiXf7j20Yz+JXQFHmTybTJsb6RlB+z4RJiBCWPdqWCOHHEhR9C292zeErUGpjr+tj
         Dk5zG7io6lcV+HB99yyiQB/rhhZrLj8yvE1D7b38kZWHKT08CBMgbiNqVDWdtNVlXBqf
         IzT5kjB7dXtK4SwLA+6Qgu0lTLtQ8rs9xclMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IQcRBmQPWabKhT+tvyo29v6ap78HVEHIhS9FY0FbiVFvDWW0h33+e4UMUCFYTLBVdp
         rwNvAqFgu+FBJubDOdRAB3n+zrn4Wmh3PFXcvDr4rjtPu9eaA+I1DZmTWYTllD8KNqzk
         dMMZYF0oFxoTO9mSSHUyo+vuCI4ialNnE9KBw=
Received: by 10.42.132.198 with SMTP id e6mr1455574ict.517.1302094336657;
        Wed, 06 Apr 2011 05:52:16 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id ww2sm321300icb.3.2011.04.06.05.52.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 05:52:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9C4E0F.8050302@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170970>

Hi Michael,

Michael J Gruber writes:
> Ramkumar Ramachandra venit, vidit, dixit 06.04.2011 11:57:
> > Although the gitattributes page contains comprehensive information
> > about these configuration options, they should be included in the
> > config documentation for completeness.
> > 
> > Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> >  Documentation/config.txt |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 8ea55d4..654a3b8 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -973,6 +973,15 @@ format.signoff::
> >      the rights to submit this work under the same open source license.
> >      Please see the 'SubmittingPatches' document for further discussion.
> >  
> > +filter.<driver>.clean::
> > +	The command which is used to convert the contents of worktree
> > +	file upon checkin.  See linkgit:gitattributes[5] for details.
> 
> I don't want to be a PITA, but is there any particular reason you are
> refusing to use the article "a" even after repeated suggestions to use
> it? (Also, I suggested to say what we are converting into here.)

Ouch, sorry.

> > +
> > +filter.<driver>.smudge::
> > +	The command which is used to convert the blob object to
> > +	worktree file upon checkout.  See linkgit:gitattributes[5] for
> > +	details.
> > +
> 
> You see, before my first response in this thread I thought: "Doing this
> myself would be less work than replying and explaining things, but I'll
> try to be nice."
> 
> Now, this is v4, I've even provided complete sentences ready for copy &
> paste, and we're still iterating. It turned out to be *much more* work
> than doing it myself. I'm sorry but I can't afford to spend even more
> time on this.

I'm very sorry to have caused so much pain.  Yes, I can imagine how
terrible it must be to review several iterations of a simple
documentation patch.  Thank you for being so patient with me so far- I
understand if you don't want to do this anymore.

I do spend time proofreading patches before sending them out, but I'm
clearly not very good at it.  In future, I'll either try rewriting
entire paragraphs or simply refrain from writing documentation
patches.  Please try to understand that sending out many iterations of
a documentation patch isn't something I particularly enjoy doing.
I'll send out another iteration of this series anyway.

-- Ram
