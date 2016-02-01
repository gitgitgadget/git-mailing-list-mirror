From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/5] [WAS: Submodule Groups] Labels and submodule.autoInitialize
Date: Mon, 1 Feb 2016 12:21:21 -0800
Message-ID: <CAGZ79kb=Cj_bOc6rQ83jWc+m-DDcFQav3XM741DyaebwehJiHg@mail.gmail.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
	<56A52818.8080808@web.de>
	<CAGZ79kY1Wa7kHh7GaCTAAmyaRgrT4_91XLaHZFrko9umEbNYkw@mail.gmail.com>
	<56A7DE2C.3020308@web.de>
	<CAGZ79kapcGDFx+=VNCPvRMUGBJiTzJqGWv6UzPNgMOVBKgwXdw@mail.gmail.com>
	<56AE7804.1060609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 21:21:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQKyb-0001Kb-42
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 21:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbcBAUVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 15:21:24 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37965 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbcBAUVW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 15:21:22 -0500
Received: by mail-ig0-f180.google.com with SMTP id mw1so41801716igb.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 12:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+p3/2fHUpovu3ppDKljmFz+ZfHkekf0b0M8I7Z5eCD4=;
        b=NGU0Rv+Xuut5v1sZIML9Us29Au3AQ0ILq60FUOpImjS3V/fO/3ouX9o9sRj5ak3spI
         GXply6/F4wrcXBpc6HU4PpgL4ZFp0lygQIHl6Lp/O3HbCnNLwvWKxPebutAleWd42H7d
         G6poZmHC/hWeLVqUdRDuV/YDa5TDLcrvPPtx6hgsT7F2VSmtwK1q0RPNIEGgjchjQ49P
         jd9qdBW/2r4C93qt6VeGQqvy5HI4JviBwemqeiRZf56+bGy5Map5Zcwlugdv93qegyJg
         iJs8aNiTfLX9OA6tSIIEhj8vTT4C3xQ+RAHP7z9GNWsRhK2W1oW7AClwjU7OfCTOlpJ4
         pIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+p3/2fHUpovu3ppDKljmFz+ZfHkekf0b0M8I7Z5eCD4=;
        b=R87TUtPhCd6TX4NDHktlC0FRE8X22WAirUUeefWg87PvxJH+IEQXlh6hsk7e5Tdn5D
         BUwsLEjbRXQHHOEJnK4zszjcSoywZQLgYiCnfnCnVonp3v9RUAMv+6oHVn/fe2fgH54Y
         aleBOcpbZ9YAigx131vm7POrRJKJZL9sxH/cCe6gGesHyNpZfxtKp5rYcjSudSGjOVJT
         XOm3351kLS/6wyYe6Qoah0HwbJd3b257imSFpA6c2AGSHrhxj7LinXxioV7wwM8xrsnU
         G15ye1AvaDQ1+5QgmnvFjFc+59EXQqIp9+fv8zOlvDhEvXaOFV9/n5xqYsr2f8crEj2+
         HdWg==
X-Gm-Message-State: AG10YOS02XAxnDmS4hroCU1tJrc+auAB8xGIH9kbN4EfpwvQ3YEX1mSmctbnomQp2E/5cPDqy5PiOoHH8/NhI1yY
X-Received: by 10.50.88.74 with SMTP id be10mr13194207igb.93.1454358081786;
 Mon, 01 Feb 2016 12:21:21 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Mon, 1 Feb 2016 12:21:21 -0800 (PST)
In-Reply-To: <56AE7804.1060609@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285212>

On Sun, Jan 31, 2016 at 1:09 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> After all this config is
>>> just about which submodules are chosen to be updated on clone and
>>> submodule update, not on all the other work tree manipulating
>>> commands.
>>
>>
>> So you'd imagine that "git submodule update" would remove the
>> submodule and setup an empty directory in case that submodule is
>> not configured ? (after switching branches or when just having cloned
>> that thing.)
>
>
> Not as a result of the label feature we are talking about here,
> I think that should just do what currently happens to removed
> submodules: they are left populated but are ignored by status,
> diff and submodule update. Removing the content is part of the
> recursive submodule update topic.

