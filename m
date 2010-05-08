From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 19:39:34 -0600
Message-ID: <i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
	<alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
	<h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com> 
	<alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org> 
	<q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com> 
	<alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org> 
	<i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com> 
	<alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 03:46:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAZ7c-0007co-Gd
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 03:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971Ab0EHBj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 21:39:56 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:57723 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0EHBj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 21:39:56 -0400
Received: by gxk9 with SMTP id 9so1277939gxk.8
        for <git@vger.kernel.org>; Fri, 07 May 2010 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5fAO/vtW9nSsMvx/saBQAMxh8PpiwWM37nVnzcaq0As=;
        b=FzcizoGieXHwpUMoR+LO6fahb1mrChYzK3Sy7bG5KJyFM/t5ZkHaWnNX1oGVksJKvR
         9DT131pStrDME1v9REYX1yPITGXPwuTHgGBWnmRWg0O2vUtS6RgCcWlBZHhhk/SrPvcH
         FJ2sW/Milkh3pk5GdkQmt3UwbvSpFoVDChlMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tUJfuRbvYFvknEEYw3ycsJPywYR7rpYnskqZY1eqUBvbVEp9njho6RQBX+ik6I08Hd
         6L0okUVTa2LkM3yltQf/0MpyUb7im9Yxiseewvvl+0W1uOV5xRwBa2RCJicH4JgTZKvI
         v1vzfU8stf47FUXnvdCLv/0cQp8k1cPyQ4OLI=
Received: by 10.91.168.7 with SMTP id v7mr736204ago.87.1273282794186; Fri, 07 
	May 2010 18:39:54 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Fri, 7 May 2010 18:39:34 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146625>

On 7 May 2010 18:33, Linus Torvalds <torvalds@linux-foundation.org> wro=
te:
>
>
> On Fri, 7 May 2010, hasen j wrote:
>
>> On 7 May 2010 17:50, Linus Torvalds <torvalds@linux-foundation.org> =
wrote:
>> >> What if:
>> >>
>> >> - The entire history of the file is stored in CRLF
>> >> - It's a windows-only file where the official "tool" that reads i=
t
>> >> barfs on LF line endings.
>> >> - Third party tools also expect (or at least, handle) CRLF line e=
ndings.
>> >
>> > Umm. Then it's not text, is it? What you are describing is a binar=
y file
>> > that happens to look like text with CRLF.
>>
>> That depends on your definition of text.
>
> Well, my definition of text is "does it make sense to do any end-of-l=
ine
> conversions". That's the only definition that makes sense for an SCM,=
 at
> least in the current context. If doing conversions on the line ending=
s is
> wrong, then it's not text.
>
> And your whole premise was that conversions were always wrong. So the=
 way
> you put it, that's not a text-file, it's a binary file.
>
>> Storing it with LF internally is ok, as long as we can have it
>> *always* be checked out as crlf.
>
> .. and that's what I suggested "core.crlf=3Don" would mean.
>
> However, if you think that it needs to be CRLF on _all_ platforms, ev=
en
> platforms where CRLF is _wrong_ for a text-file, then see above: in t=
hat
> case it's not a text-file at all as far as the SCM is concerned.
>
> In that case it's just a binary file, and CRLF is _not_ "end of text
> line", it's part of the definition of the format for that binary file=
=2E
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Linus
>

(sorry about the previous message, forgot to make it reply all)

What does the platform care? This doesn't make any sense. Files that
need CRLF are not Unix files to begin with (e.g. sln).

My whole argument is based on a simple premise: LF -> CRLF doesn't
make sense because all windows editors can handle LF endings, and
because it just causes a lot of confusion.

Until Erik brought up the case where a multi-platform project uses
different build systems on each platform.

I don't know if .sln is one of these formats where the tools will
vomit if it's not crlf, but let's just assume so.

- *.sln is not a Unix file, so it's perfectly ok (maybe even
desirable) to check it out with crlf.
- it's an exception; git doesn't have to convert _all_ files to crlf;
just the .sln ones.
