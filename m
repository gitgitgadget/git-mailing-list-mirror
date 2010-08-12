From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Where do I stick development documentation?
Date: Thu, 12 Aug 2010 03:11:50 +0000
Message-ID: <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
	<20100812023922.GB19174@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjOD0-0005Kn-NY
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759542Ab0HLDLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 23:11:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36663 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221Ab0HLDLw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 23:11:52 -0400
Received: by fxm13 with SMTP id 13so563724fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zv/YgVGwwlzFZpkpf2W74Jy/HjAd7kTZN7u39v0ArgQ=;
        b=pPfp+1YLKYpBK6J/Y4pZ9Vb8SJW3629yx7TzhIyQpfhUiO2KU6MLasSLSK11uAvuWn
         +YmLmBdQRiy1Eh6H6dsj26beV9BvbpXh/14kJMgTal+Yr9aS4+Exm4rLiR/YCykdjAbi
         xLAiXv4mqtNut7x5rb8P/yNjyqSERIs8+s1rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b2ys1moNqBCbCzID9rGFGcz2VYp1fak6ZZDUHdahKQSn6c5d7/mfYJAAsNuoKZ7gIr
         unPAYleb7ejz5t+fR8SGKU5ls/WgeGHQRuofofs/EyfffcFQ0an2xBvXeRIpOuNtBYpM
         eDJCQcslhzn/yfU5GhUNfaABpTKYeVTHWn+Gw=
Received: by 10.223.107.82 with SMTP id a18mr7961272fap.86.1281582710414; Wed, 
	11 Aug 2010 20:11:50 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 20:11:50 -0700 (PDT)
In-Reply-To: <20100812023922.GB19174@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153330>

On Thu, Aug 12, 2010 at 02:39, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> There's some documentation aimed at developing that I'd like to see =
/
>> write in Git at some point.
>>
>> Developing:
>>
>> =C2=A0 =C2=A0* How to work with Gettext
>>
>> =C2=A0 =C2=A0* How to write portable code, i.e. constructs to avoid =
in C / shell
>> =C2=A0 =C2=A0 =C2=A0script etc (these keep coming up).
>
> Maybe:
>
> =C2=A0Documentation/technical/api-gettext.txt
> =C2=A0Documentation/CodingGuidelines
> =C2=A0Documentation/PlatformNotes
>
> or some variations on the theme?

That would totally screw with my secret mission to turn everything
into manpages, though :)

I don't know how sane it would be, but it'd be neat to tell people "to
patch git just fire up `man gitdev-patches' in your terminal ..".

Another plus is writing in asciidoc, instead of some pseudocode that
isn't parsed by anything but human eyes.

But meh, I don't know :)

>> =C2=A0 =C2=A0* How to deal with gettext / submit po files / keep the=
m up to date
>> =C2=A0 =C2=A0 =C2=A0etc.
>
> gittranslation.7?

Sounds good.

>> =C2=A0 =C2=A0* Core git concepts (that need to be translated), maybe=
 I could
>> =C2=A0 =C2=A0 =C2=A0adopt the gitglossary to this task, but it'd nee=
d to be a bit
>> =C2=A0 =C2=A0 =C2=A0more structured, i.e. describe core data concept=
s first, then
>> =C2=A0 =C2=A0 =C2=A0some other terms.
>
> That sounds good. =C2=A0Once we develop infrastructure for translatin=
g
> manpages, we could encourage translators to do gitglossary first
> to standardize terminology.

I'll push "add sub-sections to gitglossary" to my TODO. I think the
flet alphabetical order does it a disservice, but then again maybe
leaving the glossary alone and writing a new document would be better.

What I had in mind was something like this (incomplete, and mostly in
Icelandic): http://gist.github.com/425917

I.e. just a bulletpoint list of core terms that you need to translate
for Git.

>> =C2=A0 =C2=A0 =C2=A0Actually, on that point, do we have documentatio=
n that describes
>> =C2=A0 =C2=A0 =C2=A0git's data model in one place? I.e. everything f=
rom blobs to
>> =C2=A0 =C2=A0 =C2=A0trees, how raw commit objects etc. look. Somethi=
ng like "Git for
>> =C2=A0 =C2=A0 =C2=A0computer scientists".
>
> Hopefully some pic wizard can convert that to nroff. :)
>
> I think Tommi Virtanen should be easy to reach in case anyone wants t=
o
> try adapting the article somehow.

That'd be neat. Sometimes I forget how git stores things (so that I
could e.g. construct commit objects with echo / sha1sum on the command
line). Having one documentation that explains all that would be nice.

It'd also be very neat if we had tools to print out any object in its
raw form, --pretty=3Draw is partly there, but it's more pretty than
raw.

E.g. a tool like that might give you a human readable representation
of a object file (including packed files), instead of having to do
something like this (from "Inspecting a corrupt git object"):

    On Wed, Aug 4, 2010 at 09:48, Thomas Rast <trast@student.ethz.ch> w=
rote:
    > Magnus B=C3=A4ck wrote:
    >>
    >> $ head -n 1 /tmp/hexdump_corrupt.txt
    >> 00000000 =C2=A078 9c 2b 29 4a 4d 55 30 =C2=A032 36 62 30 34 30 3=
0 33
|x.+)JMU026b04003|
    >> $ head -n 1 /tmp/hexdump_okay.txt
    >> 00000000 =C2=A078 01 2b 29 4a 4d 55 30 =C2=A032 36 62 30 34 30 3=
0 33
|x.+)JMU026b04003|
    >>
    >> From what I gather from the community book and Pro Git, a git ob=
ject
    >> file is a deflated representation of the object type as a string=
, the
    >> payload size, a null byte, and the payload. Is there a standard =
tool for
    >> inflating the file back so that I can inspect what the actual di=
fference
    >> between these two are? Short of writing a tool utilizing zlib, a=
t least.
    >
    > I'm sure it's a one-liner in almost any scripting language, e.g. =
you
    > can use
    >
    > =C2=A0python -c 'import sys,zlib;
sys.stdout.write(zlib.decompress(open(sys.argv[1]).read()))'
