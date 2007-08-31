From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 12:52:42 +0200
Message-ID: <BD9F3FD0-94EF-4182-A03B-B26B18544894@wincent.com>
References: <1188502009.29782.874.camel@hurina> <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org> <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com> <6F219888-6F48-4D56-8FA9-BE63EB6E1D95@iki.fi> <3f4fd2640708301534k40f07a1cva90a59d12ace6138@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Timo Sirainen" <tss@iki.fi>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 12:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR47y-0004Mt-BV
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbXHaKxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 31 Aug 2007 06:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbXHaKxU
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:53:20 -0400
Received: from wincent.com ([72.3.236.74]:56486 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367AbXHaKxU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 06:53:20 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l7VArAxG021223;
	Fri, 31 Aug 2007 05:53:11 -0500
In-Reply-To: <3f4fd2640708301534k40f07a1cva90a59d12ace6138@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57148>

El 31/8/2007, a las 0:34, Reece Dunn escribi=F3:

> As an example, do your safe API do null pointer checks. This is
> because strcpy, strlen and the like don't, which is one of the reason=
s
> why they are considered unsafe. But then, if you guarantee that you
> are not passing a null pointer to one of these API, why take the hit
> of the additional checks when you know that these are safe.

Do you really think that comparing a pointer to NULL is going to be a =20
speed hit? I would imagine that on most architectures it boils down =20
to one or two machine code instructions.

Cheers,
Wincent
