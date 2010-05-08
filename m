From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 23:31:04 -0400
Message-ID: <AANLkTikbIHfX5pUOn2Yk44IWzqTFDpyapC1V-C-br9jF@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
	 <h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>
	 <alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org>
	 <q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com>
	 <alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org>
	 <i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com>
	 <alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org>
	 <i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com>
	 <alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org>
	 <g2h600158c31005071949ve3397f18j3c38017be32dd591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, kusmabite@googlemail.com,
	prohaska@zib.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 05:32:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAalj-0006zl-SL
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 05:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab0EHDbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 23:31:10 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57394 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0EHDbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 23:31:09 -0400
Received: by wwa36 with SMTP id 36so432785wwa.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 20:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NrMupfZSxnJOl81Ye3lyAcawVmWr/etdOyfLTXYjoJg=;
        b=tT1As9ykwuLmAuIfdcxYGnIxLCsGOjam8pg1hFYojeNhaLS/A5XnxunSE9S0OpEuOk
         wDSQNxZ7dtfakn+Ui0xNYjdRN2fIfK86OwjFiAdv2M1pyXl01Wy9fGFpPEKajFYIggcp
         /bVWdsiQIBPoYTQZSudPu9pg4u7tLcdE4O4Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W3yLiSSTwtxiuKPnndZmhOmlTjdaMbazKINEyHixj9kbq0n8TsLj/GrL6QhZ6fPlQf
         WOfgp57y6j/cojSU7N1unOOFyPHH9cCdP5igqhfTddypkgqkacFi/B69jvtGwPtF+4L1
         9JiOhSFBBJ34T0N8oTc4hwio8jC4iOQANoR1Y=
Received: by 10.216.85.143 with SMTP id u15mr542591wee.205.1273289464986; Fri, 
	07 May 2010 20:31:04 -0700 (PDT)
Received: by 10.216.25.18 with HTTP; Fri, 7 May 2010 20:31:04 -0700 (PDT)
In-Reply-To: <g2h600158c31005071949ve3397f18j3c38017be32dd591@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146629>

On Fri, May 7, 2010 at 10:49 PM, hasen j <hasan.aljudy@gmail.com> wrote=
:
> On 7 May 2010 19:49, Linus Torvalds <torvalds@linux-foundation.org> w=
rote:
>>
>>
>> Don't be silly.
>>
>> The whole AND ONLY point of CRLF translation is that line-endings ar=
e
>> different on different platforms.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Linus

Actually, Linus, that depends. And while you will recognize this, let
me state the obvious, that there are cases where for certain text
files the platform does not matter, that for all platforms they MUST
normalize to one setting. For instance there are cases where text
files MUST be LF ended on ALL platforms. Have you considered XML to be
one such example? The W3 XML spec states:

   ... [XML processors] MUST behave as if it normalized all line
breaks in external parsed entities (including the document entity) on
input, before parsing, by translating both the two-character sequence
#xD #xA and any #xD that is not followed by #xA to a single #xA
character.

So here is an example of a text file that by convention MUST be
LF-based, yes, even on Windows. And for the record, solution (sln)
files have been an XML format for seven years now. So in any one
workspace it is entirely reasonable that there may be some text files
that MUST have LF, while for other files they SHOULD have CR/LF. There
are also cases where some text files MUST have CR/LF (some scripting
languages barf on Windows otherwise).

[snip ...]

> The way git handles crlf is just confusing; in fact it's so confusing
> that it's often better to just turn it off. I'm not the only person
> who thinks that. It's specifically confusing because git thinks "if
> you're on windows then ALL your files should be CRLF", which is
> clearly what you think.

Hasen makes a good point here. It is simply this, the LF issue does
not boil down to a single boolean switch. People who think of the
LF/CRLF issue as a boolean switch are not dealing with all the facts.
There's a lot of grey, not simply black and white.

Commercial systems, decent ones that is, have had this right for years
(12+ years as I recall). We wouldn't be asking Git to do the right
thing if we weren't sold on Git already. Git is otherwise fantastic
(with using it on Windows being the apparent exception, hence this
conversation).

[snip ...]

> When that happens, it's most likely the case that these files are
> platform-dependent anyway, and so converting them back and forth
> between LF and CRLF is just a waste of time.

I disagree on this one actually, this comment is not spot on. Again,
it depends. I'd generally say,

* perform conversions, or no conversions as the case may be, on the
obvious file types
* when conversions occur, normalize internally to only one convention
* otherwise perform no conversions

> The whole idea behind my suggestion is to minimize confusion.

Confusion, yes. The Git documentation is very confusing on this
point... Linus and Junio may want to lift a page from the Perforce
book ;)

I would hope that people do agree there is a problem here, that Git
SHOULD have a good answer to the issue of line feeds. I am no expert
on Git, and I will not pretend to be, but at Iron Mountain we are
looking at adopting Git, but this is one of two questions that I have.
Having worked with complete pleasure for years with Perforce,
line-feeds had NEVER been an issue, but the documentation about
line-feed support in Git seems a bit "odd". Mind you, as much as I
love Perforce, I also love Git, perhaps more (except for Git on
Windows). But I am now digress, so back to the point...

By the way, Linus and Junio, have you read this yet:

*   http://kb.perforce.com/?article=3D063

It would seem to me there are some text files that by convention MUST
have LF regardless of the platform, and there are examples of text
files that MAY have CRLF depending upon the platform.

So long as an SCM has a provision to permit, whether by prescription
and/or by convention, various line-feed types, files will naturally
fall into one of the following three categories:

* normalization to LF on input, preserving otherwise; e.g. XML
* automatic conversions to platform line feeds for files otherwise
considered ordinary text
* no conversions for everything else, treated as binary

Classic examples of files that MUST have conversions to platform
line-feeds are scripts (but not all types of scripts mind you) that
otherwise would not parse properly. I'm sure we've all seen cases of
this, especially when copying files from one system type to another
over a mount. XML-based build environments are particularly
troublesome in this regard (e.g. Ant).

- Bob
