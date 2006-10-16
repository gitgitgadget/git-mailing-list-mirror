From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:39:09 +0700
Message-ID: <fcaeb9bf0610161639g34eea7e8nb21c881d79cb1c85@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	 <200610170119.09066.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 01:39:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZc38-000303-Ei
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 01:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422935AbWJPXjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 19:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWJPXjL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 19:39:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:3398 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750814AbWJPXjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 19:39:10 -0400
Received: by wx-out-0506.google.com with SMTP id h28so2049344wxd
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 16:39:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fLjYaBpb5TU5l1nvB90fIJT9GABmi76tm4ksudd0IDczNbbNJgr7irW63udJqmNhhYVHg82neYdUsXtjBljsRXGq200rXKzitNS/2uJSD5AzFHSoQfBDkWefXczuHayU7YefgYtETFMmv9buOyxIiv1GKBom8DikiBGrsxKDlDI=
Received: by 10.70.11.5 with SMTP id 5mr12473435wxk;
        Mon, 16 Oct 2006 16:39:09 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Mon, 16 Oct 2006 16:39:09 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610170119.09066.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28996>

On 10/17/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Aaron Bentley wrote:
> > Jakub Narebski wrote:
> >> About "checkouts", i.e. working directories with repository elsewhere:
> >> you can use GIT_DIR environmental variable or "git --git-dir" option,
> >> or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
> >> "symref"-like file to point to repository passes, we can use that.
> >
> > It sounds like the .gitdir/.git proposal would give Git "checkouts", by
> > our meaning of the term.
>
> Actually it is better to work with clone of repository, perhaps either
> symlinking object database, or by alternates mechanism (with alternates
> repositories would share old history, but gather new independetly
> I think).
I agree. Each Git repository is designed to work with one working
directory. Using .gitdir/.git proposal, you are likely to checkout two
working directories from one repo.
-- 
Duy
