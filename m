From: Jared Davison <jared@medical-objects.com.au>
Subject: Re: Issue with git submodule update --init --depth=1 submodA
Date: Thu, 24 Mar 2016 16:21:21 +1000
Message-ID: <CAECUmHpE1KJYK5758+VeiXa3nZa-_rOyJD3RwsD9pJ9uQS9_0A@mail.gmail.com>
References: <CAECUmHo8Q=N_rTP7NnYaQJ24g9SVrgCmpq1NHVXe1icD6xn7vw@mail.gmail.com>
 <CAGZ79kaTACBvBNwAumK035fWG8qooh31JpoooyUmGZEL+4mpOg@mail.gmail.com> <CAECUmHq-NVZ5NVuMaTm_1mLjbE4wAMCDnFHrcGHdKoCGDL1E2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ed046a707d5052ec57573
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 07:21:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiyeR-0000sm-TW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 07:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbcCXGVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 02:21:44 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35577 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbcCXGVm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 02:21:42 -0400
Received: by mail-vk0-f49.google.com with SMTP id e6so46986302vkh.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=momail-medical-objects-com-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZNqz4w8iu5nqSUcozPYRSkIRJ6W7+WlRUY7AAHzLx0Q=;
        b=n4O+Tk2p9P7hr4bIYcrZtVgKCtVjwNfC0bTIkm6BZO5FRcIXI6EdapzVuQYdyTTDRX
         C7UDIoUGxSKmJKXBDTaH5vHRFqNicac9nfyCycXzMYn/WtYMHiFreFnrVkRHSMfak5xF
         kxc+K9qd9Z0uSdqhCui7raTOZqJKBDheArR3AI3riRAKFc3skNbxAcL6inT1FuZix8xN
         62gW9u8MTDb28BSBE2lgKxycqtR2meGh/yrj2B42hjYxG9X1mDSy/JRtG3nR5PrE5zhP
         GV3JJKE5b7Nsz5UBL7cEaWj46uIMA6CxJKE2vfUcZ5BVtj8HtNVS6Qig8dK2TGnRAGo9
         IkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZNqz4w8iu5nqSUcozPYRSkIRJ6W7+WlRUY7AAHzLx0Q=;
        b=lWMk1dlNNh30aSxfj7Gd+58iVmzUlgx84VuMZatmeB/G+kZBZcmJ2Y6YqB8Cy+3dtB
         Y3xDdMPYFTMyiHu+A3+Tc05LRb1UFP3Dg+ohVJxEsiG6LL7iWIqHEViLCd0VUNCGa9XY
         yJGz6NCCDI5uSJTe2lj0xT267fc3EBKIWLJz8bAJRoP9EslroyLY4JNPXuNOFVslvUPj
         y+xHKrPprlbOmV/ZyV89rqwzwyrpMm0HyWUAWX0q8iKswyZy3Y6fpo6pPK02vlNZPyTI
         bxWir+/2i5yrRrjrUyfh0REeLc44SE0cAZ90k7MybUPnIsL6x4Dyem103HlJdO8bdMZC
         FfCg==
X-Gm-Message-State: AD7BkJKP9HnlyzF/t6fU/bBZ/vMZP8SL/tVWQdXTT6fW3X7x2eiPuoqmcdkXtBc2It2lHwrO3A1IIqFRXVxi8Q==
X-Received: by 10.176.2.53 with SMTP id 50mr3559265uas.13.1458800500848; Wed,
 23 Mar 2016 23:21:40 -0700 (PDT)
Received: by 10.31.96.19 with HTTP; Wed, 23 Mar 2016 23:21:21 -0700 (PDT)
In-Reply-To: <CAECUmHq-NVZ5NVuMaTm_1mLjbE4wAMCDnFHrcGHdKoCGDL1E2g@mail.gmail.com>
X-Google-Sender-Auth: aKzyiKj45ePZJm0UYdKJPCrlPAc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289712>

--001a113ed046a707d5052ec57573
Content-Type: text/plain; charset=UTF-8

Hi Stefan and all,

I think I may have found the answer to the question in the previous email.

http://stackoverflow.com/questions/14872486/retrieve-specific-commit-from-a-remote-git-repository

I have had success getting the submodule update --depth=1 command to
run, but it didn't do what I expected.

To get past my the "Direct fetching of that commit failed" I had to
issue the following command on the remote submodule repo.

$git config uploadpack.allowReachableSHA1InWant true

I just need to verify it gave me the correct result in terms of not
downloading everything...

