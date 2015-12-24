From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Thu, 24 Dec 2015 16:49:15 +0700
Message-ID: <CACsJy8AO0BumZQmwWNVHL-viGLY=ExE3syJOt1h75zeQug95mQ@mail.gmail.com>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
 <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com> <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
 <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com> <20151216024605.GA618@sigill.intra.peff.net>
 <xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com> <xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
 <20151217074443.GA4830@sigill.intra.peff.net> <CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
 <xmqqy4cnfyds.fsf@gitster.mtv.corp.google.com> <CACsJy8AF-7ULixapHmTtCia9x0HTtJ1nmnAER9A3BeLVjQM_Mg@mail.gmail.com>
 <xmqqh9jae94o.fsf@gitster.mtv.corp.google.com> <xmqqio3obody.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 10:49:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC2Wx-0001eM-Tn
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 10:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbbLXJtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Dec 2015 04:49:50 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33093 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbLXJtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Dec 2015 04:49:47 -0500
Received: by mail-lb0-f171.google.com with SMTP id sv6so51430349lbb.0
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=i7usjQGk2zqx2QKowGheKByERAADU4PNe0mU8ef+IpQ=;
        b=l9x8l6DV7JlHMxZhR3/NE+p0b+pSwwxhxM2o/Pj/0uSopfevlGG8FiQAGSDn1ZeCk0
         1RT3cKxrsHbvsxPXnR/uBCKqRobnDxT5+xPJa1FEvJS1BALVx7r/JDBNLPwOVyRlRm+d
         jtFUMnH8OenqJpPJkql4jSCtlADe/O3f36NbZfIpb2AOkew7PlBthWVruQmGuSSIIdWb
         zhmRTUo3QNnnxU6J2IUd+kl1xesZgH/uqVrZJ8Qbq9o3iU4dt6dY1S2abKMu3x0eUfA+
         MMBsvvayF1CRJEKUhgB00F3qlscGjB1tOTUp3NfKX74xlt6aQA8RvmkzdlKHryYXPpEP
         g+zw==
X-Received: by 10.112.168.70 with SMTP id zu6mr11821632lbb.26.1450950585404;
 Thu, 24 Dec 2015 01:49:45 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 24 Dec 2015 01:49:15 -0800 (PST)
In-Reply-To: <xmqqio3obody.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282977>

On Thu, Dec 24, 2015 at 8:56 AM, Junio C Hamano <gitster@pobox.com> wro=
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
>
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
>
> When read_index_from() reads an existing index:
>
>     When the configuration is set to 'true':
>         an existing UNTR is kept, otherwise a new UNTR gets added.
>     When the configuration is set to 'false:
>         an existing UNTR is dropped.
>     When the configuration is set to 'keep':
>         an existing UNTR is kept, otherwise nothing happens.

Sounds good, except..

> When write_index() writes out an index that wasn't initialized from
> the filesystem, a new UNTR gets added only when the configuration is
> set to 'true' and there is no in-core UNTR already.

Do we really need this? If the index is created fresh from the core,
first write will not have UNTR. Next time it's loaded up, UNTR is
added if config is true, based on the above rules. The new UNTR
extension (should?) marks the index as dirty as writing out is
required.

> Orthogonal to the "config overrides the existing users' practice"
> issue,

Yeah it looks orthogonal to me too. There should be a separate config
file like /etc/gitconfig.lockdown, that will override user config vars
(but we still can't undefine user config vars yet, known missing
feature).
--=20
Duy
