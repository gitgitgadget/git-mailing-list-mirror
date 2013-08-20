From: Johan Herland <johan@herland.net>
Subject: Re: Notes and submodules
Date: Tue, 20 Aug 2013 11:41:37 +0200
Message-ID: <CALKQrgeWtZGYRGDxVy9kDUqGjMcFn8E3My3dR_9-Qyzuy6QMxw@mail.gmail.com>
References: <CAC9WiBj-ij1o6JL-FtUuCgdf8ZqrhJb2=dQcSXjRMEwwL4VWFA@mail.gmail.com>
	<CALKQrgfGUMrcR+EPTvN9+mFPcW6Q-zv1JM6MJK-61BvF3yYpbQ@mail.gmail.com>
	<CAC9WiBiJQ-kafY5xD9nAnxKPQTyhp5sL49szHQj4C4P_UbBmYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 11:41:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBiRh-0007sf-8T
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 11:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab3HTJlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 05:41:45 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:34377 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab3HTJlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 05:41:44 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VBiRa-00077T-2Z
	for git@vger.kernel.org; Tue, 20 Aug 2013 11:41:42 +0200
Received: from mail-pd0-f170.google.com ([209.85.192.170])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VBiRZ-000BKy-Oz
	for git@vger.kernel.org; Tue, 20 Aug 2013 11:41:41 +0200
Received: by mail-pd0-f170.google.com with SMTP id x10so183713pdj.15
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 02:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k9RNvUnj2jYGRh0sNIeCcylWOnn7lwii+hozrIVpTQE=;
        b=RAnjiQ5sxnc/kxyG354HDdIyhA8qYxPDFaxAEo5eI1ol/qASY8ey1DSp6Ic83NU6FL
         //fHf3hAJLcLoccGpBd/yZpvR1gSXSvfXL/tRNxJGb3QWHYGgezW9+qsJYwSa0zdvenl
         ss4iN2WczObdGC1BAhM1/Mske+ZRb/iBPB5wTXSF/S+NzQ+TA509nG8zUspCcPZOqT/H
         YEPOVGn/H3oJxwF/NrLyAIVY0AmcKkEb6W+c/3pAzeykChLy4YQOxeUPAygbyc0g8Iu/
         SQA79YaAznKg88+/PYmtq4RCBxm2ntlGgx8zUxNStJdXnisTRG9VXaJEY1FD22neLzYX
         Ux0Q==
X-Received: by 10.68.134.37 with SMTP id ph5mr646292pbb.195.1376991697649;
 Tue, 20 Aug 2013 02:41:37 -0700 (PDT)
Received: by 10.70.126.67 with HTTP; Tue, 20 Aug 2013 02:41:37 -0700 (PDT)
In-Reply-To: <CAC9WiBiJQ-kafY5xD9nAnxKPQTyhp5sL49szHQj4C4P_UbBmYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232592>

On Tue, Aug 20, 2013 at 10:39 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>> On Mon, Aug 19, 2013 at 3:55 PM, Johan Herland <johan@herland.net> wrote:
>> On Mon, Aug 19, 2013 at 10:13 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>>> Is it possible to keep submodules notes in the super project  ?
>>
>> Not easily. I guess it depends on what you want to use the notes for.
>> In order for notes to be generally useful (i.e. show up in logs,
>> surviving a notes prune, etc.) they really must reside in the same
>> repo as the annotated objects [1]. Now, if all your interaction with
>> notes happens through scripts that you control, then I guess it would
>> be possible to hack this in some sort of semi-workable way, but you
>> would still have to make sure never to run "git notes prune" in the
>> super project. I guess the real question here is: Why would you want
>> to do this? and is there maybe some other way your use case can be
>> accomodated?
>
> Well, I'm tracking different foreign git repositories as submodules.
> Those repositories which tracks different projects are not mine
> therefore I can't save my own stuff directly in them.

Sure you can. It's your clone, you can store whatever you want in
there, regardless of whether you are allowed to push your additions
back to the foreign repo. You can always set up another remote repo
(e.g. on GitHub) where you can push your additions (whether they be
notes or other Git objects).

> I need to
> annotate some commits in each submodule.
>
> One option would be to clone each repository in my own place, but I
> though it would be simpler if I could store the anntotion in _my_
> super project.

No, it's probably much more straightforward to simply maintain your
own clones/forks of each submodule, and keep the annotations directly
in there.

In Git, there is no real concept of _ownership_ of a project. I might
put a repo on a server somewhere, and I can "own" that repo in that I
control who is allowed to push into it, but anybody that can read that
repo, can also clone it, and I have no say in what happens inside
those clones. If somebody is not happy with how I control/maintain the
project, they can make their own clone/fork available online, and
convince everybody to use that repo (instead of my repo) as the
authoritative source of the project.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
