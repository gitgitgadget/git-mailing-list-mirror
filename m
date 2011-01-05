From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: developing a modified Linux-style workflow
Date: Tue, 04 Jan 2011 18:47:30 -0600
Message-ID: <4D23BFA2.7000603@gmail.com>
References: <E54235A96EB484418EBD9509F37176D210049C61@htmail10.hightouchinc.com> <344D6422-8F2B-4545-A680-06F434C17F5B@at.or.at> <4D238EDC.9000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Neal Kreitzinger <neal@rsss.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 05 01:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaHXs-0006QV-IS
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047Ab1AEAsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 19:48:03 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35301 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab1AEAsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 19:48:01 -0500
Received: by gwj20 with SMTP id 20so6732449gwj.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 16:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xrSTo4GKFE+I3LC+2u3+IGGnEP1zk+X+DABeClWh7Hg=;
        b=XHAr9TjziZq2zKATASUGS3RHY+ljTwyz7VLUXR/Hw9ng6NoTQf1I9k3s577HU3KSYZ
         4sXKP8sjM5lYUn1Ie6jqkdqpK56ryYbiJkpv089+sZ/MVMnjA4yL180C1KloDY77qMfK
         f4UAxeFWAMvhLouUUpdG/XIrUlnAcE/MlcvTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RjLmKGeLp5qLGduLoIfvTgWU92fRqedoIRiOqQ0MyG+Wj7GmLkjpQV/LY/akyYZgPF
         zgPj7+PLpG5jlkwUD/52Q1ZsZlrY5GLVHfpOKTUFGo9dz/4riTFYuyuFG34mGHYow4cq
         oia8WOVzpWXy8bkKp44axNGjUkXCvscVsRdmo=
Received: by 10.100.125.1 with SMTP id x1mr13356243anc.82.1294188479635;
        Tue, 04 Jan 2011 16:47:59 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id d4sm285991and.19.2011.01.04.16.47.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 16:47:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D238EDC.9000503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164534>

