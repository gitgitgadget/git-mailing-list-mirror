From: Jared Davison <jared@medical-objects.com.au>
Subject: Re: Issue with git submodule update --init --depth=1 submodA
Date: Thu, 24 Mar 2016 16:17:48 +1000
Message-ID: <CAECUmHq-NVZ5NVuMaTm_1mLjbE4wAMCDnFHrcGHdKoCGDL1E2g@mail.gmail.com>
References: <CAECUmHo8Q=N_rTP7NnYaQJ24g9SVrgCmpq1NHVXe1icD6xn7vw@mail.gmail.com>
 <CAGZ79kaTACBvBNwAumK035fWG8qooh31JpoooyUmGZEL+4mpOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 07:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiybM-00078L-9c
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 07:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbcCXGSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 02:18:12 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35375 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbcCXGSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 02:18:09 -0400
Received: by mail-vk0-f47.google.com with SMTP id e6so46919807vkh.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 23:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=momail-medical-objects-com-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UN8ePvJcttmCaWhn2URv9b39jvARF5cOg+wY5mWJRi0=;
        b=DwAiT1QlfpBrWS2dLfyhnOmFIfz4xuM8WfHxirYQtRmVFKurSAGw6iUz3Fucw6XQ1J
         u2qnGNx/PlDhzBOySZqoySC8QRBjRlq6T4kfgKE9DOYLeHym9pLHeyDaOMv9Z8d9jd7O
         vnt7HMLijC+0imrB6koLoIJdJdy3NR36QjVjfeVRzdT4/mpPwmkf2J5OEi3305g8MT7f
         PH+TjXeRc6sKK8LQjyItdcHc62FPMCmsJqKdinic+ZE0CbJbQ+sSiCPyk5eoM+QZNwFO
         lD1wNsQ6Hl3w8zzE10nwy5mhLnfc9Y65R1entIJeQHwdjZ5qw0PzRYzV82z3TY7EJyQ/
         gw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UN8ePvJcttmCaWhn2URv9b39jvARF5cOg+wY5mWJRi0=;
        b=jdgmryk3rq4r4EFZTIeRC2nBs8sJiBNQrqgslnaNrqMQOydhbowAbMH4NcCDU/Lj+g
         onQn+74qg8GJEpTZidiMVU5+EGOAjReQiyTrEO7fUZbQSEpJFNxRVbeU0Mi7lUHL7owV
         F8p6ByNbcQBA1eHBDyG3WKUYvt39jTE/EGvdYZi+5oLIP5zzQKaUL46iZsCXegoQGlBT
         LaQEpfvOipQ2rXjKA9EyW4WB8A9WHXbWEwHRKzF4jYiMT9+GtpEuok8VH/XBTO5Im+Y9
         haHCmvX7qowezYejuwWyZ1meLOTIrgxSDV15KQbMc9vwjx2bDeUl25v9KYZ6m3Tvsusl
         Z4+A==
X-Gm-Message-State: AD7BkJLsfffQXXMjLanaUS5vSznp+MyDa4Eam2RyW8BDQjBujBMDZet+bGeDaW7eHmX1Dpq3ghlZDg7K1hDCEQ==
X-Received: by 10.176.2.231 with SMTP id 94mr3056099uah.106.1458800288204;
 Wed, 23 Mar 2016 23:18:08 -0700 (PDT)
Received: by 10.31.96.19 with HTTP; Wed, 23 Mar 2016 23:17:48 -0700 (PDT)
In-Reply-To: <CAGZ79kaTACBvBNwAumK035fWG8qooh31JpoooyUmGZEL+4mpOg@mail.gmail.com>
X-Google-Sender-Auth: ajztB6udVzG4MhmvFahs_AmkL0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289711>

Hello Stefan,

Thank you for your very complete response to the various aspects of my
email. It is much appreciated, and it is good to be part of a
community that is so helpful!

I wasn't aware of your recent work and commit so thank you, I've been
able to read the diffs to your commit and learn more about how it
works.
https://github.com/git/git/commit/fb43e31f2b43076e7a30c9cd00d0241cb8cf97eb.

