From: Irene Ros <imirene@gmail.com>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Tue, 24 Mar 2009 22:01:10 -0400
Message-ID: <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
	 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
	 <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
	 <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
	 <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
	 <alpine.LNX.1.00.0903242118270.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmISe-00016C-Ce
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbZCYCBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 22:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbZCYCBP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:01:15 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:43190 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbZCYCBM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 22:01:12 -0400
Received: by an-out-0708.google.com with SMTP id d14so2182865and.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 19:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xTCxE5dQT+aH7NF7H4fzfe5L1Qmyy3hZ6mh+ui0L3Eg=;
        b=WhH6Ih3n9Drr2BDjgeWm2jHx7Yq/WibaKtw+P4SNtN0KyOsu/K44z2V/Kyebj+tGO0
         N8anT9L4gVN1pLwZ3+/08P3aHCjzPVAwN4leZ6UcgyRQfCTewGQogsKyRaseS0xldubg
         Is+msmiIWVzZPtP7l1bDq0GKMLLbquX2augLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XYcuZD5wQw9QpPLoakrvjLXjapyY1ssfhGxsf/fZZVLZiyiPLbxzNpSLsQeSZG3n1Y
         qpzwYiM7FL/D+5+fc9su3GVcQnhj4dmF2zg9/4PsyhK/aqy6Jpq5ZHQAk7ieZQaU3GCh
         IjugDZnDzrsR3lFT1X1Kc0m/e+CQXuS2xDFgo=
Received: by 10.100.136.18 with SMTP id j18mr3148646and.113.1237946470269; 
	Tue, 24 Mar 2009 19:01:10 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0903242118270.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114537>

Hi All,

Thank you for the good advice. I may be the case I am somehow misusing
git... I couldn't resolve the issue and so I created a new project off
of the same repo. Switching to the same branch in question yielded an
even stranger result: In this new project, the commits were there (I
could see them in git log and in git log origin/myBranch) whereas in
the previous older project I did not... does that make sense? Our
origin branches are located on a central server so can't quite figure
out why viewing the log of the same remote branch from two different
projects would yield different results. Any suggestions? At this
point, I'm just really curious.

-- Irene



On Tue, Mar 24, 2009 at 9:24 PM, Daniel Barkalow <barkalow@iabervon.org=
> wrote:
> On Wed, 25 Mar 2009, John Tapsell wrote:
>
>> 2009/3/24 Daniel Barkalow <barkalow@iabervon.org>:
>> > On Tue, 24 Mar 2009, John Tapsell wrote:
>> >
>> >> 2009/3/24 Irene Ros <imirene@gmail.com>:
>> >> > Hi all,
>> >> >
>> >> > I've been using git for some time now and haven't run into this=
 issue
>> >> > before, perhaps someone else here has:
>> >> >
>> >> > I have a branch that is ahead of its origin by a few commits:
>> >> >
>> >> > $ git status
>> >> > # On branch myBranch
>> >> > # Your branch is ahead of 'origin/myBranch' by 10 commits.
>> >>
>> >> Tried running: git fetch =A0 ?
>> >>
>> >> For some weird reason =A0"git push origin mybranch" =A0doesn't ac=
tually
>> >> update origin/mybranch. =A0It's more annoying :-)
>> >
>> > It should, so long as you're using the native transport and
>> > origin/mybranch actually tracks mybranch on origin.
>> >
>> > "git push" doesn't update it, but the code that implements the nat=
ive
>> > transport does update it if it succeeds.
>> >
>> > (Actually, I'm not 100% sure that, if you update origin through so=
me other
>> > channel with exactly the commit that you now have in mybranch loca=
lly, and
>> > then try the push, it will update the local tracking for that bran=
ch; is
>> > that what you've hit?)
>>
>> I update via http - maybe that's why? =A0origin/mybranch is never
>> updated when I push. =A0It's not just a once-off quirk.
>
> Yup, http doesn't have it. One of my series currently in next moves i=
t
> from the git-specific protocol to the common code, but there's still =
work
> to be done to allow the http push transport to report back to the com=
mon
> code what got updated successfully, which is largely a matter of maki=
ng
> the http-push code run in-process instead of as a command run by
> transport.c, and using the just-added API.
>
> =A0 =A0 =A0 =A0-Daniel
> *This .sig left intentionally blank*
