From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 20:49:52 -0600
Message-ID: <g2h600158c31005071949ve3397f18j3c38017be32dd591@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
	<h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com> 
	<alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org> 
	<q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com> 
	<alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org> 
	<i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com> 
	<alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org> 
	<i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com> 
	<alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 05:05:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAaLy-0000Jf-US
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 05:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab0EHCuP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 22:50:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43094 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0EHCuN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 22:50:13 -0400
Received: by gyg13 with SMTP id 13so1027637gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j2pg2IqklPT2zf4c5EZP6jPqY0R37kAPcwwy15XcCa8=;
        b=I3MkKtVHeEJcTaofVGB5t3jE2zjavlkt9FhtKJmtziN9pRenjekZZlOQLaA+0LsdKp
         Nt+ANUovp+ST5PqeT/YEXJPqdVzpYVeYeMt1l5nu5OBZVnrn3Fs0SfyQQLUGHEenHzOo
         5fo0u3TXk7+OPo7CYbC+FhtP/om04QNC8KSY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ROXHQZKrlKUFsSbSfyEt1VKg1RBgRA+Q+HDwloBRqmFuJqyDRUhC/ZGkov6hrGigtA
         KUfIx1J49t8RLVqbBfI/b10WG1dodyz0LEx3ZqCU742YpU8pDLxdWL8KsC0NApbdBGsl
         7AYQ7iYQvRcoPw4SDUQ9XQTRhq2vDEQ0HV0Js=
Received: by 10.91.50.40 with SMTP id c40mr885221agk.23.1273287012098; Fri, 07 
	May 2010 19:50:12 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Fri, 7 May 2010 19:49:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146628>

On 7 May 2010 19:49, Linus Torvalds <torvalds@linux-foundation.org> wro=
te:
>
>
> On Fri, 7 May 2010, hasen j wrote:
>> > However, if you think that it needs to be CRLF on _all_ platforms,=
 even
>> > platforms where CRLF is _wrong_ for a text-file, then see above: i=
n that
>> > case it's not a text-file at all as far as the SCM is concerned.
>> >
>> > In that case it's just a binary file, and CRLF is _not_ "end of te=
xt
>> > line", it's part of the definition of the format for that binary f=
ile.
>>
>> What does the platform care? This doesn't make any sense. Files that
>> need CRLF are not Unix files to begin with (e.g. sln).
>
> Don't be silly.
>
> The whole AND ONLY point of CRLF translation is that line-endings are
> different on different platforms.
>
> So when you say "What does the platform care?", that is a totally idi=
otic
> and utterly stupid thing to ask.
>
> And since you ask it, I can only assume that you don't understand any=
thing
> about the whole CRLF discussion, that you don't care about cross-plat=
form
> repositories, and that as a result you should NEVER EVER actually use=
 any
> of the git crlf conversion code.
>
> It's that simple. You seem to totally miss the whole point of the who=
le
> feature in the first place.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Linus
>

I worked on several projects on windows where ALL my files were LF;
the platform didn't give a shit and everything worked great.

I don't suppose you use the CRLF feature yourself, not to mention
doing any windows development (ever?).

The way git handles crlf is just confusing; in fact it's so confusing
that it's often better to just turn it off. I'm not the only person
who thinks that. It's specifically confusing because git thinks "if
you're on windows then ALL your files should be CRLF", which is
clearly what you think.

The platform is not windows, it's the development tools. Most
development tools don't actually mind if the line endings are LF only,
and since CRLF conversions in git cause endless confusion, it's better
to turn it off most of the time, unless you're dealing with a retarded
tool that think CRLF is the only line ending and fails to read files
with LF endings.

When that happens, it's most likely the case that these files are
platform-dependent anyway, and so converting them back and forth
between LF and CRLF is just a waste of time.

The whole idea behind my suggestion is to minimize confusion.
