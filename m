From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 1 Jun 2006 20:59:17 -0400
Message-ID: <9e4733910606011759t7c828a50gc4a6b45d92d2b344@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <Pine.LNX.4.64.0606011643290.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 03:00:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fly0Y-0001gZ-Fw
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 02:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWFBA7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 20:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWFBA7T
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 20:59:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:2907 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751038AbWFBA7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 20:59:18 -0400
Received: by nz-out-0102.google.com with SMTP id s18so417445nze
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 17:59:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/cI6JlVDZOPtABnu2MfhCcGgV57ZnPPwDt0gQkiBItRWdVlkg8HRJq4ydQLy6O/issmiC9fB5Tjg7kyenpYDgrIS6x9Ljf/eUeRyBV4UYiZkmUhBXcuFhqmLqjFTTXo3BNpyevIuOPHwyxtwympgt/2R4SpfPNCM1C/YsZQHaQ=
Received: by 10.36.220.73 with SMTP id s73mr1683828nzg;
        Thu, 01 Jun 2006 17:59:17 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Thu, 1 Jun 2006 17:59:17 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606011643290.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21132>

On 6/1/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 1 Jun 2006, Jon Smirl wrote:
> >
> > I've been working on importing the Mozilla CVS into git for the last
> > few days. I've fixed up parsecvs so that it can parse the entire
> > repository without errors. Now I'm running into problems because there
> > are over 300 branches.
> >
> > I just run into a problem with git show-branch. Mozilla CVS has a lot
> > more than 29 refs, is this something that can be expanded?
>
> Hmm.. Any reason you care about "show-branch --all" in particular?
>
> The algorithm used for show-branch really doesn't scale well, it needs one
> bit per commit per branch, and I didn't realize anybody could ever really
> care.

I was trying to use it to figure out what was wrong with the branch
processing in parsecvs. It doesn't have to be fixed. show-branch --all
fails with same 29 tag limit.

-- 
Jon Smirl
jonsmirl@gmail.com
