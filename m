From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Wed, 15 Feb 2012 01:14:57 +0200
Message-ID: <CAMP44s2EQX604OQjpBDyHZ2+FMYC8=V=8VBv8wBuviRxpimNXA@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214211402.GC23291@sigill.intra.peff.net>
	<CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
	<7v8vk55a99.fsf@alter.siamese.dyndns.org>
	<CAMP44s0cJroUM2aahRQz2dVPe57XPPOnsxWy+5DfmjXGArz4wA@mail.gmail.com>
	<7vzkcl3u9o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 00:15:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRaS-0003ol-RX
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657Ab2BNXO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 18:14:59 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:48870 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932622Ab2BNXO6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 18:14:58 -0500
Received: by lbom4 with SMTP id m4so229121lbo.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yDA9vdvehQGE0fYw+L/80T5bzb8u041uG9a3SHbNAFA=;
        b=HGsmqr9xOb9sNHD9KhbVVk1+c/PK3cMSedjt5bBX2ueqbovxV79sa9rNx+ArJXKJbl
         R1hAMjwPAdI6ahrTb4xOR/cKJY/rg4/9aywfN3wIByy/W311TOf+bfjrzRkak3mgj3Th
         P+qrTq7uzSIHUn5n+wcGmapf6GhSlnSIBMrsA=
Received: by 10.152.128.230 with SMTP id nr6mr13938582lab.27.1329261297281;
 Tue, 14 Feb 2012 15:14:57 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 15:14:57 -0800 (PST)
In-Reply-To: <7vzkcl3u9o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190794>

On Wed, Feb 15, 2012 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Feb 15, 2012 at 12:18 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>
>> And I don't understand why people want the obvious to be explained.
>
> Has it ever occurred to you the reason why people ask questions to yo=
u is
> perhaps because something that is obvious to you who wrote the patch =
is
> not obvious at all to others? =C2=A0Has it also occurred to you that =
the
> majority of people who need to understand the patch during the review=
 and
> 6 months down the road in "git log" output are not *you*?

Yes, that's why I am still listening. However I have not yet found a
question that cannot be answered from the simple description, except
the one you brought and I agreed to tackle.

I would like to think I have the capacity of empathy, so I would be
able to see if something cannot be inferred from the commit message.
Of course, I might be wrong, but so far the feedback has not been "no,
it's not obvious", but rather " yes, it's obvious... but...".

>> Your new point is "you can add a new thing that we did not have, but
>> it would not result in a good addition if that new thing is
>> irrelevant", but you already know what is the new thing from the
>> summary "'git blame -e' tests".
>
> It is not a "new point". =C2=A0Jonathan, Peff and I all never said th=
at it is
> unclear "what" your patch adds. =C2=A0The suggestions for improvement=
 given in
> this thread were all to explain "why" better.

I have heard both. And the "why" can be easily inferred, at least on
the first patch. The second one I yet have to fix, as I already
replied to you.

>> Everybody seems to assume that a simple commit message =3D bad. I di=
sagree.
>
> If you find *everybody* seems to disagree with you, it would help to
> consider a slight possibility that you *might* be wrong. =C2=A0And "s=
imple" is
> not necessarily "sufficient and simple".

Of course, it's *possible*, but ad populum is not a valid argument.

There's many projects out there, and very few have as verbose commit
messages as git. I do not say they are doing it better, as many times
a lot of the verbose commit messages do help, but I don't think this
is the case.

Looking at the latest commits in the Linux kernel show good examples
of simple commit messages. Albeit they might be a bit "too simple", my
point that they do have a different view on what is "sufficient and
simple":

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
it;h=3D27c3afe6e1cf129faac90405121203962da08ff4
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
it;h=3D0d86f65ed0b727daa06d3aa176314cd175323db6
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
it;h=3D10f296cbfe3b93188c41463fd7a53808ebdbcbe3

Of course, what is "sufficient and simple" depends on a case by case
basis, but I wonder, if there's any case in which a single line in the
commit message summary would suffice, wouldn't adding missing
inconspicuous tests for something be it?

>> ... And I already pointed out the double standards.
>
> Sorry, but the absolute uniform standards do not exist, unless you ar=
e
> living in a fantasy land. =C2=A0I expect better from list regulars as=
 new
> contributors will inevitably learn from their behaviour (we also lear=
n
> from our past mistakes).

Of course, but I can't help but wonder... Why so much fuss for simple
tests? And why you didn't bother to add tests for your new code as
well?

Cheers.

--=20
=46elipe Contreras
