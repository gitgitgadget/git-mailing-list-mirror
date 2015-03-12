From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Wed, 11 Mar 2015 18:23:21 -0700
Message-ID: <935E98CF-A4E8-4392-B247-61863A9B033A@gmail.com>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com> <xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com> <2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 02:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVrqk-0002hY-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 02:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbbCLBXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 21:23:41 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37407 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbCLBX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 21:23:26 -0400
Received: by pdbnh10 with SMTP id nh10so15676404pdb.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:subject:mime-version:date:references;
        bh=Zcxljii5bEiEf6bG2CrSnBsUzfdnOxVGvjuNth4sABA=;
        b=lYOwEqH1L3m74x59sp28Y8I2V22Wz8BK5SFII2MZf2wK9zZq36FkYEzWiK7zHYXTO6
         cvSQKil0Vi/L5SRsqDaqcS9ayLKLW/s8cMNf6iXNX1HD3dYhSxx66oap2i8rm2MAwENF
         3PVGYRko4HWN5oBzaJOroG9tYuq8M7SvA0DpO50SRz+iCWV5Z1QB2PA/4eqwUfGyWssH
         k8OJq5pSvhbK2QtX6wrPYNeumNlnb5N/KwugXISlfRJMmw6DMD0+RZ/k/Yc794yYYeRF
         nH+UPPzDTwtOCfcqxAnNLPzTYbp9v2kv5Ta37nmZPSHq2wnEii4QiqZ10NT+BpdXX2wD
         S6lQ==
X-Received: by 10.66.221.135 with SMTP id qe7mr82624068pac.97.1426123406127;
        Wed, 11 Mar 2015 18:23:26 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id os6sm8014101pac.28.2015.03.11.18.23.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 11 Mar 2015 18:23:25 -0700 (PDT)
In-Reply-To: <2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265349>

The first two messages in this thread were dropped by the vger mailing  
list for some unknown reason.

In an attempt to make the mailing list archives of this thread  
complete, the original two messages in this thread are included below.

-Kyle

---- BEGIN FIRST MESSAGE ----
From: Kyle J. McKay <mackyle@gmail.com>
Date: February 24, 2015 09:16:05 PST
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Any chance for a Git v2.1.5 release?
Message-Id: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes

As you know, I help out with repo.or.cz.  Recently the admins have  
been discussing upgrading the version of Git we use in order to  
support newer features such as pack bitmaps.  While we do use a  
slightly customized gitweb, we have always stuck to an official Git  
release for everything else.

Repo.or.cz provides fetch (git, http, https, ssh), browsing (gitweb)  
and push (ssh, https).  Additionally, created repositories can be  
mirrors (no push allowed) of other repositories (including svn via git- 
svn).  Email notification of ref changes (along with diffs) can also  
be requested.

We are finding that in order to upgrade Git at this point we would  
need to build a custom Git with cherry picked fixes for various issues  
that have come up or they would likely be triggered by one of the  
services repo.or.cz provides.  In addition, as there are numerous  
reports of an unresolved issue with git-svn starting with v2.2.0  
upgrading to v2.2.0 or later presents a problem since we have several  
mirrors that rely on git-svn.

Which brings us back to the subject of this email, is there any chance  
for a v2.1.5 release?

After reviewing a few release dates:

2011-06-26T12:41:26-07:00 v1.7.6
2012-02-05T23:51:07-08:00 v1.7.6.6

2013-11-27T12:14:52-08:00 v1.8.5
2014-02-13T13:42:01-08:00 v1.8.5.5

2014-02-14T11:36:11-08:00 v1.9.0
2014-05-30T10:15:10-07:00 v1.9.4

2014-05-28T11:04:29-07:00 v2.0.0
2014-07-30T14:20:01-07:00 v2.0.4

2014-08-15T15:09:28-07:00 v2.1.0
2014-10-29T10:48:57-07:00 v2.1.3

2014-11-26T13:18:43-08:00 v2.2.0
2015-01-12T14:06:20-08:00 v2.2.2

2015-02-05T13:24:05-08:00 v2.3.0

