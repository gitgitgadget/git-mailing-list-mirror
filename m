From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com refresh
Date: Tue, 08 May 2012 09:51:39 -0700
Message-ID: <7vlil2wr8k.fsf@alter.siamese.dyndns.org>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
 <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
 <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
 <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
 <C0239E9A908644EAB06A52AE4A90F401@PhilipOakley>
 <7vipg77wg1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Scott Chacon" <schacon@gmail.com>,
	"git list" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue May 08 18:51:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRndf-0003kR-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757452Ab2EHQvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:51:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757448Ab2EHQvl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:51:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 734366B47;
	Tue,  8 May 2012 12:51:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=p0JZGwFPAEjAMa+zI4/i5CI/vjE=; b=sqbjno4G5L45UIvWbRR2
	AQttO9+kTttsNm2rcQpF+Sb74ZzrLNPafJokIzO1kASmW5sKQMGoCsnTl/F66zZO
	keazLgCuey9zoPD250KvLcGwohdD76mgfFI429F3hbwLl6i5YnGwOlmJYcTNExGf
	y1GajBY4WDCgcCzcZaHQa+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Hx82rl/JaEqS29wq3d0RTHyN/UtQ07tTR8791BgB5gKnJL
	5rlWDdSasngYYb6qvtSuuZ0YH9e2llXKb9eLVETuNp84KOBtD1Z4RA0htI9uE5k8
	tPAUOcZat0/LqPVKbN0aA62/1lyO3eTno1PDVs8L/OJKW9HPajIe/Kd7ioDO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69D3F6B46;
	Tue,  8 May 2012 12:51:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93F6D6B43; Tue,  8 May 2012
 12:51:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1581689C-992E-11E1-AF75-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197392>

Junio C Hamano <gitster@pobox.com> writes:

> But what I have been discussing was the use of "diff" in the "Basic
> Snapshotting" section.  I actually very often use "diff" paired with
> "apply" for my own work, not when working to integrate others' work.  
>
> Also I do not think anybody would use "apply" to accept patches (that is
> what "am" is for), so listing it in "Email" section is doubly wrong.  If
> for some reason the command Reference does not want to have "apply" next
> to "diff" listed in "Basic Snapshotting", I do not think there is any
> category on that page for the command to belong to.
>
> The above two were the primary things that triggered my reaction.
>
> When reshaping a multi-commit series, "git diff $rev1 $rev2 >P.diff"
> followed by "git apply <P.diff" (either with or without editing P.diff in
> between) is sometimes a more versatile and even more natural solution than
> repeated use of "rebase -i" is, depending on what kind of reshaping
> I want to do.
>
> For example,...  Of course this
> does not have to be "rebase" but picking only part of good infrastructure
> change from totally unrelated branch.  A concrete example is ...

I encountered another example yesterday after sending the above message
[*1*].  I was fixing one small bug, and had a commit that updates code and
adds a test vector.  It is a single commit on top of the current branch
tip, which allegedly as a buggy code.

Then I wanted to double check that the bug really existed before the fix.

	git checkout HEAD^
        git show @{-1} t/ | git apply
        make test

The above gave me the pristine state plus only new tests to let me see the
old code was indeed buggy.

I also hit another example use case yesterday.

A series was posted that was a fix that should go to "maint" but the
pathces were based on "master".  The usual "git am -s3c" on "maint" didn't
exactly grok the series, as there were semantic conflicts (a new field was
added between "maint" and "master" to the structure the patch touches to
add yet another field).  So here is what I had to do:

	git checkout -b jk/status-porcelain-z-b master
        git am -s ./+mbox
        git checkout -b jk/maint-status-porcelain-z-b
        git rebase --onto maint master
        ... fix conflicts, resolving semantic conflicts along the way

	git checkout -B jk/status-porcelain-z-b master
        ... at this point, jk/status-porcelain-z-b@{1} is what the series
        ... applied to 'master' as the poster intended.
        git merge jk/maint-status-porcelain-z-b
        ... conflicts, which is more or less a squashed version of the
        ... mess I dealt with when I rebased the original to maint
        ... rerere will replay the mechanical part.
	... look at the conflict in "git diff" (no other
	... arguments) and making sure that it mostly makes sense.
	git add -u
        git diff
        git diff HEAD
        ... but the semantic conflict part is still missing, which
        ... can be eyeballed like this.
        git diff -R jk/status-porcelain-z-b@{1}
        ... then transport the remaining changes.
        git diff -R jk/status-porcelain-z-b@{1} | git apply --index
	... and then double check the result
        git diff HEAD

And I had exactly the same use case today for another series.

It turns out that "nobody uses apply while accepting patches" is not quite
true.  I do use "apply" while accepting patches.  But I do not use it on
"format-patch" output.  That is what "am" is for.

In any case, the latter part of the write-up above was done primarily
because I thought it would be illustrative for others who need to flip
commits (whether it comes in patch form, or you develop your own) between
multiple code bases.  As people say, just my two cents ;-)


[Footnote]
 
*1* I admit that I use "apply" so often that I do not have to think when
using it, and I realize use cases of it only during the course of the
usual work day, not during a theoretical "I do not think anybody uses 'git
apply' on 'git diff' output" discussion.
