From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 Question
Date: Tue, 21 Apr 2015 17:53:37 +0100
Message-ID: <CAE5ih79L+RU934OYsBrXjP7PAoDYbeBS01hCgsOm+pnFD+dWwQ@mail.gmail.com>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
	<553552FD.80703@diamand.org>
	<CAFcBi89pXTKzeVkB5EN3ZYkLwa1oPfDOqdHHhHeVogswhnpOAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: FusionX86 <fusionx86@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 18:53:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkbQd-0001mo-I0
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 18:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbbDUQxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 12:53:38 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36095 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbbDUQxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 12:53:37 -0400
Received: by oift201 with SMTP id t201so159257943oif.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NZb8Akb7LKESqlS8nqnXp65yKJMv4hVtyMT0CPS8yTo=;
        b=UG87dwF4GgScSfxGIYnLmlClMjMfNClxf/Lwvsilff/ZjRExrnhE8C9cwvixyJefkJ
         HBWv0RqE/LCqKWfr/2U1Fdwe56UVFd9YY8brUI4Mn8v25j422XdpJoohXNl6oaIFJ2s8
         /euMHvZSX304EybKYZvXw27Uh00QePp4K9ghc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NZb8Akb7LKESqlS8nqnXp65yKJMv4hVtyMT0CPS8yTo=;
        b=eyDqcTsItVpSd8eJtylFqrGsx03MmORh4+N9GKcUxc7iYqwg1nqQOhIckS2OQskTRg
         2omolYP942CedQ1pz4ejTLu2h4m3/z07anelYaMwZqMhCk5CyfsRQd3i/ZGsKUc9z+XJ
         8jtIAaG6FXIyN8dTZgSF1l40tkDy9tfVDrqhoWklyFPXuZh8DNkWnc52LKOcDqmbT0u+
         WTg8iyaKAQt3kckk3lUHQR2JoCrpLlMo08a3vs/m+JLfKqXKEQISLXoo1RL+ZcMhBBJ8
         JGZFNfWyVU2dx2Kd4MkynG5w/nfzT/myfOgwEcAmv7baSRZ6YbD0UdFlj/cDkd/uyuuf
         wVxw==
X-Gm-Message-State: ALoCoQmiArbxALTZ42rtYsxjDbEfMEyc3IM+tdDcMVME8KPUbU3ApGvVFDFks1FwBoWeKB9C4p5M
X-Received: by 10.202.198.149 with SMTP id w143mr18834891oif.72.1429635217264;
 Tue, 21 Apr 2015 09:53:37 -0700 (PDT)
Received: by 10.60.59.167 with HTTP; Tue, 21 Apr 2015 09:53:37 -0700 (PDT)
In-Reply-To: <CAFcBi89pXTKzeVkB5EN3ZYkLwa1oPfDOqdHHhHeVogswhnpOAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267531>

Can you post up the output from 'git p4 clone', and also see what the
output from doing this is:

$ p4 print //depot/some/branch/missingfile.c



On 21 April 2015 at 14:33, FusionX86 <fusionx86@gmail.com> wrote:
> Hi Luke,
>
> Using -v was a good suggestion. Unfortunately I still don't see what
> the problem is. I'm starting to think that maybe I should just create
> the client views I need and setup a cron job that p4 syncs and then
> git commits/pushes.
>
> The --preserve-user option is for submitting back to Perforce correct?
> I'm hoping to get away with a one-way sync from Perforce to Git...and
> then eventually just cut over to Git.
>
> I also looked at git fusion, but unfortunately the version of Perforce
> we're running (2012.1) doesn't meet the requirements for fusion. I
> wish it did.
>
> Good point on developer mindset. I think we definitely have some
> training and habit changing in the future.
>
> Thanks for the suggestions and pointers, it's much appreciated.
>
> On Mon, Apr 20, 2015 at 1:26 PM, Luke Diamand <luke@diamand.org> wrote:
>> On 20/04/15 17:41, FusionX86 wrote:
>>>
>>> Hello,
>>>
>>> Hopefully this is an appropriate place to ask questions about git-p4.
>>>
>>> I started at a company that wants to migrate from Perforce to Git. I'm
>>> new to Perforce and have been trying to learn just enough about it to
>>> get through this migration. Anyway, I've been playing with git-p4 and
>>> have one question/problem to discuss.
>>>
>>> After setting up the p4 cli client I can 'p4 sync' some
>>> //depot/main/app1 which pulls down the files I would expect from the
>>> Perforce server. If I use 'git p4 clone //depot/main/app1', I get:
>>>
>>> "Doing initial import of //depot/main/app1/ from revision #head into
>>> refs/remotes/p4/master"
>>>
>>> But I don't get any files from that depot/folder pulled down. I can
>>> git p4 clone other depot/folders though and get some files. I suspect
>>> that I'm just not understanding how the git-p4 module works.
>>
>>
>> You could try doing the clone with '-v' to get a bit more information.
>>
>>>
>>> Basically, I'm hoping to setup a live sync of Perforce to Git of
>>> certain depots in preparation for the migration. Also, if anyone has
>>> pointers or guides for this type of migration, any help is
>>> appreciated.
>>
>>
>> I've done something similar in the past. You'll want to enable the
>> --preserve-user option, for which you will need admin rights.
>>
>> If it's a one-way mirror (p4-to-git) then just run git-p4 periodically (if
>> you use cron, then try to avoid having two or more instances running at the
>> same time).
>>
>> If you want it to be two-way then it gets a bit more complicated.
>>
>> You might also want to consider using git fusion, which is Perforce's take
>> on this problem. I've not used it myself.
>>
>> From past experience though I would say the biggest problem is getting
>> developers to switch from the P4 mindset (centralized; code review hard to
>> do or ignored) to the git mindset (decentralized; code review actively
>> supported by the version control system).
>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
