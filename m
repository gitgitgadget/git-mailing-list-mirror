From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sun, 16 May 2010 17:37:34 +0000
Message-ID: <AANLkTinGSBRMRyaD0w2p9PQELLA6ThvKFdi6hcNWBTxr@mail.gmail.com>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
	 <m3pr0wd880.fsf@localhost.localdomain>
	 <AANLkTikgs3d1YagU5lRCkEM9uwWe9dmifbHvIjhsk_wF@mail.gmail.com>
	 <20100516160800.GB22447@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 16 19:37:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODhme-0005sS-7I
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 19:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416Ab0EPRhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 13:37:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44867 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0EPRhg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 13:37:36 -0400
Received: by fxm6 with SMTP id 6so3041718fxm.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lbL8bJ46mrIvJzgKFl68mIw2k8/ZmBnFL/X7H9btfb4=;
        b=vTcBIZPV0NdFTwcYx0SCaroILhMQfMqXE83xMNT7O8osnI8iShcK4D13EZCwmmhSNn
         FdKc87g/RZ/NnKBNnB4WM5jUKHgp+tcWxeFLUlrtuC8rsP+NYMC5lMbISEQbhh+LdiBU
         JGLSFJ1gudReS1Gv0/kMzY33txi5hXKCb7g34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N7t22nuNo17oK86bupNfzs3WeF3fqQNS2z3xT7NjKXB2r5al5KYOPm7Vr8uK9Xe87e
         IqLSYWjaLeweAt0LK8072QzgfQp2RnzkObDHHAOb0NkY54esKwi6N1xzS/y6yLZOQYu+
         5IR5ikGazxVSLudfSXScwgLUR3kD5LudaS1RI=
Received: by 10.223.92.144 with SMTP id r16mr4989201fam.62.1274031454605; Sun, 
	16 May 2010 10:37:34 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Sun, 16 May 2010 10:37:34 -0700 (PDT)
In-Reply-To: <20100516160800.GB22447@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147197>

On Sun, May 16, 2010 at 16:08, Jan Hudec <bulb@ucw.cz> wrote:
> On Sun, May 16, 2010 at 01:12:20 +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> On Sun, May 16, 2010 at 00:03, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> >
>> >> I couldn't find anything about this in the list archives. Have th=
ere
>> >> been any discussions of adding internationalization support to Gi=
t
>> >> itself? I.e. the interface messages that the core Git utilities e=
mit.
>> >>
>> >> I tried to get started with integrating GNU Gettext, but gnuish
>> >> assumptions it makes about building make it a bit hard.
>> >>
>> >> Is there perhaps another gettext implementation that would be mor=
e
>> >> suitable for Git?
>
> Gettext iself does not make any assumptions about building. It's only=
 it's
> manual that gives more space to setting up gettext use with autotools=
 than
> manually. But doing it manually is really not too hard.
>
> Basically one just needs to set up scripts or makefile targets to:
> =C2=A0- Re-generate the translation template (.pot)
> =C2=A0 All this takes is invoking xgettext with correct parameters on=
 the right
> =C2=A0 list of files. It might be necessary to invoke it with differe=
nt arguments
> =C2=A0 for sources in different languages if git needed to use non-de=
fault
> =C2=A0 options, but I think the defaults would be ok.
> =C2=A0- Update the translations with new strings from the template.
> =C2=A0 All this takes is invoking msgmerge for each .po file with the=
 appropriate
> =C2=A0 template.
>
> Than makefile targets are needed to generate and install the .mc file=
s, but
> that's just trivial.
>
> I don't think the automake support saves any work there. It saves you=
 from
> learning the tool invocations, but you have to learn automake instead=
=2E
> The hardest part is makring all the translatable strings in the code =
and
> the gnuish infrastructure just isn't much help there anyway.

Right, someone has to come up with all the makefile / build magic one
way or another.

I'm just really not familiar with that side of things, which was why I
asked if someone had tried it already.

Is someone on-list familiar with a non-GNU program that does all its
gettext support manually, i.e. not with the gnu autotools?

I'm not, examples would help :)

>> All of these languages can read gettext, but you'd need some glue fo=
r
>> each so that they could get to the files.
>>
>> It would probably make the most sense to have distinct message files
>> for each program, e.g.:
>>
>> =C2=A0 =C2=A0 /usr/share/locale/*/LC_MESSAGES/git-bisect.mo
>>
>> That way they could be translated incrementally, and the programs
>> would load only the small subset of messages they need.
>
> I think it would make things more complicated and not really help any=
thing,
> since many messages may in fact be shared or come from common parts s=
o it
> would need to be loaded by many commands anyway. On the other hand th=
e .mc
> file is an external hash, so the access even to a large .mc will be q=
uite
> fast.

Right, squashing them all into one .mo file may be the best thing,
particularly, as you mention, for the case of displaying messages from
more than one tool.

That might mean message collisions, but that can be solved these days
with gettext's msgctxt.

> It would definitely not be fine to break *git*. You need to make sure=
 no
> part of git itself or anything distributed with it (gitk, git gui, gi=
tweb,
> things in contrib) is looking for any string that might be broken by
> translating.

Of course internal breakage, i.e. git-foo parsing the output from
git-bar breaking under non-English is unacceptable. I meant that
external tools now running under some non-English locale may start
breaking if they're parsing the output and assuming English. The
remedy for that is easy though, just prefix the calls to git with
LC_ALL=3DC.
