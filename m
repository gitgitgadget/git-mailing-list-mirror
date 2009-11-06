From: david@lang.hm
Subject: Re: Git drawbacks?
Date: Fri, 6 Nov 2009 10:57:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com>  <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-692028141-1257533878=:3216"
Cc: Dmitry Smirnov <divis1969@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 19:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6U0c-0000lN-Lx
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 19:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759540AbZKFS5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 13:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757783AbZKFS5z
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 13:57:55 -0500
Received: from mail.lang.hm ([64.81.33.126]:40931 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbZKFS5y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 13:57:54 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id nA6Ivwkm016761;
	Fri, 6 Nov 2009 10:57:58 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132321>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-692028141-1257533878=:3216
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 6 Nov 2009, Avery Pennarun wrote:

>>> This
>>> lousy performance isn't the case in git (except in Windows).  Are you
>>> using Windows, by chance?
>>
>> yes. I did not yet noticed any performance problems with Git on windows, except
>> a sync/download time (for android, mostly)
>
> Basically, performance is linear with the number of files in your
> repo.  If you can check out just a "slice" of your repo (say 10% of
> the whole), you'll have faster performance (eg. 10x) from any VCS.
>
> git on Linux is so fast that this isn't very necessary most of the
> time.  But git on Windows isn't really any faster than other VCSes on
> Windows, so the time-per-file is much greater, and thus the penalty
> for huge repositories is much worse.  Doing things like switching
> branches, which is near-instantaneous on Linux even with tens of
> thousands of files, really crawls on Windows.

but is that scale based on the number of files you are tracking, or the 
number of revisions that exist in the repository.

i.e.  10,000 files in the source code with 10 revisions each vs 1,000 
files with 100 revisions each.

my understanding of git is that it's the number of files, with very little 
impact due to having lots of revisions. so eliminating 90 revisions of 
each file would not significantly speed up git in the second case.

going back to the initial poster's comments. if the android repo is 1G, 
eliminating the history will probably have significantly less impact than 
you expect it to. for source code the compression factor that git is able 
to get is spectacular. I've seen several cases posted with large projects 
where the full repo with ALL history is <2x the size of a tar.gz of the 
latest release.

David Lang

> So I can see an argument that Windows users would want arbitrary
> "slices" much more often than Linux+git users, but I think this is
> largely due to performance, not because people really *want* to be
> stuck with a restricted view of the repo.
>
> Have fun,
>
> Avery
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--680960-692028141-1257533878=:3216--
