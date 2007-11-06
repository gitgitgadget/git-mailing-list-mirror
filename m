From: Bill Priest <priestwilliaml@yahoo.com>
Subject: Re: git-merge ignore specific files
Date: Tue, 6 Nov 2007 05:15:15 -0800 (PST)
Message-ID: <323303.75335.qm@web55010.mail.re4.yahoo.com>
References: <fgpong$fmn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 14:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpOHJ-0003Iw-71
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbXKFNPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbXKFNPS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:15:18 -0500
Received: from web55010.mail.re4.yahoo.com ([206.190.58.144]:34460 "HELO
	web55010.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754714AbXKFNPQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 08:15:16 -0500
Received: (qmail 77845 invoked by uid 60001); 6 Nov 2007 13:15:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=A12qXZShJfxmJbyz70EssKUxszrxddCIXbLkMHkQHsY0e6SjAiWu/Y6kh0htIIGHi5h6anFt6FH2+aAVvmOJhIT8FFXWdI8BqLVcvsvrogBHOwpKSr6dq6O5N9dba93iyER1RYDFbJa0LQdWMQLXAXxeFUTcnfIurtMZQlzCrSs=;
X-YMail-OSG: 1ZwEqmkVM1neWYc7yUBLwJGRN4hbzzaUJlf8gpLagEi.qUID_QZhndNi8k53wMD7BT765wxHXRk9egaGTSCWtcR1pknAoCZOzNS2hAB1YLI.w4R4mQZbEedNYLKSYQ--
Received: from [12.44.137.148] by web55010.mail.re4.yahoo.com via HTTP; Tue, 06 Nov 2007 05:15:15 PST
In-Reply-To: <fgpong$fmn$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63674>


--- Jakub Narebski <jnareb@gmail.com> wrote:

> Bill Priest wrote:
> 
> > All,
> >   I have two branches that are slightly different
> and
> > most changes "belong" in both.  There are a
> handful of
> > files/directories that are disparate.  Is there
> any
> > way in git to tell it not to merge these files? 
> Kind
> > of like .gitignore but for merges.
> 
> Most probably you can use gitattributes for that.
> Or you can use 'our' merge strategy.

Can you point me to some docs on "our" merge strategy?

> 
> >   In addition I'd like a way to specify to
> git-merge
> > to leave all merged files unrecorded in the index.
> 
> > Then as I go through each file making sure that
> the
> > merge "makes sense" (not that git did the right
> thing;
> > but that I want the changes in both branches) that
> I
> > add the change to the index.
> 
> You can use gitattributes for that.

I did man gitattributes and nothing jumped out at me
as far as an attribute that I could set/unset that
would stop a file from being merged.  What am I
missing?

Bill
 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