(I have omitted the dates of the 5 security releases on 2014-12-17 as  
that seems like an extraordinary event unlikely to be repeated.)

It appears that the average support lifespan of a Git release from  
initial release date through last released maintenance update is  
approximately 2-3 months with the 1.7.6 release being an exception at  
a little over 7 months.

If a v2.1.5 release is out of the question, would it be possible to  
periodically designate certain Git releases as "long term support"  
releases?  Meaning that they would receive maintenance updates (e.g.  
fixes for invalid memory accesses/crashes, regressions or security  
issues) for an extended period of time, say at least 6 months?


Here's the analysis that led to this request:


Goal 1: add support for symref=HEAD:refs/... capability

Goal 2: add support for pack bitmaps

Nice to have: The CVE-2014-9390 fix, but repo.or.cz does not create  
any working trees so it's not mandatory.


Goal 1:

symref=HEAD:refs/... requires at least Git 1.8.4.3.  However,  
repo.or.cz runs git-daemon with read-only access to the repositories  
and since Git 1.8.4.2 shallow clones require write access.

This was corrected in v2.0.0.  So at least v2.0.0 would be needed for  
symref=HEAD:refs/....


Goal 2:

Pack bitmap support was added in v2.0.0, but it's probably not a good  
idea to run without 21134714 (pack-objects: turn off bitmaps when we  
split packs) just in case which requires at least v2.1.3.


Nice to have:

If at least v2.1.3 is required, then we might as well use v2.1.4 since  
the primary change from v2.1.3 to v2.1.4 is the addition of the  
CVE-2014-9390 fix.


What about a later release, v2.2.0 or later?


git-svn is reported to suffer from occasional ".git/ 
Git_svn_hash_XXXXXX: Bad file descriptor" errors since v2.2.0 making  
that a non-starter.  No fix is currently available in the Git  
repository.

Since 660c889e (sha1_file: add for_each iterators for loose and packed  
objects) loose objects in alternates directories may not be found when  
pruning.  This affects v2.2.0 and later.  A fix is currently in  
master.  This is an absolute must have for repo.or.cz as alternates  
are used to implement repository forks.

Since d38379e (make update-server-info more robust), affecting v2.2.x,  
the files used by non-smart HTTP clients could have the wrong  
permissions.  This might preclude them from being updated correctly on  
repo.or.cz.  It would require research to see if repo.or.cz is  
affected.  The fix for this d91175b2 (update-server-info: create info/ 
* with mode 0666) was released in v2.3.0.


So why not v2.1.4 then?


There's an XDL_FAST_HASH performance regression that affects v1.7.11  
and later [1].  But that can be turned off in config.mak.

New repositories have an extra +x on the config file since v2.1.0  
(fixed in v2.2.2), but we can compensate with a chmod after creating a  
new repository.

Git blame has a crashing regression since ea02ffa3 (mailmap: simplify  
map_user() interface) that affects v1.8.2 and later. The fix is  
currently in master.  repo.or.cz enables blame in the gitweb interface  
so that would be a serious regression.

There's an issue with ungetting EOF.  That would seem unlikely to  
affect repo.or.cz, but, I wonder if any of the displays used by gitweb  
could trigger attempts to read a .mailmap or .gitattributes blob?  I  
don't know.  Would require research to be certain or just picking up  
the fix which is currently in master.

There's a decimal_width overflow regression since dc801e7 (diff -- 
stat: use less columns for change counts) affecting v1.7.11 and later  
that can lead to an infinite loop in some cases.  Presumably either  
gitweb or the diffs sent out by the ref update email notification  
mechanism could trigger this.  A fix is currently in master.

There is a regression since v1.7.1.1 where a fetch from a non-smart  
HTTP source could potentially fail to retrieve the correct objects.   
As repo.or.cz has several mirrors set up from non-smart HTTP sources a  
fix for this (currently in master) would be nice but is probably not  
mandatory since repo.or.cz is currently running a version of Git with  
this regression and has not received any reports of failures that  
could be related to this.

