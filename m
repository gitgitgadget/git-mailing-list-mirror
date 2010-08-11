From: Ivan Kanis <expire-by-2010-08-16@kanis.fr>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Wed, 11 Aug 2010 17:47:36 +0200
Message-ID: <weshbj1xiav.fsf@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
	<wesy6cgm6wd.fsf_-_@kanis.fr>
	<AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
	<westyn3n3sa.fsf@kanis.fr>
	<AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, jnareb@gmail.com, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 17:48:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjDXH-0007jX-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab0HKPsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 11:48:06 -0400
Received: from elysmail.net ([188.165.214.80]:63998 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab0HKPsE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 11:48:04 -0400
Received: from IVAN (reverse.completel.net [92.103.229.106]) by elysmail.net with SMTP;
   Wed, 11 Aug 2010 16:47:34 +0100
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
In-Reply-To: <AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
	(Avery Pennarun's message of "Mon, 9 Aug 2010 12:50:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
X-Antivirus: avast! (VPS 100811-0, 11/08/2010), Outbound message
X-Antivirus-Status: Clean
X-Declude-Sender: expire-by-2010-08-16@kanis.fr [92.103.229.106]
X-Declude-Spoolname: 11034999.eml
X-Declude-RefID: str=0001.0A0B0206.4C62C622.0346,ss=1,fgs=0
X-Declude-Note: Scanned by Declude 4.10.53 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [-4] at 16:47:46 on 11 Aug 2010
X-Declude-Tests: None
X-Country-Chain: FRANCE->destination
X-Declude-Code: 1f
X-HELO: IVAN
X-Identity: 92.103.229.106 | reverse.completel.net | gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153259>

Hi Avery,

Avery Pennarun <apenwarr@gmail.com> wrote:

> ... When you access some of the pages of the mmap'd file, the kernel
> will swap those pages into memory, which increases RSS.  This uses
> *real* memory on the system...

Thanks for the very clear explanations

> Now, the kernel is supposed to be smart enough to release old pages
> out of RSS if you stop using them; it's no different from what the
> kernel does with any cached file data.  So it shouldn't be expensive
> to mmap instead of just reading the file.

How can the kernel release old pages? There does not seem to be anyway
to tell it that it doesn't need a given memory block.

>> Looking some more into it today the bulk of the memory allocation
>> happens in write_pack_file in the following loop.
>>
>> for (; i < nr_objects; i++) {
>> =C2=A0 =C2=A0if (!write_one(f, objects + i, &offset))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> =C2=A0 =C2=A0display_progress(progress_state, written);
>> }
>>
>> This eventually calls write_object, here I am wondering if the
>> unuse_pack function is doing its job. As far as I can tell it writes=
 a
>> null in memory, that I think is not enough to reclaim memory.
>
> What do you mean by the "memory allocation" happens here?  How are yo=
u
> measuring it?

I run top and look at the RES column. I put a printf before and after
the code block and watch the memory go up and up.

>> I also looked at the use_pack function where the mmap is
>> happening. Would it be worth refactoring this function so that it us=
es
>> an index withing a file instead of mmap?
>>
>> Unless I hear of a better idea I'll be trying that tomorrow...
>
> I wouldn't expect this to help, but I would be interested to hear if
> it does.

I got caught up with other thing at work but I think I'll be able to tr=
y
=46riday.

> If the problem is simply that you're flooding the kernel disk cache
> with data you'll use only once, to the detriment of everything else o=
n
> the system, then one thing that might help could be posix_fadvise:
>
>     posix_fadvise(fd, ofs, len, POSIX_FADV_DONTNEED);

Sounds interesting, I'll try sticking that in the unuse_pack function
=46riday.

> On the other hand, perhaps a more important question is: why does git
> feel like it needs to generate entirely new packs for each person
> doing a clone on your system?  Shouldn't it be reusing existing ones
> and just streaming them straight out to the recipient?

Ah interesting point. Two things make me suspect the mmap is not shared
between processes. One is that mmap is done with the MAP_PRIVATE flag
which according to the man page doesn't share between processes. The
second is that the mmap is done on a temporary file created by
odb_mkstemp, I don't believe the name is identical between the two
processes.

Take care,
--=20
Ivan Kanis
http://kanis.fr

Nobody ever went broke underestimating the intelligence of the
American public.
    -- H L Mencken=20
