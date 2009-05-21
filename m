From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 18:47:05 +0300
Message-ID: <94a0d4530905210847o697dd1f9w2f6ffcb8a109f0ca@mail.gmail.com>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
	 <20090507072326.GA13123@vidovic>
	 <7veiv0cvdt.fsf@alter.siamese.dyndns.org>
	 <20090508042814.GA30031@vidovic>
	 <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com>
	 <20090514160609.GA12910@vidovic>
	 <7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
	 <20090521041529.GD8091@sigill.intra.peff.net>
	 <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>
	 <20090521131802.GA13840@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu May 21 17:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7AUI-0004aq-NW
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 17:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbZEUPrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbZEUPrK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 11:47:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:63735 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbZEUPrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 11:47:09 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1352362fga.17
        for <git@vger.kernel.org>; Thu, 21 May 2009 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v9TZBO4EoQgxLM4fVAtFkuqfgpBKojxLdAJr5be31Gs=;
        b=LAXUv4kkiuzmVz451tT1SVpRW4CyAtl6G7JWucRx8f2OVE/RCFonyaRn1ruGvYppnv
         rNZ4Oujru0f1t1Nu90spNproYAXGzl1zV0NKHy2KDbZT/UI4BMcRjU6dXb87VPyHi9UM
         UzWSKAv4BceX4AVQaTs4sVVRwA/X4c/5b4E/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=adB7b0fnJE8lTZXNo9JMeUH3EbXpXn7SdqVJNh4hfUzWpaoQxG+pDyDO1c8SXqAnpF
         ApMmtxBp1VPAfH4IT1UJJ8tayV1piF3Bw6i0oAQQUjxuszvFtCJqZykOVoyBucDfUR7S
         d2UERpQOrvbDczXwRp/VODfAWFG6cAxc4SUmA=
Received: by 10.86.33.9 with SMTP id g9mr2279472fgg.66.1242920825679; Thu, 21 
	May 2009 08:47:05 -0700 (PDT)
In-Reply-To: <20090521131802.GA13840@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119692>

On Thu, May 21, 2009 at 4:18 PM, Nicolas Sebrecht <nicolas.s.dev@gmx.fr=
> wrote:
> The 21/05/09, Felipe Contreras wrote:
>> On Thu, May 21, 2009 at 7:15 AM, Jeff King <peff@peff.net> wrote:
>> > On Wed, May 20, 2009 at 06:33:36PM -0700, Junio C Hamano wrote:
>> >
>> >> >> http://people.freedesktop.org/~felipec/git/user-manual-general=
-improvements/
>> >> >
>> >> > Thank you very much Felipe to take the time to upload the patch=
es there.
>> >> > I already have a copy there and I'll look at it soon.
>> >>
>> >> Has anybody looked at this? =C2=A0It's a bit large-ish and touche=
s all over the
>> >> place, so I am finding it a bit hard to concentrate on it myself =
really
>> >> nitpicking, but from the cursory look after formatting the result=
 looked
>> >> Ok.
>> >
>> > I started to, but the first commit message is lacking something th=
at I
>> > think would make reviewing much simpler: what are the general clas=
ses of
>> > changes that are being made?
>> >
>> > I see some doublequotes becoming backticks, and some becoming sing=
le
>> > quotes. And some becoming tex-quotes (``...''), and even some beco=
ming
>> > doublequotes _with_ single quotes. It would be easier to verify th=
at
>> > they are doing the right thing if the commit message briefly descr=
ibed
>> > the rules it followed for changing each one. I think they are some=
thing
>> > like:
>> >
>> > =C2=A0- tex-quotes if it was really a prose-style quotation
>> >
>> > =C2=A0- backticks (causing monospace) for branch names, commands, =
etc in
>> > =C2=A0 =C2=A0prose
>> >
>> > but that leaves me confused. Some things which I thought should be=
 in
>> > monospace backticks are in single-quotes (causing emphasis). Like
>> > 'master' or 'linux-2.6'. And some things are emphasized and in dou=
ble
>> > quotes in the prose, like '"o"' or '"branch A"'. What is the rule =
to
>> > decide which text should have visible doublequotes but also be
>> > emphasized, as opposed to just having double-quotes or just being
>> > emphasized?
>> >
>> > Maybe this was even discussed earlier in the thread (I didn't go b=
ack to
>> > look), but it should definitely be part of the commit message.
>
> Agreed.
>
>> The rule I followed is: change it to whatever looks best.
>>
>> I followed some guidelines such as: make common text monospace, such
>> as gitk and master. And emphasize whatever needs emphasizing, such a=
s
>> fb47ddb2db. Examples are both monospace *and* emphasized.
>>
>> Sometimes the end result still didn't look good so I just used
>> whatever looked best.
>
> IHMO, "what looks best" is not the best way to enhance the user manua=
l
> because it may be somewhat confusing.
>
> Without being as strict as in the manpages we should have good rules =
to
> display the commands, branch names, etc to the end-users all over the
> manual (think SYNOPSIS). For example, all branch names in the text co=
uld
> be "italic, green, without quotes". Now, in the paragraph "Fetching
> individual branches" we have
>
> =C2=A0will create a new branch named '"example-master"' and store in =
it the
> =C2=A0branch named '"master"' from the repository at the given URL. =C2=
=A0If you
> =C2=A0already have a branch named 'example-master', it will attempt t=
o
>
> where the branch name /example-master/ has two different occurences _=
with_
> and _without_ quotes.

Yes, I wanted delimit "example-master", just like quotation marks are
normally used, but after it has been denoted there's no more point in
doing that over an over.

=46or example:
He referred to his friend as "John". But unlike him, "John" was very qu=
iet.

The quotes make sense on the first sentence, but not on the second.

> This is for the end user part. For the contributers, the commit could=
 say:
>
> " - branch names: uses the form 'branch-name' to appear in green,
> =C2=A0 =C2=A0italic.
> =C2=A0- file names: uses [...] to appear in [...]
> =C2=A0- refspec: uses [...] to appear in [...]
> =C2=A0- etc.
> "

No, asciidoc only has support for: emphazised, strong, monospace,
single-quoted and double-quoted. No colors or anything fancy.

Not all branch names are equal; "master" is not the same as
"mybranch". "master" has a special meaning, therefore it should be in
monospace, but "mybranch" is simply a branch name, therefore it should
be emphazied. If the branch name is complicated you might want to
delimit it with double quotes: "my-fooish-bar-branch", at least the
first time you mention it.

=46ile names is a similar story; ".gitignore" is not the same as "test.=
c".

>> Have you actually looked at the end result?
>
> Yes, I think it's much better with your patch but "display-types" sho=
uld
> follow the same rules all over the text.

I disagree. There are no absolutes when writing human-readable document=
s.

> I'm missing of time theses days. I think I'll could help you in one o=
r
> two weeks I you want. It's an ant work. :-)
> AFAICT, some people here want to rewrite the manual, right? Maybe it
> could be done with this rewriting?

I have a bunch of patches and this was supposed to be the uncontroversi=
al one =3D/

--=20
=46elipe Contreras
