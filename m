From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/2] Submodule shallow recommendation [WAS: Submodules:
 have a depth field in the .gitmodules file]
Date: Thu, 26 May 2016 14:20:04 -0700
Message-ID: <CAGZ79kY-VOpaJuCFPAb9EzKhgo709MqjqVL1+k1Ehnqaiw=_mw@mail.gmail.com>
References: <20160526000633.27223-1-sbeller@google.com> <xmqq1t4owuue.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZKSC-vdUXg0uzb_u022TNVY-JHXuXLAc2LOT7OvpYckQ@mail.gmail.com> <xmqqoa7svdds.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 23:20:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b62hR-0001ZU-H7
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 23:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbcEZVUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 17:20:07 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36150 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114AbcEZVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 17:20:06 -0400
Received: by mail-ig0-f176.google.com with SMTP id ww4so97711622igb.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Aqm1CX8fbjtMAq07lCHAuAx80pj9oQiLCmyyebW6ffY=;
        b=LU6AVzraU6N6Vp89IxtSfcA/chq0g2EVsaGQFIHKSQqKmDfPg/OKoCADpmNsYAbyjx
         mPXdL1Z/Fw2qXfav0kQPERS0eRUEgz0peIdx5+HrdpCF6idIAFzzV6N86A4JdKNx3F5H
         kz5iHDoJ2CujbfVCpFVmD3TLUTAX8E6+76uzMrH/9p8yX8asDYxeqXTZEObMv8D9Q0hG
         n+cyzhLV1T3eutEssjQpVqw2tSPuOT7wsGU3uCaUUvbmZPZ7e2dFT3qN9ddYSaCZJ5uc
         +DOB8uKknOs+IEmZY56bMBDPzoEOpFaCSoApeAjuUzWMj4Uv+MVrUa33JJgZ5z+KbFQ+
         8GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Aqm1CX8fbjtMAq07lCHAuAx80pj9oQiLCmyyebW6ffY=;
        b=M50LRPrEw+Mqk+9GUFz43Ee1OGfrW2acHe8IPigyKM4jnJE+OIqFhVG3wNValxiBsM
         PmA5cmUHMIS/Qycc+Yo87mSuxPg0ps+ibdNcRPrlA25OIvxUAvOsIZoo4AIsuaK1mzxL
         TYTnAo8Nky5XMd1ygODdpU4JYxkZ1fnpjDE8wtP01SmtE9xI5KZISKfjgW7eWZW4DmiW
         e/PplcZqsyAqEzDqSSwYzf8GsSvuUrTQE76Id/FB4zB+omKfUl4kdpmGaBsLC8602XaO
         z3MW+36svPZEXqGldGSoj5Wd7wrb7FKgADUtwSTdCpIrHhT5/zbW+AiKKf/B8wxDcp5G
         8+sw==
X-Gm-Message-State: ALyK8tJo//Te98fJ18zR2oyMJN0RePeIkf6/7ZCRLqOV5HVv5YxeaGN9kQ/yD2qSGBgw4XuldMtqcBpw/53bB6Tq
X-Received: by 10.50.38.130 with SMTP id g2mr5023352igk.93.1464297604684; Thu,
 26 May 2016 14:20:04 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Thu, 26 May 2016 14:20:04 -0700 (PDT)
In-Reply-To: <xmqqoa7svdds.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295695>

On Thu, May 26, 2016 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, May 26, 2016 at 11:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> Sometimes the history of a submodule is not considered important by
>>>> the projects upstream. To make it easier for downstream users, allow
>>>> a field 'submodule.<name>.depth' in .gitmodules, which can be used
>>>> to indicate the recommended depth.
>>>
>>> I have a design-level question.
>>>
>>> If your project consists of 600 submodules, among which 40 of them
>>> you would recommend making a shallow clone, are there traits, other
>>> than "most people would not care about its history", that are shared
>>> across these 40 subprojects?
>>
>> From my understanding these 40 subprojects are a large file storage
>> done different than Git LFS. In the repo world this was choosen to be
>> a separate repository, such that you had versioning available as the
>> large files change a few times (like a precompiled kernel for special
>> hardware, etc). And this is one of the missing pieces to translate the
>> current repo-tool workflow to submodules.
>
> I am not questioning the value of being able to say "this and that
> submodule need only a shallow copy".  I am trying to see
> "individually mark each and every such submodules" should be the
> primary interface to do so.
>
>> So you are proposing another layer of indirection, i.e. instead of giving
>> a pathspec with ":(attr:label-framework)" we would want to give a profile
>> which then has the pathspec plus additional information on shallowness
>> an such.
>
> I do not understand what you mean by "instead of giving a pathspec"
> at all.
>
> When you have 40 submodules, with your design the user has to
> sprinkle 40 lines of
>
>         shallow = true
>
> for each of [submodule "$n"] sections.  If there are other traits
> (see my first question) that are similar, they will have some other
> setting next to the "shallow = true" 40 times.  When a new submodule
> is added to that same class, they will again have to add these two
> lines.

