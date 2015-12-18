From: Christian Couder <christian.couder@gmail.com>
Subject: Fwd: [PATCH 7/8] config: add core.untrackedCache
Date: Fri, 18 Dec 2015 23:38:35 +0100
Message-ID: <CAP8UFD2=hGbUFg_wX-0r6QgW+44ZiX8iJPX5c1FGG-4H8i163A@mail.gmail.com>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	<xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
	<CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
	<xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
	<20151216024605.GA618@sigill.intra.peff.net>
	<xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com>
	<xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
	<20151217074443.GA4830@sigill.intra.peff.net>
	<CAP8UFD0LAQG+gQ5EhYYLjo5=tpW3_ah6GV-mgRbgTjjgNmdorA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 23:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA3fe-0004us-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 23:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbbLRWii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 17:38:38 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35196 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbLRWih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 17:38:37 -0500
Received: by mail-lf0-f52.google.com with SMTP id l133so81055876lfd.2
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lPF3LRt0NQ5ppiX6ZWAJm/OZQDZYDSyWUDLV/gvlYlM=;
        b=vSRdl4mZzRaOwCv071OX1HwRt8SP9TzrQWg3FmVZ9WFA0xLXdpYAVa48mLbG/RCTaT
         M0OWEyrd8V7oBsT/i83Y1AN1bbqxEEpgezBwZrEyw2ztO9syAHeb3AnSiwYk3Dkg7iuu
         0Fc3UB8HjhRkAvAjnSVzrcxzI8Nds+lfA7ufoNI4nnUFcmPWbdPwiX2gFyw2t8kknvBr
         nO20rh7jqQ2BWOZtLPJ8wuV14NME5yiQmp9erJDXcfmBw4+u0NAdao1ym7tPP2FVmq33
         wL7nMiTI2AM+jVC93cVpfTK1ctX1PY64ODUu1LCIs37yiMGTqZPYnNQ7JCOWjwCFEFwO
         4AVA==
X-Received: by 10.25.163.85 with SMTP id m82mr2425464lfe.76.1450478316041;
 Fri, 18 Dec 2015 14:38:36 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Fri, 18 Dec 2015 14:38:35 -0800 (PST)
In-Reply-To: <CAP8UFD0LAQG+gQ5EhYYLjo5=tpW3_ah6GV-mgRbgTjjgNmdorA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282717>

Sorry I sent this privately to Peff by mistake (once again).

---------- Forwarded message ----------
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, Dec 18, 2015 at 11:09 PM
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
To: Jeff King <peff@peff.net>


On Thu, Dec 17, 2015 at 8:44 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 15, 2015 at 10:05:57PM -0800, Junio C Hamano wrote:
>>
>> To put it another way, the "bit" in the index (i.e. the presence of
>> the cached data) is "Am I using the feature now?".  The effect of
>> the feature has to (and is designed to) persist, as it is a cache
>> and you do not want a stale cache to give you wrong answers.

Sorry if I repeat myself or misunderstood something, but in what I
implemented we either use the UC fully or we remove it, so it cannot
be stale vs git operations (like other changes in the index Duy talks
about).

And as we are caching directory mtimes and as we are comparing each
cached mtime with the current mtime of the original directory before
trusting the cached content related to the directory, a UC that is
stale vs working tree operations could result in time lost but not in
bad cached content used.

Or maybe if we are very unlucky and have two directories with exactly
the same mtime and the same name but not the same content, and if we
move away the directory the UC was made from, and then put the other
one at the path where the first one was. Yeah in this case you may get
bad results because bad UC content is used. But note that this case
can already happen now. It is a case that is inherent in using the UC.

>> There
>> is no "Do I want to use the feature?" preference, in other words.
>>
>> And I do not mind creating such a preference bit as a configuration.
>>
>> That is why I suggested such a configuration to cause the equivalent
>> of "update-index --untracked-cache" when a new index is created from
>> scratch (as opposed to the case where the previously created cache
>> data is carried forward across read_cache() -> do things to the
>> index -> write_cache() flow).  Doing it that way will not have to
>> involve additional complexity that comes from the desire that
>> setting a single configuration on (or off) has to suddenly change
>> the behaviour of an index file that is already using (or not using)
>> the feature.
>
> I think we may actually be thinking of the same thing. Naively, I would
> expect:
>
>   - if there is untracked cache data in the index, we will make use of
>     it when enumerating untracked files (and my understanding is that if
>     it is stale, we can detect that)

I agree for "git status", but I am not sure that the UC is used in all
the code paths that enumerate untracked files.
I recall Duy mentioning that it was not used by "git add" and in some
other cases, but I might be wrong.

I also agree that we can detect when the UC content should not be used
because it is stale vs working tree operations (see above).

Now as Duy says the UC should never be stale vs git operations, but
that is easy to do if we just remove the UC when we stop using it.

>   - if core.untrackedCache is set, we will update and write out an
>     untracked cache when we are enumerating the untracked files

In the current patch this happens when "git status" is called,
actually in wt_status_collect_untracked(), again I am not sure about
all the other code paths.

>   - if there is cache data in the index but that config flag is not set,
>     presumably we would not update it (we could even explicitly drop it,
>     but my understanding is that is not necessary for correctness, but
>     only as a possible optimization).

In the current patch we drop the UC, also in
wt_status_collect_untracked(), if the config flag is not set (or set
to false).

It is necessary to drop it for correctness for the following reasons:

- git operations on (other parts of) the index must update the UC if
it exists according to Duy who gave the following example in a
previous email:

"... if file "foo" is tracked, then the user does "git rm --cached
foo", "foo" may become either untracked or ignored. So if you disable
UC while doing this removal, then re-enable UC again, "git-status" may
show incorrect output."

- the user may have decided to unset the config flag because the mtime
features we rely on are in fact not well supported by the system.
(Though it's true that the user should have used "git update-index
--test-untracked-cache" before setting the config flag in the first
place, but maybe it was a mistake, or maybe the file system will be
accessed for some time by another system that will mount it or
something.)

> You could have a config option for "if there is a cache there, pretend
> it isn't and ignore it", but I don't see much point.

There is not much point indeed in such an option and it could be dangerous.
