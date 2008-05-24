From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sat, 24 May 2008 23:59:57 +0400
Message-ID: <20080524195957.GC3745@dpotapov.dyndns.org>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com> <m34p8o4ijg.fsf@localhost.localdomain> <5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat May 24 22:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzzvG-0007Jw-9u
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 22:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbYEXUAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 16:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbYEXUAF
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 16:00:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:8587 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbYEXUAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 16:00:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so777600fgg.17
        for <git@vger.kernel.org>; Sat, 24 May 2008 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=YmnTe78hQ0y8T9qdPTmVwJ9O8hJlWVtvtkvulYuDXXo=;
        b=xd+M2qfz7J0N0VUmpH5JRRvXQ2x/iW+rm0dCXTfg6TYvWZixO8RVOoPjF51MPbJWmR5Rq31PR1JrakB4Vtl665qbZ9Mts50Hfwi9lkIpe9JCLwQlC8xPtY4/EQRWHo9WSiHm/uFAqiPObG8lfUW1ZfBzu63SRUAtnVfl4ZQJh6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lmhUDhJKQvqvzOFqvodQ5qdPHKT6ogtT7yBBTO+f+b6VV1L8frPxQihdLfQJXw2K2p70m/U7dcPtqN9Ej4BfTxsum8VsjSglDVvhdizrKD7Ium+KX6AoWmR3SqqR/GyAzs1+gknZK+ytWwQma+aFaqaZYJwteiZ4i5h/UDkP/gI=
Received: by 10.86.92.7 with SMTP id p7mr2429793fgb.72.1211659202078;
        Sat, 24 May 2008 13:00:02 -0700 (PDT)
Received: from localhost ( [85.141.150.140])
        by mx.google.com with ESMTPS id 4sm8297453fge.5.2008.05.24.13.00.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 13:00:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82825>

On Sat, May 24, 2008 at 12:16:17AM -0500, Govind Salinas wrote:
> On Fri, May 23, 2008 at 8:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > "Govind Salinas" <blix@sophiasuchtig.com> writes:
> >
> >> 1) Reduce the number of commands.
> >>
> >> I am currently at 30 total commands, and while I have some more to go, I
> >> think there are some ways that I can get rid of some of them by
> >> combining them.  Do we really need a clone, branch and checkout?  Don't
> >> these all mean the same thing in the end?  They mean get me a working
> >> directory of the repository starting at X.  For clone, you start
> >> with 'master'. For checkout, you tell it what to get you.  Branch
> >> will help you manage things you can locally get.  So perhaps we can
> >> do something like the following...
> >
> > Note that you sometimes want to make a branch without checking it out.
> > Also note that git-branch is overloaded to get a list of branches
> > available.
> >
> 
> Sure, removing commands is not about removing features, its about
> reducing the learning curve and reducing confusion.

I don't see how hiding creating branch functionality behind some other
command will help with learning curve or reduce confusion. If I started
to use any new SCM and had to create a new branch, I would look for the
"branch" command. If there is something wrong with the git-branch then
it is that this command does not checkout the newly created branch by
default. So, I usually create branches using git-checkout, which is
counterintuitive.

I don't think any commonly used SCM unites 'clone', 'branch', and
'checkout' functionality under the same name. This approach seems
to be more confusing than helpful.

Dmitry