Since fbd4a703 (list-objects: mark more commits as edges in  
mark_edges_uninteresting) affecting v1.8.4.2 and later combined with  
200abe74 (list-objects: only look at cmdline trees with edge_hint)  
affecting v1.9.0 and later there is a performance regression when  
pushing with lots of refs to non-shallow repos.  The fix 2dacf26d  
(pack-objects: use --objects-edge-aggressive for shallow repos) was  
released in v2.3.0.


-Kyle

[1] http://thread.gmane.org/gmane.comp.version-control.git/261638
---- END FIRST MESSAGE ----

---- BEGIN SECOND MESSAGE ----
From: Junio C Hamano <gitster@pobox.com>
Date: February 24, 2015 11:52:03 PST
To: Kyle J. McKay <mackyle@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Any chance for a Git v2.1.5 release?
Message-Id: <xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com>
Content-Type: text/plain

Kyle J. McKay <mackyle@gmail.com> writes:

> Which brings us back to the subject of this email, is there any chance
> for a v2.1.5 release?
> ...
> It appears that the average support lifespan of a Git release from
> initial release date through last released maintenance update is
> approximately 2-3 months with the 1.7.6 release being an exception at
> a little over 7 months.

That matches my expectation.

A typical cycle lasts for 8-12 weeks, and during that time, topics
that are bugfixes that have graduated to the 'master' branch are
merged to the 'maint' branch with some lag and then the tip of
'maint' gets tagged as a maintenance release from time to time.
Some important but trivial fixes are further merged to older
maitenance tracks like 'maint-2.2', 'maint-2.1', etc.

But these topics downmerged to older maint-* branches have to be
very trivial for an obvious reason: there are only 24 hours a day
and 7 days in a week, and bugs that affect real world use cases are
found by using the software in real world use cases.  Usually I use
something a bit ahead of 'next' exactly for this reason---we would
want to catch bugs before topics are merged to 'master'.  Although I
sometimes have "let's use 'maint' for my work" day once or twice
every month, I cannot afford to do that for anything older than the
tip of 'maint' myself.

The consequence of the above is this.  v2.1.1 may be more stable
than v2.1.0 and v2.1.2 may be more stable than v2.1.1, but later
tagged versions on older maintenance tracks are made by merging
topics only after "ah, these are obvious enough" eyeballing without
real use (at least by me), once newer feature release is made and
there is a newer maintenance track.  I would not be surprised if
v2.1.5, if it is made, has hidden interactions between the changes
since v2.1.4 and the older codebase to cause unforeseen bugs.

When I say "the tip of 'master' is meant to be more stable than any
tagged versions", I do mean it.

Having said all that, if I were to tag maint-2.1 branch as 2.1.5
today, we would have

   6aaf956 is_hfs_dotgit: loosen over-eager match of \u{..47}

that does not exist in 2.1.4.  Is that what you want?

> If a v2.1.5 release is out of the question, would it be possible to
> periodically designate certain Git releases as "long term support"
> releases?

I can designate ;-), but I do not think I'd be the right person to
maintain or long-term-support it.  Are you volunteering to oversee
the "LTS team"?  It would involve:

   - Monitor "git log --first-parent maint-lts..master" and find
     the tip of topic branches that need to be down-merged;

   - Down-merge such topics to maint-lts; this might involve
     cherry-picking instead of merge, as the bugfix topics may
     originally be done on the codebase newer than maint-lts;

   - Use the tip of the maint-lts branch in everyday work.

The last item is the most important of the above, because I do not
have time for that.  I can help with the first two to some degree,
though.

If the lts releases need to be tagged and published by me, then lts
team can have me pull from the tip of maint-lts they are confident
with and have me sign it and push it out.

If the primary concern you have with the currently maintained
releases is git-svn, perhaps a better way forward for you,
especially if you are willing to maintain your own "release plus
patches", might be to keep a patch that reverts recent git-svn
changes back to v2.1.whatever and deploy the up-to-date release
and that patch on top?

> Nice to have: The CVE-2014-9390 fix, but repo.or.cz does not create
> any working trees so it's not mandatory.

Even if you do not have a working tree, people who use you as the
meeting place and push into you and fetch from you do, so I do not
necessarily agree with your assessment.
---- END SECOND MESSAGE ----
