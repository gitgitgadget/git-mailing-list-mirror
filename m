From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/4] Submodule Groups
Date: Fri, 22 Jan 2016 09:55:07 +0100
Message-ID: <CAHGBnuMRd3bg4KYito08U8LJNC3JAJFBVz-APZxVJyd6WKO6TQ@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<56A14AD4.6040608@gmail.com>
	<CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 09:55:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMXUv-0003iO-QX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 09:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbcAVIzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 03:55:10 -0500
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36720 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbcAVIzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 03:55:08 -0500
Received: by mail-ig0-f194.google.com with SMTP id o2so6462764iga.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dCoqm5hzQpmzI2bpDdVV9qZaGi0B9QygMrZcHuu8nA0=;
        b=feExbheZk+yctAMXROX1hK8BeoCt5FBgmPBQcOkWvnojtA5j/Ni8fHr3NbURGL+Y/W
         bQwE2PdX/jzzyp1WwZlw92q2qfOXXl/Dh1K4ms2WXrV8jA3UqmxEveNTWdERmOvdLGYm
         1235aUeLNCkg2xylJKofJ/Gt90MIGJ3puL0jmnBOl1HOCRGENeoHCQC5FZh/OVHweIod
         +ApUHqf5Wymyzc7wtraOeiqPkuk7O9wzuDJqA/O8HjS1c8f5yrGEMZY6T2SISb1b1uv5
         KoKbaGYRsw7eLeh5OA/Z2SzDR5IL4LHDQBjO8sJeUpgcWdlnfzigq1MfA8R5LrKapoYj
         Qsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dCoqm5hzQpmzI2bpDdVV9qZaGi0B9QygMrZcHuu8nA0=;
        b=i6RIkKSJwJbHsbhShTmJ/42J7mgsQtCWitOGR/h/gQHI9iN91vsFZ5QotwjshoClkx
         QEXkL7w+acHfRINSZzQZ15D//wJ1zE9MdpzoTrcHQl/iXR/MGJ7hva5d8eFeC4RgbI8D
         ZPqAz0dKsWuX7Aawwh/5Wzr2TxR3+EaQgpuMZp20zUe9jyNDoMsRmmFHiDB51OSLT/wJ
         9BRumb0psKLbVjYyq9LG6aouQHcebMmeeiBa6EYKnd7XQVTIX7Nrl6bte0jRwZOOjOJa
         cMHxamlgK0ILQbTt62d9IdfO+juxHzWba928L6c3o3bi3LILL39c5kldjJnfSfsl5pyA
         FSXw==
X-Gm-Message-State: AG10YOSV0s50nAh85DJFeRJGrn7OqI40VvpptfaJcuZ3vYKJzJB5TIEdt4F4LLiTy+2/kEl/HkeK/gotp5SFRA==
X-Received: by 10.50.4.101 with SMTP id j5mr2404622igj.47.1453452907356; Fri,
 22 Jan 2016 00:55:07 -0800 (PST)
Received: by 10.107.180.66 with HTTP; Fri, 22 Jan 2016 00:55:07 -0800 (PST)
In-Reply-To: <CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284552>

On Thu, Jan 21, 2016 at 10:56 PM, Stefan Beller <sbeller@google.com> wrote:

>>> [submodule "gcc"]
>>>          path = gcc
>>>          url = git://...
>>>          groups = default
>>>          groups = devel
>>
>> On the quick I was unable to find the rationale why entries are now stored as separated lines compared to v1. I liked the comma-separated approach better as it's more compact.
>
> IIUC the line oriented way is preferred as it is our standard. Do we
> have any other options stored as a comma separated list?

Out of my head I cannot think of any. But that shouldn't mean we
cannot introduce such comma separated list if it makes sense.

> Makes sense to use singular then. However per discussion with Junio in
> [PATCH 3/4] submodule update: Initialize all group-selected submodules
> by default, we want to not name it "group", as it's unclear what a group is
> supposed to mean. What does a group do? which operations are supported?

How about calling it "label" instead of "group"? IMO with the word
"label" it's more clean that a single submodule can have multiple
labels, as the concept of labels is familiar to the user already from
applications like Firefox (bookmarks), Google Mail, Mac OS X Finder
(files) etc.

> Instead of having a submodule -> set assignment, we could do it the
> other way round:
>
>      [submodule "gcc"]
>          ...
>
>      [submodule-set "default"]
>         submodule = gcc
>         submodule = foo
>         submodule = by/path/*

In your example you're now introducing "set" as a new term. Shouldn't
this better be "submodule-group" then? I actually like this idea quite
a bit as it completely solves the problem about being clear that a
submodule can belong to mutiple groups.

> but I'd assume this is less useful for the user. How often does a user ask:
> "How many/Which submodules are in $GROUP" as opposed to "What about
> submodule foo,
> is that part of group $GROUP?"

True, but for answering that question a user would not look at
.gitmodules, but run a command, and the implementation of that command
would completely hide that complexity from the user.

> As asked above, how many comma separated things do we have in git configs?
> I'd really not want to add more mental complexity to Git. As far as I

I don't think it can get much worse anyway ;-)

> remember we have
> rather double configs than one long line separated somehow.
> (The only thing that comes to mind is multiple remote urls for pushing)

I believe so, too. But I'd see the introduction of comma-separated
values as an exit-strategy to that. More settings could make use of
that in the future, then.

-- 
Sebastian Schuberth
