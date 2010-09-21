From: Joshua Shrader <jshrader83@gmail.com>
Subject: Re: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 15:57:07 -0400
Message-ID: <AANLkTinDYae7yxSaRKNwOvkRe3yQ2GCBT=tiXhDe7NVR@mail.gmail.com>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com>
	<4C987C2E.3060001@drmicha.warpmail.net>
	<4C98830A.70203@viscovery.net>
	<4C989BBD.80106@drmicha.warpmail.net>
	<4C989E6B.1070703@viscovery.net>
	<4C98A0B7.9050501@drmicha.warpmail.net>
	<4C98A645.8070601@viscovery.net>
	<4C98CEA1.2050405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 21:57:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy8xw-0007C2-V2
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 21:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945Ab0IUT5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 15:57:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57629 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338Ab0IUT5R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 15:57:17 -0400
Received: by gwj17 with SMTP id 17so1756668gwj.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YFtfMwBV+kAyv+jx9n8BURjPjvO+/D+srSRmdPwWguU=;
        b=MS/6isgGFK4ixi1dnBay5EARySnVfvFHhmPaiOmPrzioYoCQWbyz9ngwU3vcQiNkjo
         ALUvPdQZpjldWwBxW1K9kBLWo+ggFAYwD8bez5HUXJOcec16yHM/bv5QrZFgV6zEVG7s
         0nf0Bix/nRJ0Ah/hieIPiMi9ptDYX5+DS6W8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E0H5gOMl4N6X95xB6LXe7qpsa+tIHKDRtDuOeCZE3vvdS0EZ6q1y4uOlCpKzhOyJbk
         pd7657P7go1eqqFdjCNLfEJ5KUhR8JThT0AgyoYWblKGDNg4bJXC4TllGtVGqFmArhB9
         CHHM48Y+zIKfZlkgzCg5B167XcbGOgCpGOcjo=
Received: by 10.150.216.2 with SMTP id o2mr11431287ybg.420.1285099028036; Tue,
 21 Sep 2010 12:57:08 -0700 (PDT)
Received: by 10.151.145.14 with HTTP; Tue, 21 Sep 2010 12:57:07 -0700 (PDT)
In-Reply-To: <4C98CEA1.2050405@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156747>

I think I need to apologize to the list.  I did not actually observe
what I had stated in my original post.  Given the description (and my
possibly naive understanding) of git-describe, I hypothesized that
what I originally stated was possible. If git-describe is in fact
implemented with a first-parent-like behavior, as some people believe
to be true, then I believe it is working correctly - I've seen nothing
to the contrary.  However, I do believe that the documentation is
unclear if this is the case.  My interpretation of "depth," which I
believe to be consistent with the graph-theoretical definition, does
imply that what I stated could happen.


On Tue, Sep 21, 2010 at 11:26 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Johannes Sixt venit, vidit, dixit 21.09.2010 14:34:
>> Am 9/21/2010 14:10, schrieb Michael J Gruber:
>>> Johannes Sixt venit, vidit, dixit 21.09.2010 14:00:
>>>> Am 9/21/2010 13:49, schrieb Michael J Gruber:
>>>>> searching to describe e5498e8a
>>>>> =A0annotated =A0 =A0 =A0 =A0 38 v1.7.1.1
>>>>> =A0annotated =A0 =A0 =A0 =A0252 v1.7.1
>>>>> =A0annotated =A0 =A0 =A0 =A0268 v1.7.1-rc2
>>>>> =A0annotated =A0 =A0 =A0 =A0318 v1.7.1-rc1
>>>>> =A0annotated =A0 =A0 =A0 =A0355 v1.7.1-rc0
>>>>> =A0annotated =A0 =A0 =A0 =A0478 v1.7.0.7
>>>>> =A0annotated =A0 =A0 =A0 =A0492 v1.7.0.6
>>>>> =A0annotated =A0 =A0 =A0 =A0512 v1.7.0.5
>>>>> =A0annotated =A0 =A0 =A0 =A0539 v1.7.0.4
>>>>> =A0annotated =A0 =A0 =A0 =A0564 v1.7.0.3
>>>>> traversed 1267 commits
>>>>> more than 10 tags found; listed 10 most recent
>>>>> gave up search at 97222d9634b5518cd3d328aa86b52746a16334a7
>>>>> v1.7.1.1-38-ge5498e8
>>>>>
>>>>> v1.7.1.1 clearly wins by depth priority.
>>>>
>>>> If "depth priority" is not the shortest ancestry path (and it obvi=
ously is
>>>> not given the numbers above), what is it then, and why does it not=
 work
>>>> with Joshua's example? Wouldn't it be better to make it Just Work =
instead
>>>> of adding a workaround that has to be enabled manually?
>>>
>>> I don't consider the existing behaviour wrong, though it may be a b=
it
>>> tough to figure out. It may even be that the depth calculation has =
an
>>> off-by-1 error which leads to this behaviour.
>>
>> I faintly recall that the current behavior was already made
>
> Better faintly than faintingly ;)
>
>> --first-parent-like on purpose, exactly for cases like Joshua's and =
the
>> one I cited. Why does it work with mine, but not with Joshua's?
>>
>> Notice that v1.7.0.7 is an immediate parent of e5498e8a, but still i=
ts
>> calculated "depth" is much higher than for v1.7.1.1, which is 25 com=
mits
>> down in the history. Why? Why isn't it the same with Joshua's histor=
y? Is
>> it due to the commit dates? Or the tag dates?
>
>
> By experimentation (inserting additional tag-less commits, not changi=
ng
> topology), I can make v2.0-base have the same, lower or higher depth
> than v1.1-stable.
>
> In fact, the (commit) date order is important here: For describing
> <commit>, "describe" builds a 1 item list with commit, pops it, inser=
ts
> its parents in date order (!), looks at each item in that order, in e=
ach
> step again inserting the parents in date order. So, it's really that =
the
> branch with more newer commits wins (this is a lousy description, but
> you get the idea).
>
> Reading commit messages like 80dbae makes me think that this was
> intended; and it is completely different from a first-parent approach=
=2E
> So I think the default really is a good default as is, and first-pare=
nt
> is useful and different in some cases.
>
> Michael
>
