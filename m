From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 4 Apr 2013 17:06:38 -0600
Message-ID: <CAMP44s3haEqFRYfMiHOB191_UcU4YRDbRX1J=oHVyN2PEGuV3g@mail.gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
	<1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
	<87y5cyqhya.fsf@59A2.org>
	<CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com>
	<87ppyaqcie.fsf@59A2.org>
	<CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com>
	<87li8yqayf.fsf@59A2.org>
	<CAMP44s16NcTBLWuUR9bb6KaspJYYcfsWVyF9NVO4gxP-gXr4WA@mail.gmail.com>
	<87eheqq6dk.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 01:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNtFY-00031U-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 01:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764817Ab3DDXGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 19:06:42 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:37168 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764605Ab3DDXGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 19:06:40 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so2982763lab.13
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=TBojAlASBAxTtq0avX2LeZrQuJ6HLJPmZfK5v17HMzI=;
        b=mdXZ5pIoRGOEAvjjexdqHk8EGklegCz7BOqCe80Phn4kEdPUC2B2jiZcFl208j5vJ8
         HJkePORbldFv4ysFvPgiy2p98wLWPdcl61LXS3IiSIspeuK0Wnz0GzbfOxs9n1i0MPi8
         iF79pQc2HZ4BhEZYIeaHUjdgTstypGrF++0+FUTP07e5EnpoPcjmMAgjTVSV8wum1pX+
         D4Ig2ukCtGmKdaHa3wMtZUE0Vg3jsub+J/DPTVxTXXFxUrM83OJO4ZDRvb94Qs02H6fz
         54oqXb/pM/X/CEpfus4Q3Y/lqvya6o/5HFq1nA1muDqcaj+xk8VaBz6HBwdmWpbxIkGg
         VmmA==
X-Received: by 10.112.156.42 with SMTP id wb10mr4661073lbb.32.1365116799046;
 Thu, 04 Apr 2013 16:06:39 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 16:06:38 -0700 (PDT)
In-Reply-To: <87eheqq6dk.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220121>

On Thu, Apr 4, 2013 at 4:27 PM, Jed Brown <jed@59a2.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 4, 2013 at 2:48 PM, Jed Brown <jed@59a2.org> wrote:
>>>
>>> Then perhaps we have different goals [1].  I don't know any Git User that
>>> would prefer to have an Hg upstream accessed through remote-hg.
>>
>> Who cares? If you don't know somebody, does that mean such person
>> doesn't exist?
>
> Maybe I wasn't explicit enough:
>
>     I don't know any Git User that would prefer to have an Hg upstream
>     accessed through remote-hg *than to have a Git upstream accessed
>     through native Git.*

Yes, Git users prefer Git, how are such obvious statements advancing any point?

>>> We have
>>> to assume that every Git (remote-hg) User is dealing with Hg Team
>>
>> No, we don't.
>
> Really?  If there is no Hg Team, why bother with an Hg upstream?

Say, I push my stuff to Bitbucket, and tell my team to pull from
there. Bitbucket also has support for pull requests, so I push to
Bitbucket tons of branches, and then issue pull requests through the
web interface.

Making assumptions about how people's workflows only segregates users.
There is always a way to make it work for *everybody*.

>> Wow, catastrophic. BTW. Any commit pushed will show in 'hg log' either
>> way. And who will run 'hg heads' if, according to you, the project has
>> stated that new heads should not be pushed? If no new heads are
>> pushed, 'hg heads' will never show anything interesting.
>>
>> Is that the *HUGE* problem? Too many heads will show in the arcane 'hg
>> heads'?
>
> Hg displays warnings about multiple heads, suggests that you merge them
> any time they are anonymous, and doesn't have remote namespaces so that
> names can collide.  Remember that the most common reason people give for
> using Hg in the first place is that it's "simpler" (yeah, I don't agree
> either, but that's their story).  So don the hat of a Git (remote-hg)
> User: You're interacting with people that don't understand version
> control very well and only know the basic Hg command set.  Do you really
> think it's okay to silently put them in a state where Hg will print
> confusing messages about multiple heads, disrupt their workflow ('hg
> log'), and suggest that they do things that are likely to be disruptive
> (like merge those heads)?

They have to merge those heads *anyway*. The only question is who and when.

And of course this is a total red-herring, you are not answering the
question at all. Newbies don't run 'hg heads', and they don't have to,
there's no problem with a branch specific for bookmarks. None
whatsoever.

>>>> And who says we are committing upstream?
>>>
>>> The discussion is moot if you don't want to push your commits upstream.
>>
>> There are so many workflows and use cases you are completely ignoring.
>
> Examples?  I'm just summarizing the workflows that I encounter and that
> other contributors to gitifyhg encounter.  You have said yourself that
> you don't actually use remote-hg [1], so why are you so confident that
> you know what workflows are desirable to remote-hg users?

Because I've used them in the past, and because I see Bitbucket, and
because I have eyes.

>> Anyway, I'm not going to discuss with you any more, a configuration
>> option would work perfectly, and curiously you didn't comment on that.
>
> Sorry, defaults matter and project philosophy matters.  The fact that we
> are arguing about such basic things has convinced me that I can't
> recommend remote-hg because I have no confidence that the behavior will
> be remotely acceptable to a Git user working with an Hg Team.

Yes defaults matter, and forcing the push is the only sane default,
there is no other way to push bookmarks in Mercurial. Period.

If your team has a problem with it, you turn it off, problem solved.

And ultimately it doesn't matter what I say, we are in a public
mailing list where Junio can pick anybody's patches, even if I object.
But you have to prove your point, and you haven't. And be honest, you
not recommending remote-hg has nothing to do with the quality of it,
or the "philosophy" of it, it's simply because you made a different
choice, and you are emotionally attached to it.

> But please try to make tools for actual users rather than hypothetical
> users, or at least don't act so incredulous when people are less than
> thrilled about using or contributing to your project.

By people you mean you. Nobody else has complained.

-- 
Felipe Contreras