On 1/4/2011 3:19 PM, Neal Kreitzinger wrote:
> On 1/4/2011 1:01 PM, Hans-Christoph Steiner wrote:
>>
>> On Dec 13, 2010, at 11:16 AM, Neal Kreitzinger wrote:
>>
>>> "Hans-Christoph Steiner" <hans@at.or.at> wrote in message
>>> news:7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at...
>>>>
>>>> Hey all,
>>>>
>>>> (and my second post on this list...)
>>>>
>>>> I've gotten pretty good at git, and its helping me already with
>>>> managing
>>>> the very odd workflows I have with the software I work a lot on
>>>> called Pd
>>>> (http://puredata.info). My role in Pd development is like a Linux
>>>> lieutenant.
>>>>
>>>> I also the main dev for an app called Pd-extended, which is based on
>>>> Pd.
>>>> Now I'm stuck trying to figure out how to use git to match my current
>>>> workflow for Pd-extended, which is a kind of long-lived branch, almost
>>>> like a friendly fork. So its kind of close to the Linux workflow
>>>> with me
>>>> as a lieutenant, but not quite.
>>>>
>>>> What makes it tricky is that I make releases directly from my repo that
>>>> are widely used. So my repo is both lieutenant and dictator at the same
>>>> time. So that's where I am stumped. I want to be able to rebase and
>>>> push to a public repo, but that would be stupid. So there has got to be
>>>> another way.
>>>>
>>>> .hc
>>>>
>>> I don't think pushing to a public repo is stupid. You could create a
>>> bare
>>> repo with a Pd branch and Pd-extended branch that contain the production
>>> versions of Pd and Pd-extended. The main reason our shop chose git is
>>> because it allows us to easily have multiple concurrent versions of
>>> production by having a branch for each of our custom versions. These
>>> versions eventually get merged together into a major release, but in the
>>> meantime they are longlived branches representing the productional
>>> customized system for each major customer.
>>>
>>> *If* you end up merging Pd and Pd-extended at some point, then you could
>>> have another branch for that, e.g. master or Pd-master or whatever. BTW,
>>> you do not have to use master as the representative of your final merged
>>> work so don't think that is the way you HAVE to do it. It's just the
>>> default, and a common practice for systems with a single version of
>>> production. Master can become vestigial or secondary, if you choose to
>>> create a new branch called Pd-master, etc. to represent your eventual
>>> merges
>>> of Pd and Pd-extended.
>>
>>
>> For me the biggest feature that I am looking for is the automatic
>> merging of commits, and second, having a branch that puts my collection
>> of patches/commits ahead of the Pd master so that its easy to manage the
>> patches. I don't think I see how I could do that with this multiple
>> branches idea. Is that possible?
>>
>
> I have _no_ experience using patches (in git or otherwise) to manage
> change control, ie. git-am, git-format-patch, etc., as of yet...
>
> That being said, FWIW, here is a suggestion based on the following
> assumptions:
>
> a. It sounds like Pd and Pd-extended only get merged once-in-a-while
> (infrequently).
> b. Pd is the main version in use, and Pd-extended is a future version or
> a not-yet-widely-used version.
> c. Pd-extended is based on Pd, but since the inception of Pd-extended
> both Pd and Pd-extended have advanced (diverged).
>
>
> Assuming that is the case, this is similar to what our shop does. We
> have a production system X12 and a new system X13 that is based on X12.
> Periodically, bugfixes and enhancements from X12 need to be merged into
> X13. Here's how we do it:
>
> 1. Identify the range of commits in X12 that are not yet in X13 (new X12
> commits since the last X12-X13 merge):
> $ git log
> sha1-of-last-X12-commit-alreadyMERGED-into-X13..sha1-of-newest-X12-commit-you-want-MERGED-into-X13
> --format="%h%d %s"
>  >/somepath/whereIkeepstuff/X12-X13-MRG.01-REBASE-TO-DO.lst
> 2. Identify any commits in the X12 commits that you do not want merged
> into X13.
> 3. Create a throw-away-integration-branch which is a copy of X12:
> $ git checkout X12
> $ git branch X12-Squash
> 4. Create a throw-away-integration-branch which is a copy of X13:
> $ git checkout X13
> $ git branch X13-Merge-X12 <-------corrected typo here
> 5. Squash the X12 merge series into a single commit:
> $ git checkout X12-Squash
> $ git reset --hard sha1-of-newest-X12-commit-you-want-MERGED-into-X13
> (in case its not the head commit of the branch)
> $ git rebase -i sha1-of-last-X12-commit-alreadyMERGED-into-X13
> (interactive rebase to squash the X12 "new commits" series)
> #comment out any commits that you don't want in X13, if applicable.
> put an "s" next to all the other commits to squash them.
> 6. Cherry pick the X12 squashed commit onto X13:
> $ git checkout X13-Merge-X12
> $ git cherry-pick --edit X12-Squash
> resolve any conflicts
> review what got merged automatically and make sure its right (git
> doesn't know about conflicts in logic)
> 7. Merge results into real X13:
> $ git checkout X13
> $ git merge --ff-only X13-Merge-X12
> 8. Create a test copy of the bare repo of X13:
> $ cp -rvp X13.git QA-X13.git
> 9. Push to QA copy of X13 repo: (make sure your push results are ok)
> $ git push QA-X13-remotename HEAD
> review in gitk, etc. to verify it is correct
> 10. Push to real X13 repo:
> $ git push X13-remotename HEAD
> review results
> notify others of update.
>
> Note: you can have X12 and X13 in separate bare repos if you want, or as
> branches in a single bare repo. If X12 and X13 are in separate bare
> repos, then you can use an 'integration manager' repo to remote to them
> and pull their changes into integration branches. That's actually how
> our shop currently does it because the X13 people do not maintain X12.
> The steps above are for a single bare repo in order to save on the
> number of steps in the example.
>
> Hope this helps. If my assumptions are incorrect then we might have
> other merge techniques that may be applicable...

see note on corrected typo above!

v/r,
Neal
