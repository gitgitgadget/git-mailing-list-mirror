From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Checkout first version of each file?
Date: Tue, 8 Nov 2011 14:20:24 -0300
Message-ID: <CABLeVKEq3wtVxp8y1_Nv1tEA-0DEMk4QugkLDROY_XPAPc73yw@mail.gmail.com>
References: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
 <20111108140243.GA4866@kolya> <CABLeVKFkSP=2-kwsN4N+oLrPnijkpvV8Ki=Si4dpYXdzc+8ibQ@mail.gmail.com>
 <20111108150007.GA5261@kolya>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 18:20:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNpLv-0001vT-KL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 18:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab1KHRUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 12:20:46 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44145 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab1KHRUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 12:20:46 -0500
Received: by vcbf1 with SMTP id f1so616900vcb.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qyhO+XaEVYcU5w6wvKdeSBEPQ0dyV/DFqZUcwBafrqc=;
        b=pG/8e+zSpDZUxE8ECd9vln/y3qxmhS9Qt3hq0ItK/OplIerj3OMDux495E5gblTNfb
         3PZdBR7Bo6YMJykyYkIt5RG8ZFa9F2dQyFsxCSva0lw+w1cp/YvEHiJIkvZIvmYt34FT
         Pqo0sgFxeWYS2byjvBCWDI+gb6kyhlRDglp2k=
Received: by 10.68.4.200 with SMTP id m8mr2288601pbm.50.1320772845079; Tue, 08
 Nov 2011 09:20:45 -0800 (PST)
Received: by 10.142.253.7 with HTTP; Tue, 8 Nov 2011 09:20:24 -0800 (PST)
In-Reply-To: <20111108150007.GA5261@kolya>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185097>

On Tue, Nov 8, 2011 at 12:00 PM, Fredrik Gustafsson <iveqy@iveqy.com> w=
rote:
> On Tue, Nov 08, 2011 at 11:17:27AM -0300, Dario Rodriguez wrote:
>> On Tue, Nov 8, 2011 at 11:02 AM, Fredrik Gustafsson <iveqy@iveqy.com=
> wrote:
>> > On Tue, Nov 08, 2011 at 10:58:05AM -0300, Dario Rodriguez wrote:
>> >> Hello,
>> >>
>> >> My "issue" comes with my usage of git at work. I work with lots o=
f
>> >> applications, each of them part of each system. There are lots of
>> >> processes and lots of subsystems, so I never clone the entire rep=
o
>> >> into GIT, since it could be painful and slow. Even if I do so,
>> >> everyone else is using ClearCase, and their changes cannot be inc=
luded
>> >> into my git repo until they "chickin". Sometimes, I must update
>> >> sources from FTP because the changes are not up to date in
>> >> ClearCase...
>> >>
>> >> So, I clone every file that I will need to work into GIT, so i ca=
n
>> >> work with these files having a better control (With ClearCase it'=
s a
>> >> foolish "checkout>>lots of changes>>checkin" flow). But sometimes=
 I
>> >> don't know how many files I am going to change until I start codi=
ng
>> >> the requisites.
>> >>
>> >> In this cases, there is a situation that I don't know how to hand=
le.
>> >> If I need to rollback every change made to every file I cannot ju=
st
>> >> checkout the initial commit, cause I've added files after that, a=
nd I
>> >> need their initial versions too.
>> >>
>> >> So, how can I checkout the first version of each file? (I know th=
at
>> >> GIT tracks contents and not files, but the fact is that I need to=
 keep
>> >> track on files, it's the real thing I work with)
>> >>
>> >> pd: Sorry about my Argentinian-English (if it sounds so)
>> >>
>> >> Thanks,
>> >> Dario
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe git" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >
>> > Is all files present in your latest commit? Or can there be delete=
d
>> > files that you also need to recover?
>> >
>> > --
>> > Med v=E4nliga h=E4lsningar
>> > Fredrik Gustafsson
>> >
>> > E-post: iveqy@iveqy.com
>> > Tel. nr.: 0733 60 82 74
>> >
>>
>> Every file in the latest working tree is also a tracked file. The
>> files are being added to the git repo, but not removed from it.
>>
>> In other words, the biggest set of files is the latest working tree,
>> and the smallest one is the first commit.
>>
>> Dario
>
> I can't see a pure git way of doing this. However, you already seem t=
o
> use git in a very hackish-way. So here's a quick n' dirty solution (t=
hat
> is not very efficient).
>
> (not tested example code, that should be runned from the root-gitdir.=
):
>
> #!/bin/sh
> git reset --hard HEAD
> for f in `find`
> do
> =A0 =A0 =A0 =A0commit=3D`git log $f | grep commit | tail -1`
> =A0 =A0 =A0 =A0git checkout $commit $f
> done
>
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
> E-post: iveqy@iveqy.com
> Tel. nr.: 0733 60 82 74
>

Yes, it's similar to my approach, except that I used 'git ls-files'
and 'git log --format=3D%H' to get the commit hash for each file
instead. Seems dirty, but reasonable if you think the git way.

Thank you,
Dario
