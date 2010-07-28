From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Possible feature request for merge and pull
Date: Wed, 28 Jul 2010 16:55:03 -0400
Message-ID: <AANLkTimXe1SYiVONTnN_4e1ieAKNHgKwJ7fBOYjL-CUE@mail.gmail.com>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com>
	<AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com>
	<AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 22:55:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeDeh-0003go-NC
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 22:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab0G1UzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 16:55:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43054 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab0G1UzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 16:55:05 -0400
Received: by pzk26 with SMTP id 26so2009323pzk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 13:55:03 -0700 (PDT)
Received: by 10.142.191.14 with SMTP id o14mr6557070wff.208.1280350503340; 
	Wed, 28 Jul 2010 13:55:03 -0700 (PDT)
Received: by 10.229.236.2 with HTTP; Wed, 28 Jul 2010 13:55:03 -0700 (PDT)
In-Reply-To: <AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152120>

Avery,

On Wed, Jul 28, 2010 at 4:49 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Wed, Jul 28, 2010 at 3:34 AM, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Wed, Jul 28, 2010 at 01:24, Bradley Wagner
>> <bradley.wagner@hannonhill.com> wrote:
>>> I would love to be able to use the -m flag and --log together with =
git
>>> merge and pull to be able to create a custom commit message but als=
o
>>> include one-line summaries of each of the commits being merged/pull=
ed.
>>
>> This sort of thing has vaguely come up before, and it was mentioned
>> that you can just use a small script that calls git-filter-branch or
>> git-rebase -i.
>>
>> It's easy to rewrite the commits you just pulled, having some featur=
e
>> that e.g. adds a custom message to the beginning of each of them wou=
ld
>> just impose an artificial limitation and overlap with existing (and
>> more powerful) functionality.
>
> If I understand correctly, the request is not to rewrite the pulled
> commits, but just to produce a nice message in the newly-created merg=
e
> commit.

Yes, that's correct.

> It sounds like --log and -m are currently incompatible, in that -m
> overrides --log, and that's not the desired behaviour.

Correct, I can't remember which overrides which but basically it's as
if you just used one of them. Also, git pull doesn't appear to take a
-m flag at all.

>=A0Bradley: this
> is probably a relatively easy fix to make, in case you're looking to
> get into some git hacking. :)

Nice, I may check that out.

>
> Have fun,
>
> Avery
>



--=20
Hannon Hill - Put Us to the Test
bradley.wagner@hannonhill.com | http://www.hannonhill.com
