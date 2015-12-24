From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Thu, 24 Dec 2015 21:54:59 +0100
Message-ID: <CAP8UFD2riDWmK64UWHyg61YyxLVEmT8d_5qzM7U+Bs-9qCv0mA@mail.gmail.com>
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
	<CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
	<xmqqy4cnfyds.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AF-7ULixapHmTtCia9x0HTtJ1nmnAER9A3BeLVjQM_Mg@mail.gmail.com>
	<xmqqh9jae94o.fsf@gitster.mtv.corp.google.com>
	<xmqqio3obody.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 21:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCCum-0005Dz-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 21:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbbLXUzE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Dec 2015 15:55:04 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32792 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbbLXUzB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Dec 2015 15:55:01 -0500
Received: by mail-lf0-f49.google.com with SMTP id p203so168953781lfa.0
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dgrbSmqx2IU4glK4RtyYTEDq2kvKl82xT1lvyAFmJgg=;
        b=P37f1bXlSM8rzdAwM8O7fF+f9SudDmWvf3IdHtnEarNfCrGsXZnihTgO2nrMOJwG7X
         B9YL3QTHkh0iUS8ruVKlAdvwMagyiyz+GmVsvTyb9YwroR+2FA4NTWAoxcpgRQA4KlHq
         jLLxKo6HAFBsmpbMASqn+8vIBYDoXoJ3R3vA5+9FBQxwbDPUf+Mv2iGCkjTDillXBxJu
         aiG9lYwkheoSXNPYWY/22WduNVYkiSmPe0PdbDJuBCHkfA0LEvUGgv+u0cykr2QnXsF1
         7SZ7XdAmmtFLVOhJEylSK4GQunN4yb1IzbgZ2expg6ZmXjEHxJCU6sP3s2SUEVsH9bMq
         N05w==
X-Received: by 10.25.22.14 with SMTP id m14mr3068636lfi.124.1450990499584;
 Thu, 24 Dec 2015 12:54:59 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Thu, 24 Dec 2015 12:54:59 -0800 (PST)
In-Reply-To: <xmqqio3obody.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282981>

On Thu, Dec 24, 2015 at 2:56 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> In that case we can just check config once in read_index_from and
>>> destroy UNTR extension. Or the middle ground, we check config once =
in
>>> that place, make a note in struct index_state, and make invalidate_=
*
>>> check that note instead of config file. The middle ground has an
>>> advantage over destroying UNTR: (probably) many operations will tou=
ch
>>> index but do not add or remove entries.
>>
>> Or we can even teach read_index_from() to skip reading the extension
>> without even parsing when the configuration tells it that the
>> feature is force-disabled.  It can also add an empty one when the
>> configuration tells it that the feature is force-enabled and there
>> is no UNTR extension yet.
>
> Thinking about this a bit more, I am starting to feel that the
> config that can be used to optionally override the presence of
> in-index UNTR extension does not have to be too bad a thing,
> provided if it is done with a few tweaks to the design I read in
> Christian & =C3=86var's messages.

Great!

> One tweak is to address the following from =C3=86var's message:
>
>>> Once this series is applied and git is shipped with it existing
>>> users that have set "git update-index --untracked-cache" will have
>>> their UC feature disabled. This is because we fall back to "oh no
>>> config here? Must have been disabled, rm it from the index" clause
>>> which keeps our UC from going stale in the face of config
>>> flip-flopping.
>
> The above would happen only if the configuration is a boolean that
> defaults to false.  I'd think we can have this a tristate instead.
> That is, config.untrackedCache can be explicitly set to 'true',
> 'false', or 'keep'.  And make a missing config.untrackedCache
> default to 'keep'.

Ok. The first RFC patch series about this had a tristate and I
switched to a boolean as it seemed that people prefered a boolean, but
you are right that a tristate is more backward compatible.

> When read_index_from() reads an existing index:
>
>     When the configuration is set to 'true':
>         an existing UNTR is kept, otherwise a new UNTR gets added.
>     When the configuration is set to 'false:
>         an existing UNTR is dropped.
>     When the configuration is set to 'keep':
>         an existing UNTR is kept, otherwise nothing happens.
>
> When write_index() writes out an index that wasn't initialized from
> the filesystem, a new UNTR gets added only when the configuration is
> set to 'true' and there is no in-core UNTR already.

My current patch series does these changes in
wt_status_collect_untracked() because currently the UNTR is mostly
used only in git status, so it feels safer to me to not affect other
code paths.

> That way, those who use /etc/gitconfig to force the feature over
> their users would be able to set it to 'true', those who have been
> using the feature in some but not all of their repositories won't
> see any different behaviour until they muck with the configuration
> (and if they are paranoid and want to opt out of their administrator'=
s
> setting, they can set it to 'keep' in their $HOME/.gitconfig to make
> sure their repositories are not affected).
>
> Orthogonal to the "config overrides the existing users' practice"
> issue, I still think that [PATCH v2 10/10] goes too far to remove
> the safety based on the working tree location.  Checking kernel
> version and other thing may be too much, but the check based on the
> working tree location is a cheap way to make sure that those who do
> unusual things (namely, use $GIT_DIR/$GIT_WORK_TREE or their
> equivalents to tell Git that the working tree for this invocation is
> at a place different from what UNTR data was prepared for) are not
> harmed by incorrectly reusing the cached data for an unrelated
> location.  So another tweak I'd feel better to see is to resurrect
> that safety.

This has been changed in v3, see patch 09/11, and I think it should
now work as you suggest.

> I wouldn't have as much issue with such a scheme as I had with the
> earlier description of the design in the Christian's series.

Great! I am preparing a v4 that I hope to send in a few days.
By the way the v3 does not pass its own tests due to a bug introduced
in last minute changes.

Thanks,
Christian.
