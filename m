From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 17:30:33 +1200
Message-ID: <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	 <469804B4.1040509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jul 14 07:30:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9aDS-00080h-Ab
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 07:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbXGNFag (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 01:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXGNFag
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 01:30:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:21132 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbXGNFaf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 01:30:35 -0400
Received: by wx-out-0506.google.com with SMTP id h31so678574wxd
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 22:30:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D3/34GutTroSqiA9n9//+R9utRG2JhVz/1wSBADtfGixrKjMNQhRPUVbK0z61DQtZIcJM57vaFa7EBXjUcZ2x5ln6qhqzw4ChZkDe6XqTCKWWwHfszkrGdhG9MLKqIk1ItqPAwm+0ayhfP3MZ9UeGQAqV6ahR6723u+6tb0pb7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pxTC4TDFnxRahgdL1CgSAhWTUL4NO4cLkkfPS62VmKZqgS+qVioTE23ODOD0oH7NiJYypVrWDYIzZcYWHHMbkfuHcrJcLWZoXhorKB/n/jaoLsvxRB7Ki+8A0mNUrOOPzCbU+fb8iT0/PfulJw8nFF3C2Ki7xl56iGKKKnyuT6g=
Received: by 10.90.36.3 with SMTP id j3mr2219170agj.1184391033977;
        Fri, 13 Jul 2007 22:30:33 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Fri, 13 Jul 2007 22:30:33 -0700 (PDT)
In-Reply-To: <469804B4.1040509@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52441>

On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking about
> what it would take to write some other back ends for cvs2svn--turning
> it, essentially, into cvs2xxx.  Most of the work that cvs2svn does is
> inferring the most plausible history of the repository from CVS's
> sketchy, incomplete, idiomatic, and often corrupt data.  This work
> should also be useful for a cvs2git or cvs2hg or cvs2baz or ...

Great to hear that. I'm game if we can do something in this direction
- surely we can make it talk to fastimport ;-)

Does cvs2svn handle incremental imports, remembering any "guesses"
taken earlier? Last time I looked at it, it had far better logic than
cvsps, but it didn't do incremental imports, and repeated imports done
at different times would "guess" different branching points for new
branches, so it _really_ didn't support incrementals

cheers,



m
