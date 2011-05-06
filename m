From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 6 May 2011 16:20:24 +1000
Message-ID: <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 08:20:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIEOt-0001L3-Jj
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 08:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1EFGU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 02:20:26 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38408 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab1EFGUZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 02:20:25 -0400
Received: by vxi39 with SMTP id 39so3100503vxi.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xqZg9LzIzUvbAwiBUH0E+l9zNM0kAoaYwj+x7Y/y6DE=;
        b=aoHkuPL+jIASuFZcy28C4ByNoW5J5TmTpvf8Hf2eI1TnZ3wB4Dm19g8t7wWHUep3Zb
         dUNePCIM2G173ae2RDJLy1UJGKxOI4jc9SzNQ+DNZYYMDYDi7K4Yn8FpU8qGsqxzNCFZ
         gF1zalGdn1cHT4yT4Siqm4ywjdyYnnJKtR5nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Nlk4jkuzWaKaom0nPR7xVXiTRk0jnRncgan7kvN4aFxkaSEJXtMUOcZyqiT1EmpxzV
         fIMlOA1g/YqB+XMt0Zb4BvhJFm++b/trfaLK3jnq+Eoeo/60ZNnQP8P5AVfAT9RaMa+G
         xqTl8q/n7BVB59r5GIXi2y3prZPtRmKP29UD4=
Received: by 10.52.71.148 with SMTP id v20mr327630vdu.266.1304662824480; Thu,
 05 May 2011 23:20:24 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Thu, 5 May 2011 23:20:24 -0700 (PDT)
In-Reply-To: <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172945>

On Fri, May 6, 2011 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon Seymour <jon.seymour@gmail.com> writes:
>> It would be good if something like:
>>
>>     unzip -d $(git --plugins-dir) foobar.zip
>>
>> installed scripts, info files and man pages into a place where git
>> would find them and then have git foobar start working without any
>> additional effort by the package author or user.

> That should be doable without any elaborate "plugin management".  We =
only
> need to enhance the git potty and help system to look for things in a=
 set
> of new directories, and have these unzip installation put their stuff
> there.

I do agree - plugin management is superfluous to current requirements.

>>>
>>> *1* I admit that I didn't read all of them carefully, as I was repe=
lled by
>>> them as soon as I saw phrases like "for people who can grok this co=
ncept".
>>
>> Junio: at least quote me accurately. I actually wrote:
>>
>> "Contributors who grok the concept as I conceive it are welcome to
>> submit pull requests."
>>
>> I am a little mystified why use of the word "grok" in this way, give=
n the
>> circumstances, caused you to be "repelled".
>
> What repelled me was not any particular word (and that is exactly why=
 I
> did not even bother to "quote") but your general attitude in the
> discussion. =C2=A0Your tone throughout the discussion appeared at lea=
st to me
> that you thought anybody who did not agree with you was incapable of
> understanding something so obvious and clearly right, and only those =
who
> could "grok" it deserved to join the discussion. =C2=A0We occasionall=
y have
> seen such people on this list in the past, but luckily not very often=
=2E
>
> I am not saying that your thinking should always start from "I could =
be
> wrong". =C2=A0However, I do not think "What is so hard about the conc=
ept ...?"
> is the question you should be asking others before asking yourself "I=
s
> there a better way I could have explained this idea I want others to =
agree
> with? =C2=A0The reason why they are still not on the same page as I a=
m could
> well be because all of them are morons, but it may be possible that i=
t is
> because the way I have explained my idea to them was not optimal. =C2=
=A0Perhaps
> I did not present the motivation and the background well enough to ju=
stify
> that the problem I am trying to solve is worth solving, before throwi=
ng my
> idea on how to solve it".
>
> After all, different people have different needs and expectations. =C2=
=A0The
> discussion on a particular _solution_ can only start after you get pe=
ople
> on board and share the sense of _need_ to solve something common.
>

Ok, well thanks for taking the time to explain what you really meant.

I agree that I have come across as arrogant; I reacted badly to what I
considered to be insults being heaped in my direction by some.
However, I did myself and my ideas no favors by treating such
criticism with the public disdain that I did.

I also agree that I did a lousy job explaining the concepts let alone
convincing others of their merits.

=46inally, I agree that it would be more productive for me to be more
sensitive to what is agreed to be a common need and to try to restrict
my proposed solutions to exactly those needs.

I would appreciate any feedback you (or others) have about:

    http://permalink.gmane.org/gmane.comp.version-control.git/172419

In particular, I would be interested in feedback about how to best supp=
ort:

- multiple extensions - do we want support installing extensions in
their own directories, per Pau's suggestion or simply allow them to
write to a common directory?
- multiple extension directories - how to support Jonathan's
requirement to allow user specific extension directories?

I have some ideas about how to do this which I will propose in a patch
over the next few weeks, but any input I have now would be useful.

Regards,

jon.
