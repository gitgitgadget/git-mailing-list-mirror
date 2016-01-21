From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/4] Submodule Groups
Date: Thu, 21 Jan 2016 14:30:32 -0800
Message-ID: <CAGZ79kYVE7a=kXi__+Y3C7cuQUhY78o0unuw7vU4hrO71q1dwA@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<56A14AD4.6040608@gmail.com>
	<CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
	<xmqq37tqy3t4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:30:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNkU-0003RV-2V
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 23:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbcAUWaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 17:30:35 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37592 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbcAUWad (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 17:30:33 -0500
Received: by mail-ig0-f173.google.com with SMTP id h5so42599605igh.0
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 14:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YQ6Ar9/jxmuHt1oPt5einAG3LueoryjYNrWXKW6mlD4=;
        b=PRq03DQSBQRT8QfhhxuVGstAguLW3Qh4WFkR1MVkCVpVFgDma4fDW/PDmE1q75kddP
         N6PhD3t7L3H02x1Pg6AaID/ks4lom5IupoPetyUYQYev2bDemfy/ZaL1sjjbOq2X/Q5n
         VJwc2HazqQ/FM1uEyIrmk/RUn1Urua6dzyYx3M5D4eKDjWONQ9X41uj4IFDE9ufw34yO
         CgF5dVdrrqsXUnWcDTFm8JPTM/SgZMR+2p+hOtMNtsV25shYS17dzz5V8yTEaSeeqB2X
         Urunq86GVaahpQPlMGp5ACx4KHnee9yLxTgbxLXMDhp74MW5G51RwAA3ZebxWUUiJNgT
         Kz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YQ6Ar9/jxmuHt1oPt5einAG3LueoryjYNrWXKW6mlD4=;
        b=Vr+/b4L3KxX2ltUy5Kz4vUoNMaz/B7mag9W49aQJUUnrXuG60+94N+Dnvu4CnxdSLX
         l4sYIyUjDtnYl+3uqEm/3y++abodvvnhjI8FIwOsGigXWHJ6m0nuELEu0SusA9gcT6qP
         XSJcZotiIHDHCCd2umcYnHGkcDpqUa9edWesvvcYfRayiDhbh55q66efHRNwEsN4PnGz
         oJmBW6t9yWGm/mcr7VbGo3BTMTU5fZBOmfF6h8STMOZv6gWMz/tWirvrCEzhngjtThZy
         v8YgbvH6EqLNfx5Se1EGQvvQySvVy3xfR2Fwq8ZmNnRKw67WX4F3D/C77kC9EsOCjH97
         P6BA==
X-Gm-Message-State: AG10YOQGhnYzagEp8253MQCMoVjRHn0kKyDQLJNjYQbC4eaWgbh6ydhDjrib0ER5BzFqqJloUbT+Vk6Zg3/r65Ti
X-Received: by 10.50.59.147 with SMTP id z19mr46904igq.93.1453415433161; Thu,
 21 Jan 2016 14:30:33 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 21 Jan 2016 14:30:32 -0800 (PST)
In-Reply-To: <xmqq37tqy3t4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284537>

On Thu, Jan 21, 2016 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Instead of having a submodule -> set assignment, we could do it the
>> other way round:
>>
>>      [submodule "gcc"]
>>          ...
>>
>>      [submodule-set "default"]
>>         submodule = gcc
>>         submodule = foo
>>         submodule = by/path/*
>>
>> This may be more handy from our perspective (while designing it and
>> writing the code),
>> but I'd assume this is less useful for the user. How often does a user ask:
>> "How many/Which submodules are in $GROUP" as opposed to "What about
>> submodule foo,
>> is that part of group $GROUP?"
>
> I suspect that we will end up needing to support both styles.

I think having both is bad as it may contradict each other?
What is supposed to happen here:

     [submodule "frotz"]
         group = default

     [submoduleGroup "default"]
         member = !:frotz

Initially I disliked your proposal of : and * to indicate name and groups,
but the example you gave is very clear and understandable on the syntax level.

>  The
> latter style is easier when you want to express a larger set as a
> collection of groups, e.g.
>
>     [submodule "gcc"]
>         group = development-tools
>
>     [submodule "emacs"]
>         group = editors
>
>     [submodule "frotz"]
>         group = games
>
>     [submoduleGroup "default"]
>         member = *development-tools
>         member = *editors
>         member = :frotz
>         member = !*xyzzy
>
> might be a way to say "the default group includes everything in the
> 'development-tools' or 'editors' group, plus 'frotz' module, but do
> not include modules in the xyzzy group" or something like that.

> I forgot to say that I personally do not think we need to support
> such synthetic groups from day one.

So groups of groups, we discovered recursion today. :)
Having this discussion makes me realize, the groups handling logic
will be more complex than I anticipated for the first RFC patch series.

The two basic questions the logic has to answer is:
 * Give me all the submodules that fit these specifiers (i.e. the
    --init-submodules collection from clone)
 * Given submodule X, does it fit the specifier ( a new uninitialized
    submodule during a later update)

The second question can be answered by answering the first question
and then checking if X is in the set. However that may be not the most
efficient solution.
