From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-svnimport
Date: Sat, 4 Feb 2006 16:12:32 +1300
Message-ID: <46a038f90602031912l1d26b615u563e8a9e9d8c625c@mail.gmail.com>
References: <200602031429.07894.jharrison@linuxbs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 04:12:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Dqn-0007kA-1C
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 04:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946279AbWBDDMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 22:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946291AbWBDDMe
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 22:12:34 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:20971 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946279AbWBDDMd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 22:12:33 -0500
Received: by wproxy.gmail.com with SMTP id i34so712112wra
        for <git@vger.kernel.org>; Fri, 03 Feb 2006 19:12:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=baXYErLS4NjND0D/L+7EwNpj1R/CofGWpPCi6ASmK6Y5IL1fIKjIaNDtWJZcYpVyZ7OlDLAz2uGWCh2wcrU8XOt23KWah2regI93csTAQJjdjHiujX1sq9+Ehi9TOivfnc6N96PwvyrJ+XMSLzbp8XYlPhxUrkrQR3+UVBC/BiI=
Received: by 10.54.114.2 with SMTP id m2mr3423560wrc;
        Fri, 03 Feb 2006 19:12:32 -0800 (PST)
Received: by 10.54.71.7 with HTTP; Fri, 3 Feb 2006 19:12:32 -0800 (PST)
To: Jason Harrison <jharrison@linuxbs.org>
In-Reply-To: <200602031429.07894.jharrison@linuxbs.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15567>

On 2/4/06, Jason Harrison <jharrison@linuxbs.org> wrote:
> I am trying to import from an svn repository into a git repository using
> git-svnimport.  So far my attempts have failed.  Here is what I have done so
> far.

You always want to be passing the branches and tags parameters
explicitly. SVN repos have so many weird layouts that svnimport does a
bad job without them. Trial and error has worked for me ;-)

See for instance:

  http://www.gelato.unsw.edu.au/archives/git/0512/14069.html

regards,


martin
