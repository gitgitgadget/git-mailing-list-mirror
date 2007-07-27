From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2007
Date: Fri, 27 Jul 2007 21:07:15 +0200
Message-ID: <200707272107.16602.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com> <200707271320.06313.jnareb@gmail.com> <200707271401.57833.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 00:41:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEYV0-0007S0-B6
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 00:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763656AbXG0WlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 18:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761796AbXG0WlT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 18:41:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:21406 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758050AbXG0WlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 18:41:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so774087ugf
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 15:41:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SERmgQzUkTT/NiqVsU6ezmVyHBCkEdZmrMFrBKSt6FG4fufOK7dCTbaJ2xOaoomiLptmZ6HMxrPdPmulc9P4DXtq+hSMOm6le0eaXAPcLNkK4Fjq+NQtRsx9spa4MrFPbnJ7GD0uQnJhS+6RZBLZv7q3aKMtZvfWvji7w7iEWLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eisUewA0Gnxg00OExORzKjRVDG6ygsFOQBJvjCZnjRX4KWINRHaS9hsPWhRfdqDIeNjO6Fh/TzaV6yu3stVWGZfLEcw9fRbsrnqf66eFymXyuZ+lRFYTNYCdIjL9s04Wn2j5Ro/odhSX3qIyU3eD90a5bBJZYHOWqAtkDKeUf+Y=
Received: by 10.86.28.5 with SMTP id b5mr2296988fgb.1185576077205;
        Fri, 27 Jul 2007 15:41:17 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id j2sm896838mue.2007.07.27.15.41.13
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 15:41:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200707271401.57833.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53972>

On Friday, 27 July 2007, Andy Parkins wrote:
> On Friday 2007 July 27, Jakub Narebski wrote:
> 
> > Getting started with GIT
> >
> >     1. How did you hear about GIT?
> >     2. Did you find GIT easy to learn?
> >     -  very easy/easy/reasonably/hard/very hard
> >     3. What helped you most in learning to use it?
> >     4. What did you find hardest?
> >     5. When did you start using git? From which version?
> 
> The primary assumption of the survey seems to be that the responder
> is already using git.  What about some questions for people _not_
> using git; things like (badly written I'm sure, but you get
> the idea): 
> 
> Not using GIT
> 
>   Have you heard of git?  i.e. do you know what it's for?
>   Do you already use a VCS?  Which one?  Are you happy with it?
>   If not, would you like to use a VCS?
>   If you don't use a VCS already and don't want to - why not?
>   If you do use a VCS already, but it's not git - why not?
>   Would you like to use git but git doesn't supply a feature you need?
>   What would you require from git to enable you to change?
 
Well, it is meant to be Git _USER'S_ Survey.  The rest of questions
wouldn't have much sense if responder is not familiar with Git.

But I'd like to add the following questions about foreign SCM/VCS
to the survey:

-- >8 --
Other SCMs

    1. What other SCM did/do you use?
    2. What other SCM do you use as a main SCM for your project
       instead of git, if any? Why?
    *  example: Mercurial, better MS Windows support
    3. Do your git repository interact with other SCM? Or what SCM
       did you import from? What tool did/do you use?
    *  examples: CVS, import fromcvs, interaction git-cvsserver;
		 Subversion, git-svn

-- >8 --
 
> > What you think of GIT
> >
> >     1. Overall, how happy are you with GIT?
> >     -  unhappy/not so happy/happy/very happy/completely extatic
> 
> "extatic" should be "ecstatic"

Thanks. That reminds me to spellcheck the survey before 
posting/creating it.

-- 
Jakub Narebski
Poland