On Thu, Mar 24, 2016 at 3:19 AM, Stefan Beller <sbeller@google.com> wrote:
> This is somewhat expected. The depth argument tells Git to cut off the commit
> graph such that there is only 1 commit, the rest should not be there.
> If you reference a commit in the missing rest, you have an issue as that commit
> cannot be found.
>
> As a workaround we try to fetch the missing sha1 if the remote allows it.
> (You remote doesn't, so "Direct fetching of that commit failed.")

This sounds very promising, and sounds exactly what I'm looking for in
my scenario, as I only need that exact commit and no history either
side of it (well of course I need all the files from the parents that
made up). (I'm going to use the files and then delete them.)

In my situation I manage the remote as well, so this must be possible
if I can make the remote allow direct fetching by sha1.

Can you please tell me how can I make the remote allow direct
fetching? Is it a repo config, or is it a software version, or a
protocol version, or something else?

I found some discussion here but not answer to my question:
http://comments.gmane.org/gmane.comp.version-control.git/257807


>> Does depth always have to be counted from the head or most recent
>> commit in the submodule branch?
>
> The way it currently works, it is always counted from the most recent commit
> in the branch.
>
>>
>> Could depth be counted from the required commit reference by the
>> parent repo instead of the most recent? If so then --depth=1 could
>> work I think.
>
> That sounds interesting. :)
> But it may get confusing fast:

Yes agreed! I'm sure there was a better way.

> * Which reference commit do you mean in the parent? (The topmost commit
>   I would assume?)

I meant the parents reference to the submodule commit id.

> * Up to now the submodule is a self sufficient repository, i.e. it doesn't need
>   to know about the parent project and could still work great as a standalone
>   repository. By making depth dependent on the parent project, would there be
>   a difference in
>     cd <submodule> && git fetch --depth 12
>   and
>     git submodule update --depth 12 <submodule>
>   ?
>

I agree. That is very reasonable as is.

> I thought about adding a new commandline flag instead of overloading depth.
> --submodule-enclosure=<n> or such to mean "get all commits the parent is
> referencing in its topmost <n> commits".
>

That might be a possibility, but I'm not sure of the use case. For my
case, I only need to get the exact commit of the submodule required,
so I can checkout all the files it represents without having objects
representing old history fetched or stored, similar to what --depth=1
does when the commit I want is the most recent.

>>
>> The reason I would like to do this is that the history actually
>> contains some fairly large files and I wish to clone only the history
>> for the current version of the files in that most recent commit. This
>> all works great until someone pushes a commit into the submodule. I am
>> using this as part of a continuous integration process which will
>> build branches that reference submodules where the referenced commit
>> may go back a long way back in history.
>>
>> Trying to determine the correct depth parameter value to use is
>> impossible as with time it will be a growing amount as commits are
>> added to the submodule branch.
>
> Yeah you would rather want a --since=<sha1-or-tag> instead of a --depth
> argument I'd assume?
>

I'm not sure. Possibly not as in my case I'm not interested in newer
versions or older either, just the exact version required.

If you could please answer my question on how to make the server allow
fetching by commit sha1 that would resolve the issue for me I think.

Thanks again,

Jared

On Thu, Mar 24, 2016 at 3:19 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Mar 23, 2016 at 1:28 AM, Jared Davison
> <jared@medical-objects.com.au> wrote:
>> Hello all,
>>
>> I have encountered a problem with using submodules.
>>
>> The problem occurs when using
>>
>> repo-parent$ git submodule update --init --depth=1 submodA
>>
>> Submodule 'submoduleA' (.../submoduleA.git) registered for path 'submoduleA'
>> Cloning into 'submoduleA'...
>> Fetched in submodule path 'submoduleA', but it did not contain
>> 8a1c22151b510160d7b41a019d7642ab2cd5e085. Direct fetching of that
>> commit failed.
>>
>> Note the --depth=1 argument.
>
> This is somewhat expected. The depth argument tells Git to cut off the commit
> graph such that there is only 1 commit, the rest should not be there.
> If you reference a commit in the missing rest, you have an issue as that commit
> cannot be found.
>
> As a workaround we try to fetch the missing sha1 if the remote allows it.
> (You remote doesn't, so "Direct fetching of that commit failed.")
>
>>
>> This all works fine if the head of the submodA master branch is the
>> revision required by the repo-parent as shown in "git submodule list"
>>
>> However, if submodA's history has progressed by one commit, then
>> --depth=2 is required and this works fine. --depth=1 will no longer
>> work and gives the error as above.
>>
>> Does depth always have to be counted from the head or most recent
>> commit in the submodule branch?
>
> The way it currently works, it is always counted from the most recent commit
> in the branch.
>
>>
>> Could depth be counted from the required commit reference by the
>> parent repo instead of the most recent? If so then --depth=1 could
>> work I think.
>
> That sounds interesting. :)
> But it may get confusing fast:
> * Which reference commit do you mean in the parent? (The topmost commit
>   I would assume?)
> * Up to now the submodule is a self sufficient repository, i.e. it doesn't need
>   to know about the parent project and could still work great as a standalone
>   repository. By making depth dependent on the parent project, would there be
>   a difference in
>     cd <submodule> && git fetch --depth 12
>   and
>     git submodule update --depth 12 <submodule>
>   ?
>
> I thought about adding a new commandline flag instead of overloading depth.
> --submodule-enclosure=<n> or such to mean "get all commits the parent is
> referencing in its topmost <n> commits".
>
>>
>> The reason I would like to do this is that the history actually
>> contains some fairly large files and I wish to clone only the history
>> for the current version of the files in that most recent commit. This
>> all works great until someone pushes a commit into the submodule. I am
>> using this as part of a continuous integration process which will
>> build branches that reference submodules where the referenced commit
>> may go back a long way back in history.
>>
>> Trying to determine the correct depth parameter value to use is
>> impossible as with time it will be a growing amount as commits are
>> added to the submodule branch.
>
> Yeah you would rather want a --since=<sha1-or-tag> instead of a --depth
> argument I'd assume?
>
>>
>> Another user found the same issue:  http://stackoverflow.com/a/25875273
>>
>> I have just compiled the git from "next" branch source, "git version
>> 2.8.0.rc4.233.g1aaf96d" and have confirmed this is still the
>> behaviour.
>>
>> Thanks for reading my enquiry and for your thoughts on this topic.
>>
>> Jared
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Kind Regards
Jared Davison
Chief Information Officer
----------
Medical-Objects Pty Ltd
http://www.medical-objects.com.au
Wiki: http://wiki.medical-objects.com.au/
Phone: (07) 5456 6000
Fax: (07) 3221 0220

"Australia's Fastest Secure Messaging"

Please read our Policy Privacy Policy on how we manage the personal
information that we collect, use and disclose and how to contact us if
you have any questions about the management of your personal
information.

http://www.medical-objects.com.au/privacy/