I could not find out about another class or attribute matching like that.
Sure there are other attributes (Labels), but they don't match closely
these 40 submodules, but are arbitrary.

>
> I was wondering if a level of indirection that lets you say
> "submodules in this group all share 'shallow=true' (by default)"
> would improve that cumbersomeness.  When you add another similar,
> trait, you add that just once, not 40 times.  When you add another
> submodule, you say "this submodule is also in that group", without
> mentioning "shallow".
>
> We probably _need_ shallow=true at individual module level, if only
> to override the default given by such an indirection scheme.  So
> don't take the message you are responding to as "no, your design is
> not good, scrap it, and here is a better one".  It is more like "It
> would be a good first step, but have you considered where it will
> eventually lead us to?

Even if we decide we need it later, this doesn't seem to be a blocker
or contradicting such an enhancement.

> Would the more complete future look like
> this, and how well would this first step fit in that world?  Would
> it be a good escape hatch, or would it have to be deprecated?"

Looking at the Android open source project, we have 45 repos,
that are marked with clone-depth="1" , 37/45 are in a path starting
with "./prebuilts/", i.e. competing with Git LFS.
The remaining 8/45 seem to be device specific kernels.
37 of them (a different set than the prebuilts though) carry one label.

So with that data, I would expect that you would not need to mark a
submodule often as shallow, but it's quite obvious at creation time.
And specially at creation time it is easier to edit the module specific section
as opposed to adding the module in a profile or other indirect section.

I note, that we can extend to an indirection concept later if needed, though.

>
>> And you reinvented submodule groups. ;)
>> IIRC we had a discussion if we want to have the submodule groups
>> stored at each submodule or at a central "profile/group" setting.
>
> As I said, it was not my intention to get into that; I am not
> interested in the exact syntax, and I am not interested whether the
> pointer goes from group to individual modules (i.e. [group "bar"]
> says "foo" is one of its member modules), or individual modules have
> pointers to groups (i.e. "module [foo]" declares its membership in
> group "bar") at all.  I really do not care.
>
> What matters in my suggestion was, after you established that group
> "bar" exists, you can do:
>
>         [profile "framework"]
>                 shallow = "some notation that refers to group bar"
>
> so that you do not have to repeat "shallow = true" many times per
> submodule.

Ok, I just wonder how hard that  "some notation that refers to group bar"
is to get right. (Both on the design level for us as well as for users to
understand how to express themselves and then doing it right).

And I would not try to outsmart the user here? The repetition of
40 times "shallow" may be cumbersome, but only for creation,
not for maintaining!

Having more lines in the .gitmodules file is not a bad thing per se, though?
If you have these 600 submodules, you would search for the one you're
currently interested in anyway, so it doesn't matter if the average
number of lines
per modules is 3 or 5.

>
> By the way, I do not see the "profile" as about "submodules" or
> "submodule groups".  It is more about "Who am I?  What am I working
> on?  Give me an appropriate set of settings for the 600 submodules
> you have, with the knowledge that I am a framework person".

And I thought branches with different .gitmodule/.gitattribute files would
solve this.

Compare to the kernel development: a network person will use the
network maintainers branch to start developing; They will not get
Linus copy and set some magic to indicate they're a network person?

>
> grouping submodules would merely be one mechanism to help specify
> that.
>

Thanks for raising concerns, it actually made me think of more issues.

Thanks,
Stefan
