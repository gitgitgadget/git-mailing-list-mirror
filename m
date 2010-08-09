From: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Mon, 09 Aug 2010 18:34:29 +0200
Message-ID: <westyn3n3sa.fsf@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
	<wesy6cgm6wd.fsf_-_@kanis.fr>
	<AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, jaredhance@gmail.com,
	Avery Pennarun <apenwarr@gmail.com>, jnareb@gmail.com,
	git <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVJo-0005JV-EB
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150Ab0HIQfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:35:06 -0400
Received: from elysmail.net ([188.165.214.80]:52823 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab0HIQfB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:35:01 -0400
Received: from IVAN (reverse.completel.net [92.103.229.106]) by elysmail.net with SMTP;
   Mon, 9 Aug 2010 17:34:27 +0100
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
In-Reply-To: <AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
	(Dmitry Potapov's message of "Mon, 9 Aug 2010 16:35:11 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
X-Antivirus: avast! (VPS 100809-0, 09/08/2010), Outbound message
X-Antivirus-Status: Clean
X-Declude-Sender: expire-by-2010-08-14@kanis.fr [92.103.229.106]
X-Declude-Spoolname: 11023482.eml
X-Declude-RefID: str=0001.0A0B0208.4C602E21.01CB,ss=1,fgs=0
X-Declude-Note: Scanned by Declude 4.10.53 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [-4] at 17:34:42 on 09 Aug 2010
X-Declude-Tests: None
X-Country-Chain: FRANCE->destination
X-Declude-Code: 1f
X-HELO: IVAN
X-Identity: 92.103.229.106 | reverse.completel.net | gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152981>

Dmitry Potapov <dpotapov@gmail.com> wrote:

> Though Git uses MAP_PRIVATE with mmap, this only marks mapped pages as
> copy-on-write. Because cloning does not change the pack file, all those
> pages should be shared.

I reran the test today. One client is receiving while the other one is
compressing. I have to interrupt both client because the server is
becoming unusable. I am sure you are right about sharing the pages but I
can't test it.

> On 64-bit architecture, you have plenty virtual space, and mapping
> a file to memory should not take much physical memory (only space
> needed for system tables). 

What I can tell from the mmap man page is that it should map memory to a
file. I assume it shouldn't take up physical memory. However I am seeing
physical memory being consumed. It might be a feature of the kernel. Is
there a way to turn it off?

> You can reduce core.packedGitWindowSize in the Git configuration to
> see if it helps, but I doubt that it will have any noticeable effect.

It was worth a shot, it didn't help...

Looking some more into it today the bulk of the memory allocation
happens in write_pack_file in the following loop.

for (; i < nr_objects; i++) {
    if (!write_one(f, objects + i, &offset))
        break;
    display_progress(progress_state, written);
}

This eventually calls write_object, here I am wondering if the
unuse_pack function is doing its job. As far as I can tell it writes a
null in memory, that I think is not enough to reclaim memory.

I also looked at the use_pack function where the mmap is
happening. Would it be worth refactoring this function so that it uses
an index withing a file instead of mmap?

Unless I hear of a better idea I'll be trying that tomorrow...

Take care,
-- 
Ivan Kanis

I can stand brute force, but brute reason is quite unbearable.  There
is something unfair about its use. It is hitting below the intellect.
    -- Oscar Wilde 
