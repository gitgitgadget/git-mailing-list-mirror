From: Bahadir Balban <bahadir.balban@gmail.com>
Subject: Re: reverting back both working copy and commits
Date: Thu, 12 Jan 2006 10:40:07 +0000
Message-ID: <7ac1e90c0601120240u3f8d7571g5e5bf52b6d3c4c2a@mail.gmail.com>
References: <7ac1e90c0601110832u6fc3a3bcwb7e584445610e53f@mail.gmail.com>
	 <7vslrutv2h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 11:40:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwzsP-0001jP-61
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 11:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWALKkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 05:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWALKkM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 05:40:12 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:39015 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030298AbWALKkL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 05:40:11 -0500
Received: by nproxy.gmail.com with SMTP id o25so231066nfa
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 02:40:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W+Do8OuJS7TOL2QVXRU6KLR1NfEzGY76Ouyw3FaN+jvbz1+A0dzr46pp4XSCeZjINbOb8i2dsII3o+XrwDolA1/VuxUD+3H2WlMstiQqv11p9cmjXr7BhoHwYhC+sb52+Vo7hLT8o+osCSCh5f2DX5mi+1ZlEXtUzo6d8lNFctA=
Received: by 10.48.14.17 with SMTP id 17mr124952nfn;
        Thu, 12 Jan 2006 02:40:07 -0800 (PST)
Received: by 10.48.30.15 with HTTP; Thu, 12 Jan 2006 02:40:07 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslrutv2h.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14558>

On 1/11/06, Junio C Hamano <junkio@cox.net> wrote:
> Eh?  That should not happen.
>
> Could you elaborate?
> What "git reset --hard" would leave behind are files in the
> working tree that you had when you made the wrongly done commit,
> which were *not* known to git (i.e. you forgot to "git add"
> before committing).  Since they are not known to git, "reset --hard"
> does not touch them.

Sorry, it's my mistake, I later realised the working tree had been
updated correctly.

Thanks,
Bahadir
