From: "Tony Stubbs" <antony.stubbs@gmail.com>
Subject: Re: git svn rebase - could not detach HEAD
Date: Thu, 7 Aug 2008 19:19:36 +1200
Message-ID: <f7d8f60b0808070019v2850f493md9d75df03f98dc3b@mail.gmail.com>
References: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 09:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQznf-0000xs-8U
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 09:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbYHGHTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 03:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbYHGHTj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 03:19:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:57820 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbYHGHTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 03:19:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so335981rvb.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=M7qgN8br6Hk3rG/IUaNQkChU4SB6DGK/5usezTWs1HI=;
        b=qfhlKyFCzU0aaTA+nCimXkJ6AAx2tQfsu3EM1tFA2cLO3xb3oLrNGX8OuXVNXftmK7
         1jEPSYN+92sOORYTxCf/oWcd3sZUwtX60/GGSh8sDfEwGkAA4olnLfGjyRKGaZBkLKKU
         JQcZKEdLfWZ/Z7feA7j39wphMEPSqD4jbVjso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GfZUL3mJcbFy8aPbyuAoqqFHURI3nZfzFR/gaJtZFVl3kGr1nCofq5lb0IyRL5VZ0O
         Hr+1D+hXVL2akPw62CErxQjM9BxT6pUcGF8xPauRMKbVC7fEq+duSqWeHHULby5MveDk
         ndMXtAhzzDX3f7kun8kcHNbZVWi6H0HvkfQCY=
Received: by 10.114.168.1 with SMTP id q1mr1140825wae.72.1218093576453;
        Thu, 07 Aug 2008 00:19:36 -0700 (PDT)
Received: by 10.114.157.2 with HTTP; Thu, 7 Aug 2008 00:19:36 -0700 (PDT)
In-Reply-To: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91562>

Some more info...:

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git merge-base HEAD git-svn
5bfad5dee44fd18f7c3a39e7dcb234828c840c24

commit 5bfad5dee44fd18f7c3a39e7dcb234828c840c24
Author: boses <boses@c07779a9-5238-0410-8e60-f4d13a72d009>
Date:   Thu Aug 7 01:28:44 2008 +0000

    Siebel Java Interface Merged

    git-svn-id:
http://10.107.6.150/repos/portal/oasis/branches/oasis-cr@3273
c07779a9-5238-0410-8e60-f4d13a72d009

$ git branch -a
  emailTemplateWork
  hibernate
  integration
* master
  git-svn
  git-svn@1775
  git-svn@2473
  laptop/emailTemplateWork
  laptop/hibernate
  laptop/master
  temp/master


stubbsa@VFNZV95336 /cygdrive/c/dev
$ git checkout hibernate
Switched to branch "hibernate"

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git checkout master
Checking out files: 100% (295/295), done.
Switched to branch "master"

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git svn rebase
First, rewinding head to replay your work on top of it...
could not detach HEAD
rebase refs/remotes/git-svn: command returned error: 1

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git rebase
fatal: Needed a single revision
invalid upstream

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git rebase git-svn
First, rewinding head to replay your work on top of it...
could not detach HEAD

2008/8/7 Tony Stubbs <antony.stubbs@gmail.com>:
> Having trouble rebasing against svn off a clean repo.
>
> I am using windows / cygwin.
>
> Here's the output:
>
> stubbsa@VFNZV95336 /cygdrive/c/dev
> $ git status
> # On branch master
> nothing to commit (working directory clean)
>
> stubbsa@VFNZV95336 /cygdrive/c/dev
> $ git svn rebase
> First, rewinding head to replay your work on top of it...
> could not detach HEAD
> rebase refs/remotes/git-svn: command returned error: 1
>
>
> stubbsa@VFNZV95336 /cygdrive/c/dev
> $
>
> I already tried asking on the channel...
> Any ideas? I'm kind of stuck as I have commits I need to dcommit.
>
> p.s. git stash also shows:
> stubbsa@VFNZV95336 /cygdrive/c/dev
> $ git stash
> No local changes to save
>



-- 
___________________________
http://stubbisms.wordpress.com/
