From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 15:57:19 -0700
Message-ID: <AANLkTiksU3sswdSlQJNqlyd1AK4dvRoftLhrghELq8j5@mail.gmail.com>
References: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
	<20100527210328.GN16470@spearce.org>
	<AANLkTik9QxiAjZHigx0YS5ybZwj6U7l0fK-byUmBirnO@mail.gmail.com>
	<AANLkTinrUWtqx34U3-FFnyAXXYFkQiwrXc6USXJYR2xE@mail.gmail.com>
	<AANLkTin-SCsgxAUCCYILIHaq-sLDfCgTDfY_Kvc5UVSt@mail.gmail.com>
	<AANLkTinJd1hZE6LiJRHWYknS7e2YUHtKApTaKfpPPfKJ@mail.gmail.com>
	<AANLkTimQWW3WLqa0vWmKTYKsbVvnZiStEJI0N9N5tfng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 28 00:57:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHm10-0000rd-K2
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 00:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab0E0W5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 18:57:21 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:56877 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323Ab0E0W5U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 18:57:20 -0400
Received: by qyk27 with SMTP id 27so964464qyk.23
        for <git@vger.kernel.org>; Thu, 27 May 2010 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O1vvMZJNeVPta9JpWsX7kpXR9hQeSc9F0hBqoFMbMCk=;
        b=RA/TbV9QMxHum9Yu6DuhHEEzBFjUhf+YRkXF6IIo8lrQUnxDe4PAu9Ufmi62ksO3Io
         i5YX5CVNWZ+tT5jcytRMH71vI2mfezFwzQE/hZ+YRR+SCPVGCjnQiQVoeMshGZe47DD1
         4p5FEi4JRoKZ+oxKW3DuUgshMI6bp78Q6I34I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HysvOGTtRNav+wiYUS6JtNHOUXSFT+c9IM7QNYes5Zo9tw996hPw8Cqu1YSH/eitH1
         3ActVdZeHFGdXWxeOx6OE1kyc6PaNKfJdlRZQhavGrBcCddkMVNYYnqv0AXjTsXu0cFB
         unPOz3q7U2zN3MkLWIIVz588+kktpTkl8heGk=
Received: by 10.229.215.137 with SMTP id he9mr2488464qcb.131.1275001039725; 
	Thu, 27 May 2010 15:57:19 -0700 (PDT)
Received: by 10.229.26.74 with HTTP; Thu, 27 May 2010 15:57:19 -0700 (PDT)
In-Reply-To: <AANLkTimQWW3WLqa0vWmKTYKsbVvnZiStEJI0N9N5tfng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147905>

On Thu, May 27, 2010 at 3:18 PM, Chris Packham <judge.packham@gmail.com=
> wrote:
> On Thu, May 27, 2010 at 3:11 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Thu, May 27, 2010 at 6:06 PM, Chris Packham <judge.packham@gmail.=
com> wrote:
>>> They're showing up with 'gitk --all'. I've made a backup so I can
>>> expire the reflog and see if they go away.
>>
>> gitk --all shouldn't be showing stuff just because it's in the reflo=
g.
>> =C2=A0Does it have a branchname tag next to it? =C2=A0Have you exit/=
restarted
>> gitk or are you just using its refresh button? =C2=A0The latter does=
n't
>> work very well across branch deletion.
>>
>> Avery
>>
>
> The commits do have tags. I'll try deleting them and gc'ing again.
>

Deleting the tags seemed to do the trick as far as removing the
detached commits in gitk.

Now git gc seems to be stuck

~/linux> git --version
git version 1.7.1

~/linux> git gc
Counting objects: 20058 (went away made a coffee, came back still
stuck at 20058)

I've attached with gdb and have the following trace if its of any use
(sorry I don't have debug symbols for libz). I've still got the
debugger attached if anyone wants me to dump out anything else.

[Switching to Thread 0xb759e6c0 (LWP 7731)]
0xb7898685 in ?? () from /lib/libz.so.1

(gdb) bt
#0  0xb7898685 in ?? () from /lib/libz.so.1
#1  0xb7898f99 in ?? () from /lib/libz.so.1
#2  0xb7895ccc in ?? () from /lib/libz.so.1
#3  0xb7895ff8 in deflate () from /lib/libz.so.1
#4  0x080f5ade in write_loose_object (sha1=3D<value optimized out>,
hdr=3D<value optimized out>, hdrlen=3D<value optimized out>,
buf=3D0x8248570, len=3D1170, mtime=3D1274994118) at sha1_file.c:2314
#5  0x080f6c09 in force_object_loose (sha1=3D0xb64ed204
"=C2=BB=C2=B2D\v\030\005=C2=AAn\f=C3=98=C3=82\026\201\037E=C2=AA=C3=9E=C3=
=A3c{=C2=B2J=C3=B5=C3=98`=C2=BA\214\020Iv=C3=A6=C3=90`=C3=860\2113\222=C3=
=BF=C2=BB=C2=B2R\rdZ;#q\f?\001=C3=BC\201#ZXr=C2=B7=C2=BB=C2=B2U=C2=AFJl=
=C2=B2\to\022=C2=AC=C2=B3\004\035\215=C3=95d0|z=C2=BB=C2=B2[=C3=A7=C3=9D=
=C3=BEaD2=C3=8A\206'=C2=BAL=C2=BEy\037W=C3=95i=C2=BB=C2=B2^=C2=A9=C2=A7=
=C3=8A\024H\025\003\200\006?\003L=3D\001=C2=AF?=C2=B2d=C3=B2=C3=A4=C3=92=
\223=C3=9Ac\234\202\224=C3=8DfcpO=C3=AC8?l\0226\021~=C3=B3xT=C3=A7=C2=BC=
y.iN=C2=BE=C2=A1\036=C2=BB=C2=B2\212=C2=B7Y\227\211t\v\"3
\200]\"=C2=AE=C3=BB\227=C3=B53=C2=BB=C2=B2=C2=A2\024T=C3=A9=C2=AB>\212.=
=C2=A1a@b'=C3=9C[=C3=92=3D4"..., mtime=3D1274994118) at
sha1_file.c:2377
#6  0x08089d8d in get_object_list (ac=3D<value optimized out>, av=3D<va=
lue
optimized out>) at builtin/pack-objects.c:2050
#7  0x0808c4e6 in cmd_pack_objects (argc=3D10, argv=3D0xbfb43118,
prefix=3D0x0) at builtin/pack-objects.c:2317
#8  0x0804b42b in handle_internal_command (argc=3D<value optimized out>=
,
argv=3D<value optimized out>) at git.c:260
#9  0x0804b5fe in main (argc=3D10, argv=3D0xbfb43118) at git.c:458
