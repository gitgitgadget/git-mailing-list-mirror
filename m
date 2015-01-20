From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_messes_up_=27=C3=B8=27_character?=
Date: Tue, 20 Jan 2015 22:57:43 +0100
Message-ID: <CACBZZX7Sfm2hX=+cMOshMxvoFR2k0R4VH2anQtwxFS_Gw=WFBQ@mail.gmail.com>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de>
 <54BEB7ED.2050103@tronnes.org> <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
 <54BEC75C.3090207@tronnes.org> <CACBZZX5f0ciqmJizYxe+UvKL-g9iDZTca52=9xZP4_qiuEaO3Q@mail.gmail.com>
 <54BECAE0.70309@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <notro@tronnes.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:58:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDgoM-0004SU-M4
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbbATV6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 16:58:05 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:52426 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbATV6E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2015 16:58:04 -0500
Received: by mail-ob0-f182.google.com with SMTP id wo20so36691579obc.13
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 13:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PY9TvItPqtrbepzwAb7vwpNoS7ic/rUvhicepVh6mJQ=;
        b=HZPBM/jkZIvxDJMSyGq30/nNQ12wzEHOy8LA7pwAVAWyc2DaYeuyOWgsjuU0cDYG/C
         TMSwkl/fyRav1ZDf7fyuIxjbbLm/B5QHsUQRwIx26B18PqY3tovhCZhmamR2LnBIqYcy
         azB0WG4EKQutCqW5MxLa2imWWf/bWr5Hok3DvXPtkO5zrIsJGPZ/QQAxE8y3spAUVeYM
         e/E7V6phf4+HmL1g4chKOSoHxL4hKg0/arTRKCzR5ZG8n6yt4UPqvvpaCNh+1+1kTgBC
         9Eu1hx08ToxIo3KOm/fn6RVvHUAJgYyt+cDwxW6bAWewM0xwna+YEdGpxsKjqd6sozkq
         mfOA==
X-Received: by 10.60.102.200 with SMTP id fq8mr23547368oeb.2.1421791083340;
 Tue, 20 Jan 2015 13:58:03 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Tue, 20 Jan 2015 13:57:43 -0800 (PST)
In-Reply-To: <54BECAE0.70309@tronnes.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262698>

On Tue, Jan 20, 2015 at 10:38 PM, Noralf Tr=C3=B8nnes <notro@tronnes.or=
g> wrote:
> Den 20.01.2015 22:26, skrev =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>> On Tue, Jan 20, 2015 at 10:23 PM, Noralf Tr=C3=B8nnes <notro@tronnes=
=2Eorg>
>> wrote:
>>>
>>> Den 20.01.2015 21:45, skrev =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>>> On Tue, Jan 20, 2015 at 9:17 PM, Noralf Tr=C3=B8nnes <notro@tronne=
s.org>
>>>> wrote:
>>>>>
>>>>> Den 20.01.2015 21:07, skrev Torsten B=C3=B6gershausen:
>>>>>>
>>>>>> On 2015-01-20 20.46, Noralf Tr=C3=B8nnes wrote:
>>>>>> could it be that your "=C3=B8" is not encoded as UTF-8,
>>>>>> but in ISO-8859-15 (or so)
>>>>>>
>>>>>>> $ git log -1
>>>>>>> commit b2a4f6abdb097c4dc092b56995a2af8e42fbea79
>>>>>>> Author: Noralf Tr<F8>nnes <notro@tronnes.org>
>>>>>>
>>>>>> What does
>>>>>> git config -l | grep Noralf | xxd
>>>>>> say ?
>>>>>>
>>>>> $ git config -l | grep Noralf | xxd
>>>>> 0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNor=
alf
>>>>> 0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.
>>>>>
>>>>> $ file ~/.gitconfig
>>>>> /home/pi/.gitconfig: ISO-8859 text
>>>>
>>>> What's happened here is that:
>>>>
>>>>    1. You've authored your commit in ISO-8859-1
>>>>    2. Git itself has no place for the encoding of the author name =
in the
>>>> commit object format
>>>>    3. git-format-patch has a --compose-encoding which I think woul=
d sort
>>>> this out if you set it to ISO-8859-1, but it defaults to UTF-8
>>>>    4. Your patch is actually a ISO-8859-1 byte sequence, but is
>>>> advertised as UTF-8
>>>>    5. You end up with a screwed-up commit
>>>>
>>>> You could work around this, but I suggest just joining the 21st
>>>> century and working exclusively in UTF-8, it makes things much eas=
ier,
>>>> speaking as someone with 3x more non-ASCII characters their his na=
me
>>>> than you :)
>>>>
>>> Ok, then the question is: How do I switch to UTF-8?
>>>
>>> To me it seems I'm already using it:
>>> $ locale charmap
>>> UTF-8
>>
>> Your .gitconfig has an ISO-8859-1 string, from an earlier mail of yo=
urs:
>>
>>> $ git config -l | grep Noralf | xxd
>>> 0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNoral=
f
>>> 0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.
>>
>> On a system configured for UTF-8 this would be:
>>
>> $ echo Noralf Tr=C3=B8nnes | xxd
>> 0000000: 4e6f 7261 6c66 2054 72c3 b86e 6e65 730a  Noralf Tr..nnes.
>>
>> Note the "f8" v.s. "c3 b8".
>>
>
> Yes:
> $ echo Noralf Tr=C3=B8nnes | xxd
> 0000000: 4e6f 7261 6c66 2054 72f8 6e6e 6573 0a    Noralf Tr.nnes.
>
> Is there a command I can run that shows that I'm using ISO-8859-1 ?
> I need something to google with, my previous search only gave locale =
stuff,
> which seems fine.

What does this give you, this is UTF-8.

$ echo git commit --author=3D"Noralf Tr=C3=B8nnes <notro@tronnes.org>" =
| xxd
0000000: 6769 7420 636f 6d6d 6974 202d 2d61 7574  git commit --aut
0000010: 686f 723d 4e6f 7261 6c66 2054 72c3 b86e  hor=3DNoralf Tr..n
0000020: 6e65 7320 3c6e 6f74 726f 4074 726f 6e6e  nes <notro@tronn
0000030: 6573 2e6f 7267 3e0a                      es.org>.

To see if you're using UTF-8 just look at the codepoints for the
non-ASCII characters you're using and check if they're valid UTF-8.
E.g. you can check this out:
http://en.wikipedia.org/wiki/%C3%98#Computers

Which shows you that the UTF-8 hex version is C3 B8, but the Latin-1
is F8, you're emitting F8, I'm emitting C3 B8.
