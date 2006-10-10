From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 22:31:36 +0200
Message-ID: <200610102231.37136.jnareb@gmail.com>
References: <egfo99$lg6$2@sea.gmane.org> <20061010191904.99261.qmail@web31809.mail.mud.yahoo.com> <7vvemsymdx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 22:54:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOc6-0003uk-B8
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 22:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWJJUyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 16:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWJJUyC
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 16:54:02 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:9908 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030351AbWJJUyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 16:54:00 -0400
Received: by ug-out-1314.google.com with SMTP id o38so830488ugd
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 13:53:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FwmSm2ghZNcDY7m+qIFw8ZROUMSApkc6HrQjB6anxHwMc2fnShgCsCSlOiwj1jPmEqp2yf+c7EkQ3jHWpsbe76tGRmDDfJRo3dF+3JTnHpuULFj9Ze5x7XtnnlIwxt6vkgfU1TMd190PKtqGf6YadYf5kaKymCCO/xOTQqI1PoY=
Received: by 10.67.89.5 with SMTP id r5mr8711252ugl;
        Tue, 10 Oct 2006 13:53:58 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id e34sm3209455ugd.2006.10.10.13.53.58;
        Tue, 10 Oct 2006 13:53:58 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vvemsymdx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28667>

Junio C Hamano wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Or,
> >    "Click on the 'blob' link to get the ... Click on the 'tree' link to
> >     get the ... Oh you didn't know what a 'tree' or 'blob' object is?
> >     A 'blob' is ... A 'tree' is ..."
> >
> > At which point the engineer has lost 90% of his interest.
> >
> > It even gets even worse for the obnoxious "tree" link next to each commit
> > in shortlog view:
> >    "The tree link is the the tree object which is part of a commit object.
> >     Oh you don't know the internals of a commit object?  A commit object
> >     binds a tree object and a (parent) commit object, but blah, blah, blah..."
> 
> Isn't that a simple "labelling" question?  I do not think
> anybody minds to show clickable string "contents" (instead of
> "blob" or "tree") at the places you mention above and if we did
> so everybody would be happy, right?

Not, IMHO it is not a good idea. Clicking on file name leads to it
contents, but it is not obvoius what kind of view is it. "blob" link
leads to blob view, "tree" link leads to tree view, which are known
what they mean to any git user.
-- 
Jakub Narebski
Poland
