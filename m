From: "Johnny Lee" <johnnylee194@gmail.com>
Subject: Re: [HELP] A local branch has disappeared
Date: Mon, 19 Jan 2009 15:16:00 +0800
Message-ID: <488807870901182316x4b3cb1bevfbb6419aa3e4d105@mail.gmail.com>
References: <488807870901181954p558756f5v94c8a6681125e8bb@mail.gmail.com>
	 <A9C9E16F-B1CC-4E0A-AEF1-426ABEF60BDF@theory.org>
	 <488807870901182219j763995c6y1796cf3c0a98a958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neil Macneale" <mac4-git@theory.org>
X-From: git-owner@vger.kernel.org Mon Jan 19 08:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOoO2-0005MY-Cv
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 08:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZASHQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 02:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbZASHQF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 02:16:05 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:50328 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbZASHQC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 02:16:02 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3060677wfd.4
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 23:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ca0Pt5QEtLXMlqtr99d0e02sk0uRiRqfOpV01RKVj/I=;
        b=wb61TLYil5OP0bXfjwrcIhKuzDWxJFKJfUNrH782wEQayYyo3I/rzUrt5Bzrf/9cdg
         GU6wJJmUe2n4IAGp4bePzzY+h3kbrImG/joHIteL49DPHLgXo8285/S55yPdmqZjP1S/
         oknymgg2/IJQz5yL5G5NsREbow1Ly96SoK10E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OB6WvOw91jVKQE4zpvS6b8KdSqRFpT/nYRE4Yq0PPzimMcP1r2knPuufh9RVeWwj4I
         wgdom8WmE+RZKqkIr1C7LcCzvaD9QE6z2Cink9/ORiuc3fhs0Bw1DwILHQ4f7eD9n1Bj
         T3YEO/xZcfumuPP62G2yPlX/KCU2mUP8UP1ZI=
Received: by 10.142.125.4 with SMTP id x4mr90820wfc.223.1232349360094;
        Sun, 18 Jan 2009 23:16:00 -0800 (PST)
Received: by 10.143.37.4 with HTTP; Sun, 18 Jan 2009 23:16:00 -0800 (PST)
In-Reply-To: <488807870901182219j763995c6y1796cf3c0a98a958@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106329>

Sorry, I forgot to reply to all in the last mail, again..

Hi Neil,

I used "git lost-found" to find out the latest commits, and use git
checkout -b cupcake commit_hash to get my lost branch back.

Thanks!

Though, I'm still confused about what had happened. :(

Regards,
Johnny

On Mon, Jan 19, 2009 at 2:19 PM, Johnny Lee <johnnylee194@gmail.com> wrote:
> The log about cupcake is also gone..
>
> git@tomato:~/golf$ cat .git/logs/refs/heads/
> htc_cupcake  tmo_cupcake
>
> And I can't get the latest hash by git log:
> git@tomato:~/golf$ git log
> fatal: bad default revision 'HEAD'
>
> Regards,
> Johnny
>
> On Mon, Jan 19, 2009 at 1:37 PM, Neil Macneale <mac4@theory.org> wrote:
>>
>> On Jan 18, 2009, at 7:54 PM, Johnny Lee wrote:
>>
>>> Hi all,
>>>
>>> Today I found my current branch (named cupcake) has disappeared.
>>> git@tomato:~/golf$ git branch -a
>>>  htc_cupcake
>>>  tmo_cupcake
>>>  origin/HEAD
>>>  origin/cupcake
>>>  origin/device
>>>
>>> As you can see, there is no "*" to mark the current branch.
>>>
>>> But when I check the HEAD, it still pointed to the cupcake branch
>>> git@tomato:~/golf$ cat .git/HEAD
>>> ref: refs/heads/cupcake
>>>
>>> But when I check the ref/heads, the cupcake is missing
>>> git@tomato:~/golf$ ls .git/refs/heads/
>>> htc_cupcake  tmo_cupcake
>>>
>>> And the cupcake in still in the config:
>>> git@tomato:~/golf$ cat .git/config
>>> [core]
>>>       repositoryformatversion = 0
>>>       filemode = true
>>>       bare = false
>>>       logallrefupdates = true
>>>       sharedRepository = 1
>>> [remote "origin"]
>>>       url = /home/rick/golfresort/device/.git
>>>       fetch = +refs/heads/*:refs/remotes/origin/*
>>> [branch "cupcake"]
>>>       remote = origin
>>>       merge = refs/heads/cupcake
>>>
>>> I'm confused:
>>> 1. I didn't do any aggressive operations. Why the branch has
>>> disappeared? Normally I have done these operation for this repo:
>>>  i. pull from parent repo
>>>  ii. cloned by children repo
>>>  iii. pulled by children repo
>>>  iv. pushed from children repo
>>> 2. Is there any way to resume the cupcake branch? Can I manually add
>>> the cupcake to ref/heads?
>>
>> I don't know why the cupcake branch would be gone, but you can probably get
>> something from the logs:
>>
>> $ cat .git/logs/refs/heads/cupcake
>>
>> The last line should tell you what commit you were at before it was
>> destroyed. Then you can create the branch again.
>>
>> $ git checkout -b cupcake <hash in the log>
>>
>> Hope that helps,
>> Neil
>>
>
>
>
> --
> we all have our crosses to bear
>



-- 
we all have our crosses to bear