That is our second next big difference in understanding.
When having an autoInitialize option, we would not go further into
making rules for when to update submodules. "git submodule update"
would just update all initialzed submodules. (This thought ties well
together with only initializing those submodules that you want instead
of all of them.)

Now that we want to init all the submodules, it makes sense to only
update those we are interested in.

So from what I understand now:

(If labels are configured, then)

 * init a submodule at the earliest time possible, (i.e. while
   cloning or when upstream added a new submodule and
   we fetch it? Though then the init would be performed not in
   clone/fetch, but the "submodule update" step)

 * never deinit submodules automatically

 * submodule update is picky what to update by default.
   It will only update by label selection or directly specified submodules
   (git submodule update foo will update foo no matter if foo is in the
   selected group, a plain "git submodule update" however will only
   update group/label selected modules.)

>>>
>>>
>>> And throw away any customization the user did (to the URL or other
>>> configurations)?
>>>
>>> Without this sparse/label/group functionality, init is the way the
>>> user tells us he is interested in a submodule. But when configuring
>>> a label/name/path to update, the old meaning of init is obsolete
>>> and superseded by the new mechanism.
>>
>>
>> Or if we keep it at "--initSubmodule" only, which only initializes
>> a subset of new submodules, the meaning is not superseded.
>>
>> By having the initSubmodule thing set, the user tells us "I am interested
>> in all currently initialized submodules plus some more in the future, but
>> these have not arrived yet. To know which submodules I mean in the future
>> apply this pattern."
>>
>> Let's take the simplest case:
>>
>> A user is interested in all the submodules. So currently they clone
>> and initialize all of them. When upstream adds a new submodule, their
>> expectation is broken that all submodules are there and checked out.
>> by having the autoInit option, we'd just initialize any new submodule
>> and the user assumption "I have all the submodules" is true after
>> any "submodule update".
>>
>> By that point of view, we would not need to keep all submodules
>> initialized,
>> but only those the user is interested in. No need to have complicated
>> branch switching rules, but just as now "plus some futureproof rules
>> to declare my interest of submodules".
>
>
> I'm not sure what "complicated branch switching rules" you are
> referring to here, as far as I can see these only happen when we do
> not automatically initialize all submodules. What am I missing?

I was assuming we need to delete the submodules and preserve
their state somewhere.

So what I understand now:

$ git checkout <anotherbranch> # will not touch submodules, however
$ git submodule update # may update a different selection as the
$ # selection changed by a different .gitmodules file

>
> You'd have to deal with initialized but not to be updated submodules
> anyway (due to the user choosing a different label or upstream
> changing label assigments). So it looks to me like the approach to
> initialize them all as soon as they appear is easier to grok. And
> update, diff and status will just skip all submodules that don't
> match the configured label(s).

We can teach update, diff and status to ignore those non selected
submodules just fine, but I still think it is somewhat ugly.
(Consider the build system, which now needs to somehow know
which submodules to build. The non selected modules may
error out when building as their dependencies are wrong/not met;
also humans don't like wading through a ton of empty directories
to find their pet project)

>
> Additionally this will make it easier to e.g. change the upstream
> URL of the submodules in one go, as this has to be done after they
> have been initialized. If you clone the android repo from a local
> mirror it'd be great to just update all URL settings once right
> after clone instead of having to do that again each time you choose
> a different group.
>
> So I'm not per se against a lazy submodule init like you seem to
> propose it, but I believe it'd be better to just init them all as
> soon as they appear.

ok, I'll prepare a patch series for that.

>>> Yes. But I hope my arguments will convince you ;-)
>>
>>
>> --autoupdate-submodule seems to be one step ahead of my current
>> understanding?
>
>
> Yes, sorry for the confusion.

So now is time to start bikeshedding (aka naming things) again ;)

The main feature I'd understand is to only apply submodule update, diff, status
(and maybe more) to the selected submodules. So maybe

    $ git clone --apply-actions-to-label <label/path/name pattern>
[may be repeated]

    $ git submodule update # no additional arguments

    $ git submodule add --label <label name>

In the .gitmodules file we can still have "submodule.$foo.label" but in the
.git/config we may want to have "submodule.action-on-label" instead ?

Thanks,
Stefan
