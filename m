From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Sat, 28 Sep 2013 22:37:05 -0500
Message-ID: <CAMP44s12c2_nEkwzgWXYzaJTeymSyLbDMWoRygMwZv8-m8wG4g@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
	<20130924183958.GK9464@google.com>
	<CAMP44s0UcP5AhWrm7vjBDLvY6CupzL03kys1YXs9cpGJNxkBBA@mail.gmail.com>
	<52479C04.8060000@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 29 05:37:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ7p9-0007jB-S2
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 05:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab3I2DhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 23:37:09 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:49013 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab3I2DhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 23:37:08 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so3365655lab.14
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 20:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lWBnOSNM6mlwA6TsEnPz1e8zmeuoxUR1k2ZoB1dKKV8=;
        b=ne4/J0p1d0UeBg3ILRSqMrkgRBmBQH08X7rY3HDk8cqGN+vp2Gy4eOyZqAZPTyQlbL
         QxGGFHD1Yu62JbFw82h0BhJ4MjrBgXVqZlRcDrWUHPoSsazPZeEBuB0AUbIkRkVZCPSJ
         5fSeqE4dWVQLAUePYDpESS7MFmpEJEMKHgoKNKD2vnKSK2Bxj8vNMWrHi2trcxaYcfyn
         YSrZPexsgUtB5QbV9lGcXKaSAf+OzA/IePUSE9W2n3HPThmbolN/9P9vFtmyrhw65GZ/
         FugA3p8F7G1766IBAVrmrm53fk7okDSOa2FRjsTbYvmOYf4n2ySoH+i0kqKNaqoK6b3+
         J3wA==
X-Received: by 10.152.29.201 with SMTP id m9mr13371191lah.6.1380425825474;
 Sat, 28 Sep 2013 20:37:05 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 20:37:05 -0700 (PDT)
In-Reply-To: <52479C04.8060000@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235576>

On Sat, Sep 28, 2013 at 10:18 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 09/29/2013 12:41 AM, Felipe Contreras wrote:
>> On Tue, Sep 24, 2013 at 1:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>> On Sat, Sep 21, 2013 at 02:20:21PM -0500, Felipe Contreras wrote:
>>>>> For now simply add a few common aliases.
>>>>>
>>>>>   co = checkout
>>>>>   ci = commit
>>>>>   rb = rebase
>>>>>   st = status
>>>>
>>>> [...]
>>
>>> But making 'ci' a synonym of another command by default while still
>>> keeping its definition configurable would be doing people a
>>> disservice, I fear.
>>
>> And I and many (most) users disagree.
>>
>>> As long as 'ci' works out of the box, it will
>>> start showing up in examples and used in suggestions over IRC, etc,
>>> which is great.
>
> ...and in scripts.
>
>> It might, or...
>>
>>> Unfortunately that means that anyone who has 'ci'
>>> defined to mean something different can no longer use those examples,
>>> that advice from IRC, and so on.  So in the world where 'ci' is a
>>> synonym for 'commit' by default, while people still *can* redefine
>>> 'ci' to include whatever options they like (e.g., "-a"), actually
>>> carrying out such a personal customization is asking for trouble.
>>
>> Precisely for this reason it might not. If people know aliases can be
>> different in different machines, they would avoid them in
>> documentation which is meant for all machines.
>
> My experience contradicts your prediction.  I have 'ci'/'co' aliases in
> my own configuration.  But even though I am aware of the fact that other
> people might not have the same aliases, I have on multiple occasions
> used them in documentation and/or scripts meant for other people.  The
> muscle memory is just too strong.

If you are already making that error, then this patch wouldn't make it
any worst. In fact, it would make the situation better.

If previously you had 10 persons complaining about the "ci" command
not working, now 9 of them wouldn't complain because "git ci" does
actually work, even if you have aliased it to something slightly
different, like "commit -v". Instead, you would have 1 person
complaining, because he has a different alias, which makes the command
fail somehow. In reality, that 1 person might not even exist.

The solution before and after my patch is the same; avoid the 'ci'/'co' aliases.

> My error was discovered by other people who didn't have those aliases.

And after this patch it still will.

> If *most* people had the same aliases as I did, and others had defined
> their own slightly different ones, then the scripts would have subtly
> malfunctioned for the latter set of users and I would have had trouble
> reproducing the errors.

Doubtful. But a warning that a default alias is being used, or simply
showing the actual command in the standard output would fix the
problem.

It certainly looks like you are not even looking for solutions for the
hypothetical problems you put forward.

> So, even though I think such aliases are a great convenience factor, I
> am -0 on including pre-defined but overrideable aliases and -1 on
> including pre-defined and non-overrideable aliases.

And still, somehow every other VCS out there manages default aliases
just fine, and Mercurial even allows overriding commands. How do you
explain that the world hasn't ended for them?

-- 
Felipe Contreras