This is what happens now...

~/parent-repo$ git submodule update --init --depth=1 submoduleA
Submodule 'submoduleA' (file:///home/jared/submoduleA/.git) registered
for path 'submoduleA'
Cloning into 'submoduleA'...
remote: Counting objects: 764, done.
remote: Compressing objects: 100% (301/301), done.
remote: Total 764 (delta 460), reused 762 (delta 458)
Receiving objects: 100% (764/764), 191.95 MiB | 46.80 MiB/s, done.
Resolving deltas: 100% (460/460), completed with 6 local objects.
From file:///home/jared/submoduleA/
 * branch            8a1c22151b510160d7b41a019d7642ab2cd5e085 -> FETCH_HEAD
Submodule path 'submoduleA': checked out
'8a1c22151b510160d7b41a019d7642ab2cd5e085'


However, it has downloaded much more than I expect, 191MB as above.

If I use the method below as mentioned in the stackoverflow article, I
do get the type of outcome I am looking for in terms of fetch, except
I want this to with the submodules.

jared@ubuntu:~/newrepo$ git init
Initialized empty Git repository in /home/jared/newrepo/.git/
jared@ubuntu:~/newrepo$ git fetch --depth=1
file:///home/jared/submoduleA/.git
8a1c22151b510160d7b41a019d7642ab2cd5e085
remote: Counting objects: 16, done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 16 (delta 0), reused 15 (delta 0)
Unpacking objects: 100% (16/16), done.
From file:///home/jared/submoduleA/
 * branch            8a1c22151b510160d7b41a019d7642ab2cd5e085 -> FETCH_HEAD

jared@ubuntu:~/newrepo$ git checkout 8a1c22151b510160d7b41a019d7642ab2cd5e085
Note: checking out '8a1c22151b510160d7b41a019d7642ab2cd5e085'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 8a1c221... <test commit comment>

jared@ubuntu:~/newrepo$ du -h
44K ./.git/hooks
8.0K ./.git/logs
8.0K ./.git/info
8.0K ./.git/objects/bb
8.0K ./.git/objects/54
8.0K ./.git/objects/79
8.0K ./.git/objects/c1
8.0K ./.git/objects/b7
8.0K ./.git/objects/c0
8.0K ./.git/objects/f4
8.0K ./.git/objects/ca
4.0K ./.git/objects/pack
4.0K ./.git/objects/info
896K ./.git/objects/dc
8.0K ./.git/objects/8a
1.4M ./.git/objects/ec
548K ./.git/objects/c7
8.0K ./.git/objects/4b
3.0M ./.git/objects/c8
8.0K ./.git/objects/eb
12K ./.git/objects/5f
5.9M ./.git/objects
4.0K ./.git/branches
4.0K ./.git/refs/heads
4.0K ./.git/refs/tags
12K ./.git/refs
6.0M ./.git
16K ./js
25M .


I've had a go at patching the git-submodule.sh code further to achieve
the result I'm seeking and it seems to work for me. Can you see a
problem with this?


jared@ubuntu:~/parent-repo$ git submodule update --init --depth=1 submoduleA
Submodule 'submoduleA' (file:///home/jared/submoduleA/.git) registered
for path 'submoduleA'
Cloning into 'submoduleA'...
remote: Total 0 (delta 0), reused 0 (delta 0)
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 3 (delta 1)
Unpacking objects: 100% (3/3), done.
From file:///home/jared/submoduleA/
 * branch            8a1c22151b510160d7b41a019d7642ab2cd5e085 -> FETCH_HEAD
Submodule path 'submoduleA': checked out
'8a1c22151b510160d7b41a019d7642ab2cd5e085'

As you can see the number of objects is relatively small.

jared@ubuntu:~/parent-repo$ du -h .git/modules/submoduleA/
44K .git/modules/submoduleA/hooks
8.0K .git/modules/submoduleA/logs/refs/heads
8.0K .git/modules/submoduleA/logs/refs/remotes/origin
12K .git/modules/submoduleA/logs/refs/remotes
24K .git/modules/submoduleA/logs/refs
32K .git/modules/submoduleA/logs
8.0K .git/modules/submoduleA/info
8.0K .git/modules/submoduleA/objects/b7
5.0M .git/modules/submoduleA/objects/pack
4.0K .git/modules/submoduleA/objects/info
8.0K .git/modules/submoduleA/objects/8a
1.4M .git/modules/submoduleA/objects/ec
6.4M .git/modules/submoduleA/objects
4.0K .git/modules/submoduleA/branches
8.0K .git/modules/submoduleA/refs/heads
8.0K .git/modules/submoduleA/refs/remotes/origin
12K .git/modules/submoduleA/refs/remotes
4.0K .git/modules/submoduleA/refs/tags
28K .git/modules/submoduleA/refs
6.6M .git/modules/submoduleA/


It is even smaller than before, for some reason. I'm not sure why,
maybe less was fetched?

I've done a diff -rq on the files in the submodule working folder with
and without the --depth parameter and it gives the same result. So it
seems good to me. I may be missing something, if so can you please let
me know, I'd be happy to refine further.

Here's the patch inline but it is also attached also to preserve
formatting in case the email breaks it:

diff --git a/git-submodule.sh b/git-submodule.sh
index cd749f4..2e5c918 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -610,12 +610,13 @@ is_tip_reachable () (

 fetch_in_submodule () (
  sanitize_submodule_env &&
+ depth=$3
  cd "$1" &&
  case "$2" in
  '')
- git fetch ;;
+ git fetch $depth ;;
  *)
- git fetch $(get_default_remote) "$2" ;;
+ git fetch $depth $(get_default_remote) "$2" ;;
  esac
 )

@@ -769,13 +770,13 @@ cmd_update()
  # Run fetch only if $sha1 isn't present or it
  # is not reachable from a ref.
  is_tip_reachable "$sm_path" "$sha1" ||
- fetch_in_submodule "$sm_path" ||
+ fetch_in_submodule "$sm_path" "" "$depth" ||
  die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"

  # Now we tried the usual fetch, but $sha1 may
  # not be reachable from any of the refs
  is_tip_reachable "$sm_path" "$sha1" ||
- fetch_in_submodule "$sm_path" "$sha1" ||
+ fetch_in_submodule "$sm_path" "$sha1" "$depth" ||
  die "$(eval_gettext "Fetched in submodule path '\$displaypath', but
it did not contain $sha1. Direct fetching of that commit failed.")"
  fi



Thanks,

Jared

On Thu, Mar 24, 2016 at 4:17 PM, Jared Davison
<jared@medical-objects.com.au> wrote:
> Hello Stefan,
>
> Thank you for your very complete response to the various aspects of my
> email. It is much appreciated, and it is good to be part of a
> community that is so helpful!
>
> I wasn't aware of your recent work and commit so thank you, I've been
> able to read the diffs to your commit and learn more about how it
> works.
> https://github.com/git/git/commit/fb43e31f2b43076e7a30c9cd00d0241cb8cf97eb.
>
> On Thu, Mar 24, 2016 at 3:19 AM, Stefan Beller <sbeller@google.com> wrote:
>> This is somewhat expected. The depth argument tells Git to cut off the commit
>> graph such that there is only 1 commit, the rest should not be there.
>> If you reference a commit in the missing rest, you have an issue as that commit
>> cannot be found.
>>
>> As a workaround we try to fetch the missing sha1 if the remote allows it.
>> (You remote doesn't, so "Direct fetching of that commit failed.")
>
> This sounds very promising, and sounds exactly what I'm looking for in
> my scenario, as I only need that exact commit and no history either
> side of it (well of course I need all the files from the parents that
> made up). (I'm going to use the files and then delete them.)
>
> In my situation I manage the remote as well, so this must be possible
> if I can make the remote allow direct fetching by sha1.
>
> Can you please tell me how can I make the remote allow direct
> fetching? Is it a repo config, or is it a software version, or a
> protocol version, or something else?
>
> I found some discussion here but not answer to my question:
> http://comments.gmane.org/gmane.comp.version-control.git/257807
>
>
>>> Does depth always have to be counted from the head or most recent
>>> commit in the submodule branch?
>>
>> The way it currently works, it is always counted from the most recent commit
>> in the branch.
>>
>>>
>>> Could depth be counted from the required commit reference by the
>>> parent repo instead of the most recent? If so then --depth=1 could
>>> work I think.
>>
>> That sounds interesting. :)
>> But it may get confusing fast:
>
> Yes agreed! I'm sure there was a better way.
>
>> * Which reference commit do you mean in the parent? (The topmost commit
>>   I would assume?)
>
> I meant the parents reference to the submodule commit id.
>
>> * Up to now the submodule is a self sufficient repository, i.e. it doesn't need
>>   to know about the parent project and could still work great as a standalone
>>   repository. By making depth dependent on the parent project, would there be
>>   a difference in
>>     cd <submodule> && git fetch --depth 12
>>   and
>>     git submodule update --depth 12 <submodule>
>>   ?
>>
>
> I agree. That is very reasonable as is.
>
>> I thought about adding a new commandline flag instead of overloading depth.
>> --submodule-enclosure=<n> or such to mean "get all commits the parent is
>> referencing in its topmost <n> commits".
>>
>
> That might be a possibility, but I'm not sure of the use case. For my
> case, I only need to get the exact commit of the submodule required,
> so I can checkout all the files it represents without having objects
> representing old history fetched or stored, similar to what --depth=1
> does when the commit I want is the most recent.
>
>>>
>>> The reason I would like to do this is that the history actually
>>> contains some fairly large files and I wish to clone only the history
>>> for the current version of the files in that most recent commit. This
>>> all works great until someone pushes a commit into the submodule. I am
>>> using this as part of a continuous integration process which will
>>> build branches that reference submodules where the referenced commit
>>> may go back a long way back in history.
>>>
>>> Trying to determine the correct depth parameter value to use is
>>> impossible as with time it will be a growing amount as commits are
>>> added to the submodule branch.
>>
>> Yeah you would rather want a --since=<sha1-or-tag> instead of a --depth
>> argument I'd assume?
>>
>
> I'm not sure. Possibly not as in my case I'm not interested in newer
> versions or older either, just the exact version required.
>
> If you could please answer my question on how to make the server allow
> fetching by commit sha1 that would resolve the issue for me I think.
>
> Thanks again,
>
> Jared
>
> On Thu, Mar 24, 2016 at 3:19 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Mar 23, 2016 at 1:28 AM, Jared Davison
>> <jared@medical-objects.com.au> wrote:
>>> Hello all,
>>>
>>> I have encountered a problem with using submodules.
>>>
>>> The problem occurs when using
>>>
>>> repo-parent$ git submodule update --init --depth=1 submodA
>>>
>>> Submodule 'submoduleA' (.../submoduleA.git) registered for path 'submoduleA'
>>> Cloning into 'submoduleA'...
>>> Fetched in submodule path 'submoduleA', but it did not contain
>>> 8a1c22151b510160d7b41a019d7642ab2cd5e085. Direct fetching of that
>>> commit failed.
>>>
>>> Note the --depth=1 argument.
>>
>> This is somewhat expected. The depth argument tells Git to cut off the commit
>> graph such that there is only 1 commit, the rest should not be there.
>> If you reference a commit in the missing rest, you have an issue as that commit
>> cannot be found.
>>
>> As a workaround we try to fetch the missing sha1 if the remote allows it.
>> (You remote doesn't, so "Direct fetching of that commit failed.")
>>
>>>
>>> This all works fine if the head of the submodA master branch is the
>>> revision required by the repo-parent as shown in "git submodule list"
>>>
>>> However, if submodA's history has progressed by one commit, then
>>> --depth=2 is required and this works fine. --depth=1 will no longer
>>> work and gives the error as above.
>>>
>>> Does depth always have to be counted from the head or most recent
>>> commit in the submodule branch?
>>
>> The way it currently works, it is always counted from the most recent commit
>> in the branch.
>>
>>>
>>> Could depth be counted from the required commit reference by the
>>> parent repo instead of the most recent? If so then --depth=1 could
>>> work I think.
>>
>> That sounds interesting. :)
>> But it may get confusing fast:
>> * Which reference commit do you mean in the parent? (The topmost commit
>>   I would assume?)
>> * Up to now the submodule is a self sufficient repository, i.e. it doesn't need
>>   to know about the parent project and could still work great as a standalone
>>   repository. By making depth dependent on the parent project, would there be
>>   a difference in
>>     cd <submodule> && git fetch --depth 12
>>   and
>>     git submodule update --depth 12 <submodule>
>>   ?
>>
>> I thought about adding a new commandline flag instead of overloading depth.
>> --submodule-enclosure=<n> or such to mean "get all commits the parent is
>> referencing in its topmost <n> commits".
>>
>>>
>>> The reason I would like to do this is that the history actually
>>> contains some fairly large files and I wish to clone only the history
>>> for the current version of the files in that most recent commit. This
>>> all works great until someone pushes a commit into the submodule. I am
>>> using this as part of a continuous integration process which will
>>> build branches that reference submodules where the referenced commit
>>> may go back a long way back in history.
>>>
>>> Trying to determine the correct depth parameter value to use is
>>> impossible as with time it will be a growing amount as commits are
>>> added to the submodule branch.
>>
>> Yeah you would rather want a --since=<sha1-or-tag> instead of a --depth
>> argument I'd assume?
>>
>>>
>>> Another user found the same issue:  http://stackoverflow.com/a/25875273
>>>
>>> I have just compiled the git from "next" branch source, "git version
>>> 2.8.0.rc4.233.g1aaf96d" and have confirmed this is still the
>>> behaviour.
>>>
>>> Thanks for reading my enquiry and for your thoughts on this topic.
>>>
>>> Jared
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a113ed046a707d5052ec57573
Content-Type: text/plain; charset=US-ASCII; name="patch.txt"
Content-Disposition: attachment; filename="patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_im5w4msk0

ZGlmZiAtLWdpdCBhL2dpdC1zdWJtb2R1bGUuc2ggYi9naXQtc3VibW9kdWxlLnNoCmluZGV4IGNk
NzQ5ZjQuLjJlNWM5MTggMTAwNzU1Ci0tLSBhL2dpdC1zdWJtb2R1bGUuc2gKKysrIGIvZ2l0LXN1
Ym1vZHVsZS5zaApAQCAtNjEwLDEyICs2MTAsMTMgQEAgaXNfdGlwX3JlYWNoYWJsZSAoKSAoCiAK
IGZldGNoX2luX3N1Ym1vZHVsZSAoKSAoCiAJc2FuaXRpemVfc3VibW9kdWxlX2VudiAmJgorCWRl
cHRoPSQzCiAJY2QgIiQxIiAmJgogCWNhc2UgIiQyIiBpbgogCScnKQotCQlnaXQgZmV0Y2ggOzsK
KwkJZ2l0IGZldGNoICRkZXB0aCA7OwogCSopCi0JCWdpdCBmZXRjaCAkKGdldF9kZWZhdWx0X3Jl
bW90ZSkgIiQyIiA7OworCQlnaXQgZmV0Y2ggJGRlcHRoICQoZ2V0X2RlZmF1bHRfcmVtb3RlKSAi
JDIiIDs7CiAJZXNhYwogKQogCkBAIC03NjksMTMgKzc3MCwxMyBAQCBjbWRfdXBkYXRlKCkKIAkJ
CQkjIFJ1biBmZXRjaCBvbmx5IGlmICRzaGExIGlzbid0IHByZXNlbnQgb3IgaXQKIAkJCQkjIGlz
IG5vdCByZWFjaGFibGUgZnJvbSBhIHJlZi4KIAkJCQlpc190aXBfcmVhY2hhYmxlICIkc21fcGF0
aCIgIiRzaGExIiB8fAotCQkJCWZldGNoX2luX3N1Ym1vZHVsZSAiJHNtX3BhdGgiIHx8CisJCQkJ
ZmV0Y2hfaW5fc3VibW9kdWxlICIkc21fcGF0aCIgIiIgIiRkZXB0aCIgfHwKIAkJCQlkaWUgIiQo
ZXZhbF9nZXR0ZXh0ICJVbmFibGUgdG8gZmV0Y2ggaW4gc3VibW9kdWxlIHBhdGggJ1wkZGlzcGxh
eXBhdGgnIikiCiAKIAkJCQkjIE5vdyB3ZSB0cmllZCB0aGUgdXN1YWwgZmV0Y2gsIGJ1dCAkc2hh
MSBtYXkKIAkJCQkjIG5vdCBiZSByZWFjaGFibGUgZnJvbSBhbnkgb2YgdGhlIHJlZnMKIAkJCQlp
c190aXBfcmVhY2hhYmxlICIkc21fcGF0aCIgIiRzaGExIiB8fAotCQkJCWZldGNoX2luX3N1Ym1v
ZHVsZSAiJHNtX3BhdGgiICIkc2hhMSIgfHwKKwkJCQlmZXRjaF9pbl9zdWJtb2R1bGUgIiRzbV9w
YXRoIiAiJHNoYTEiICIkZGVwdGgiIHx8CiAJCQkJZGllICIkKGV2YWxfZ2V0dGV4dCAiRmV0Y2hl
ZCBpbiBzdWJtb2R1bGUgcGF0aCAnXCRkaXNwbGF5cGF0aCcsIGJ1dCBpdCBkaWQgbm90IGNvbnRh
aW4gJHNoYTEuIERpcmVjdCBmZXRjaGluZyBvZiB0aGF0IGNvbW1pdCBmYWlsZWQuIikiCiAJCQlm
aQogCg==
--001a113ed046a707d5052ec57573--
