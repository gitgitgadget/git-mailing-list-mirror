From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: repository of handy git aliases?
Date: Fri, 19 Aug 2011 00:52:22 +1000
Message-ID: <CAH3AnrpahkHtnu5QTRns-vVcCoj3Q8JM-mzytYF2ZC_EXjU7Xw@mail.gmail.com>
References: <CAH3AnrpSeWytri-bHEi_9qkAKG1fjL0pVuYFOrrmZumJ6dv_wg@mail.gmail.com>
	<CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com>
	<CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com>
	<CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com>
	<4E4A76E7.2090100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 16:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu3xW-0007px-DZ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 16:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab1HROwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 10:52:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52696 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab1HROwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 10:52:24 -0400
Received: by eyx24 with SMTP id 24so1250402eyx.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+e+bYw++oK8E5rNFcUuW2UKPgG8r0cIG4jaLK9UwAws=;
        b=iqWB1gGPZ+IlsfrYWevhjlmaX5W6k4QIOHYucUZa5wBrc4XV/bDuKMFkCJUiIhlze+
         /vKXxRhumWotCnvPvg29gi8CPjj31+wLPJNWofV1MIgrkpT+A5JbjbrQ4geBlVez+Rbb
         9i94Qnr0xqjRuWL+QHT056tJMwsKOrel8xMZ8=
Received: by 10.14.146.142 with SMTP id r14mr256003eej.62.1313679142726; Thu,
 18 Aug 2011 07:52:22 -0700 (PDT)
Received: by 10.14.127.138 with HTTP; Thu, 18 Aug 2011 07:52:22 -0700 (PDT)
In-Reply-To: <4E4A76E7.2090100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179602>

On Tue, Aug 16, 2011 at 11:55 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jon Seymour venit, vidit, dixit 08.08.2011 12:43:
>> On Mon, Aug 8, 2011 at 8:22 PM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>>> On Mon, Aug 8, 2011 at 7:45 PM, Jakub Nar=C4=99bski <jnareb@gmail.c=
om> wrote:
>>>> On 8/8/11, Jon Seymour <jon.seymour@gmail.com> wrote:
>>
>> I've also added this...
>>
>> Listing the tips of branches in pu that are not in master
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Suppose you have two aliases defined like so:
>>
>> [alias]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 oneline =3D !/usr/bin/xargs -L1 git log =
--decorate --max-count=3D1 --oneline
>
> How about
>
> oneline =3D git log --no-walk --decorate --oneline

I still need to !/usr/bin/xargs -L1m, don't I? The point is to
transform a list of SHA1s into a decorated list. But point taken about
--no-walk being an alternative to --max-count=3D1.

> git branch --merged origin/pu --contains origin/next
>
> (or with --no-merged, but put it first.)
>

So, the idea with tips is that it will show you the tips of
independent lines of development that have diverged from origin/next
(or before) that have been merged back into origin/pu. This works,
even if you don't have branches assigned to these tips.

In this example:

A-----B---E---F---G---H
\-----C--/   /
 \ ----D----/

git tips F will show B, C, D as the tips of branches that have
diverged from the mainline but have merged back in.

If I want to rebuild F' which does not include C, then git tips F
tells me that I have to merge B and D.

The git tips alias abstracts the function of 'git work list
dependency' which is a function of git extension (git work) that I
have been playing around with for a while.

I use git work to manage a private integration branch which includes
all my current published but unintegrated-upstream topics. If I decide
I want to unmerge one of these topics from my integration branch, I'd
do something like:

     git work unmerge C

Which does the equivalent of:

   git checkout B
   git merge D
   git rebase --onto HEAD F H


>>
>> which is a list of the tips of branches that are in pu, but not in n=
ext.
>
> That's not quite the standard --decorate, is it? ;)
>

Not sure what you mean by not being standard? The main idea about
using --decorate here is to get a dump of any refs that might describe
the identified tips.

jon.
