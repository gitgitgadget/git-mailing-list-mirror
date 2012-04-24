From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 15:04:51 -0700
Message-ID: <CAE1pOi3=wu_9kmVimvAQjq+O6xUpEbEdnQ4qgeM2SAO7TwD0Mw@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
	<nnghaw93v8n.fsf@transit.us.cray.com>
	<CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
	<CAJsNXTmk_A1NxR3ZcuEkEcX-+LyWPq2yY0mdDwAfVLX=Eg9coA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dag@cray.com, Git Users <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:05:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMnqz-0005Mr-DH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757876Ab2DXWEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 18:04:53 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46597 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015Ab2DXWEw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 18:04:52 -0400
Received: by ghrr11 with SMTP id r11so793746ghr.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GHHkFbbH0S73YiBJdy3xpPxGu/IrRMTvzmrzcQ/+jhA=;
        b=Dlo7LnwzxX6GPzmkUgMA4ii1BEAsjg+kv1d9OvH8zzCBVg9W6H3Rtkc+xsChF+wzEs
         A2w10EXEmV3dg2UJ3watmywgkUlxXR2r4PvSKiNop0+pDOhxmkRsTN2+07sEvJK9L0Bf
         wLlzj2J9BNIIHf1OhEw6BVKJwcwtIKGvGwWCEanMWegDyw3+68+/QCM7gakx32Ry94le
         NRZq8V16tTeh8lO+bhH4cFjLaz02juyN/rBEagW7LKannlYx7yfSKVJloKMoGu41bOxM
         /fW/j5NX22ahumMRMuz0JaTDw1gMB9FZsWKSSa0nt6y3iR1oX1m1Ucpf1TzQxKq63BX1
         HwCQ==
Received: by 10.236.145.104 with SMTP id o68mr158699yhj.74.1335305091481; Tue,
 24 Apr 2012 15:04:51 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 24 Apr 2012 15:04:51 -0700 (PDT)
In-Reply-To: <CAJsNXTmk_A1NxR3ZcuEkEcX-+LyWPq2yY0mdDwAfVLX=Eg9coA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196254>

On 24 April 2012 14:09, PJ Weisberg <pj@irregularexpressions.net> wrote=
:
> On Tue, Apr 24, 2012 at 11:54 AM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> On 24 April 2012 10:17, =C2=A0<dag@cray.com> wrote:
>>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>>
>>>> I'm assuming that if you have subproject S in umbrella project U a=
nd a
>>>> branch "topic" in U then that same branch should exist in S.
>>>
>>> No, I think that is actually very rare. =C2=A0If topic branches rea=
lly should
>>> be mirrored then U and S should be one repository. =C2=A0They are t=
oo closely
>>> coupled to be separated. =C2=A0But see the but about git-subtree an=
d topic
>>> branches below.
>>
>> Too closely coupled? I do not think breaking up a project into a set
>> of libraries makes everything tightly coupled. I would argue the
>> opposite. :-) Anyway, you answer my concern below.
>
> Indeed. =C2=A0But when you make a branch in your main project, wouldn=
't you
> usually still want to use the master branch of the libraries?

=46or those that haven't changed? Sure. I just (incorrectly) assumed
that if I had a topic branch in the umbrella project I would need
topic branches in all repos as well, otherwise I would end up with
changes in both various masters and my topic branch. Too much exposure
to submodules, I suppose. :-) But subtree works around that quite
nicely so it really doesn't matter. I simply made one too many
assumptions. :-)

Similar answers to everything below.

> Or if
> there's an experimental branch in a library and you want to use that
> branched version, wouldn't you still use the master version of all th=
e
> other libraries? =C2=A0What if you have two projects that both use a
> library, but are otherwise unrelated? =C2=A0If you create a branch ca=
lled
> 'hotfix' in one project, do you automatically find your library
> version switching to an unrelated 'hotfix' from another project?
