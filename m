From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Mon, 21 Jul 2008 00:43:16 +0200
Message-ID: <bd6139dc0807201543r6fd718d2rfbc8ad100cc75f2c@mail.gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
	 <200807210029.31543.jnareb@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sam Vilain" <sam@vilain.net>,
	"Joshua Roys" <roysjosh@gmail.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Lea Wiemann" <LeWiemann@gmail.com>,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhdZ-0007vn-KB
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYGTWnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYGTWnS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:43:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:39972 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbYGTWnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:43:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1291854wfd.4
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QFse9r3/LK4QvX6I+mJ32DQeDvl4CDuwEfQLya2fZyM=;
        b=KoJHisBulOTePFxkcDsFhA/GHBPOfB20psathUo3ifzlNRWJXa2qBs/MwkvFP17R9a
         Ixn9iHmG1hoMuaObEh3bYrKnwM8AAalNWdf0vaKnWJglrIj7PcCeiSSrMW1N7xUIS3qx
         5WHjA3pjmjNlKF3JzAbplBtZWZfLYWIwLxMos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=aNQOylag2cY3XBLc9PjQ28z5rjVBBOsM5UKrcvOkCGmCWEK/vqJebB5DRifG4wY4FI
         3oSfJI2bM9dnVc4vHQr5J4ek7xS2jzh9YVnpbuz/bx52gusxFEcz75FHOYx9i9dchiaC
         fkgc+eTLmuNaYsFMrJ95nBpYDWGIc9W8u3zlw=
Received: by 10.143.44.17 with SMTP id w17mr1038307wfj.242.1216593797012;
        Sun, 20 Jul 2008 15:43:17 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 20 Jul 2008 15:43:16 -0700 (PDT)
In-Reply-To: <200807210029.31543.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89253>

On Mon, Jul 21, 2008 at 12:29 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Here is a bit late summary of this thread (and of information gathered
> elsewhere).  I'll try to add this information to wiki page in approx
> two days from now... of course unless project student or mentor wouldn't
> do it first.

I've been feeling guilty about not writing a summary yet, sorry for that :(.

> 2. git-statistics
>
> Student: Sverre Rabbelier
> Mentor: David Symonds
>
> There were some posts about how git-statistics can be used:
>  http://thread.gmane.org/gmane.comp.version-control.git/81534
>  http://thread.gmane.org/gmane.comp.version-control.git/82027
> There is post with link to different git.git statictics:
>  "[GitStats] Bling bling or some statistics on the git.git repository"
>  http://thread.gmane.org/gmane.comp.version-control.git/88174
>
> A short listing of metrics done:
> * stats.py author -d: Shows file activity of a specific developer
>  measured in how often they made a modification to a file and total
>  lines added/removed (much like a diffstat, but now for a specific
>  developer instead of one commit).
> * stats.py author -f: Shows file activity of a specific file measured
>  in how often they made a modification to a file, could be extended to
>  also count changes like "author -d"

* stats.py bug -t: Calculates a 'score' for a specific commit,
representing how likely it is to be a bugfix. There are four metrics
used to determine this: "Commits x reverts another commit y", "Commit
x belongs to one of the specified branches (e.g., 'maint')", "The diff
for commit x contains a specific phrase", "The msg for commit x
contains a specific phrase". A rating can be given to each metric by
the user.
* stats.py bug -a: Aggregates the 'bug -t' metric over a range of
commits. The default is the last 10 commits on HEAD. This routine is
optimized to   not recalculate metrics/to not redo work   that was
already done in a 'bug -t' call for another commit. As such there is a
set setup time to determine the type of the first commit, after which
calculation time increases at a much lower pace. (So 'bug -a' on 10
commits might take 4 seconds, and running it over 11 commits might
take only 4.5".)

> * stats.py branch -b: Shows which branch a specific file belongs to,

a commit 'belongs to' a branch when the commit is made on that branch.

> * stats.py commit -v: Shows all commits that are reverted by the
>  specified commit, will be extended to allow detection of partial
>  reverts

This has been moved to 'diff -r'.

> * stats.py diff -e: Shows whether two specific commits introduce the
>  same changes
> * stats.py diff -e -n: ditto, but ignores what changes were made, only
>  looks at the changed lines
> * stats.py diff -e -i: ditto, but inverts the comparison, instead of
>  comparing addition with addition and deletions with deletions, the
>  additions of the first diff are compared with the deletions of the
>  second diff, and vise versa. This way a revert is easily detected.
> * stats.py index -t: Shows which commits touched the same paths as the
>  staged changes

I think the rest is a nice summary of what I've been doing :).


> SUMMARY:
> ========
> [...] "git-statistics" did a minimum what it was meant to do already, and it looks like it would be finished before August 11. [..]

My deadline is August 1 since my vacation starts then and I can't work
during my vacation (all hail American tax laws), but David is
confident that I will have a finished product before then, and I plan
not to let him down on that expectation.

> Please correct any mistakes in this summary / writeup.

I tried to as best as I could :).

> Thanks in advance.

No, thank you! Thanks for writing up this summary, very nicely done.

-- 
Cheers,

Sverre Rabbelier
