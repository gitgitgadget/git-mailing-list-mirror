From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Migrating a git repository to subversion
Date: Fri, 16 May 2008 10:59:22 +0600
Message-ID: <7bfdc29a0805152159l52a300e4rc1da3fe61db60fdc@mail.gmail.com>
References: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alf Mikula" <amikula@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 07:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jws3C-0002qs-TG
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 07:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbYEPE7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 00:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYEPE7Y
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 00:59:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:3529 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbYEPE7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 00:59:23 -0400
Received: by yw-out-2324.google.com with SMTP id 9so426455ywe.1
        for <git@vger.kernel.org>; Thu, 15 May 2008 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vXyBsviWAVfpkswvkohxik3b/G3lnb8UDwWwUfwSnpY=;
        b=wwXgyCyhUZ2+NDRyZHXiBNKg57tMu7z6XT6EWdgzgSd8AEdQVlgUiy69SlBZYFANkf4rlAraw/iP1HDo9QYQGErxUqRW954GHIqA3F8G7PBlXKM8BGU+LVZ9nZtgUz/c2ZIXPp3A+6m9XvwogXfqNR2kvNcsbmJehvV1LJRJ/u0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bZySIKItHp2BbEVP75nKLMP/+15Ni7pRt0FJMy/mPYRKIh+saL/y1wfmswYtIi4/iaB/HtbV+grpGBuMrJU4IXhh+lsX49Yfx3oe+Kw8VlxXeAAFD2gxqleiI3McMlDnsQ7+7KVB8fQsKsmGqSh/WauE/Q3JTDD+Fg3HqVau2CE=
Received: by 10.150.57.1 with SMTP id f1mr3152393yba.77.1210913962191;
        Thu, 15 May 2008 21:59:22 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Thu, 15 May 2008 21:59:22 -0700 (PDT)
In-Reply-To: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82258>

On Fri, May 16, 2008 at 5:08 AM, Alf Mikula <amikula@gmail.com> wrote:
> I'm a relatively new (2 weeks) user of Git, and so far I really love
>  it, and I want to educate my co-workers about it.
>
>  Having said that, I want to demonstrate git's git<--->svn
>  capabilities, and currently everybody here has and understands
>  Subversion.  So, I want to initialize a Subversion repository with my
>  git history from my local git repository.  Here's what I tried:
>
>  1. Create a new, empty subversion project with trunk/tags/branches subdirs.
>  2. git svn clone http://myhost.com/path/to/project --stdlayout

I would just create another local branch and merge the tracking branch
into it, then rebase the branch with the master branch and then do the
svn dcommit. If the 'git svn clone' 'd repo is bare I think it should
commit the individual commits.

Best regards,

Imran

>  3. git pull ../git_project
>  4. git svn dcommit
>
>
>  This put all my files into Subversion, but under a single commit.  Is
>  there a step I'm missing that would allow git to commit all my
>  individual git commits to the Subversion repository?  I've done a
>  bunch of searches, but all the docs seem to focus on cloning an
>  existing svn repository, as opposed to exporting git repositories to
>  Subversion.
>
>  Thanks in advance,
>
>  -Alf
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
