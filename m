From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 10:34:54 +0100
Message-ID: <B2D68DE5-4A97-4E89-8C1F-A889380FE32A@wincent.com>
References: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com> <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>, Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 10:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGWac-0004P9-HO
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 10:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYATJfM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 04:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYATJfL
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 04:35:11 -0500
Received: from wincent.com ([72.3.236.74]:43523 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbYATJfJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 04:35:09 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0K9YtlR005092;
	Sun, 20 Jan 2008 03:34:56 -0600
In-Reply-To: <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71167>

El 20/1/2008, a las 2:04, Linus Torvalds escribi=F3:

> On Sun, 20 Jan 2008, Wincent Colaiuta wrote:
>>
>> For what it's worth, their choice wasn't entirely "insane" ie. it =20
>> did have an
>> element of rationality: that decomposed forms are a little bit =20
>> simpler to
>> sort.
>
> No they are *not*.
>
> In many languages, '=E4' does *not* sort like 'a' at all, and if you =
=20
> think
> it does, you'll sort at least Finnish and Swedish totally wrong (=E5=E4=
=F6 =20
> are
> real letters, and they sort at the *end* of the alphabet, they have
> nothing what-so-ever to do with the letters 'a' or 'o').
>
> The fact that in *some* languages the decomposed forms sort as the =20
> base
> letter is immaterial. It's only true in some cases.
>
> So no, sort order is not it. To sort right, you need to use the a rea=
l
> Unicode sort (and the decomposed form is *not* going to help you one =
=20
> bit,
> quite the reverse).

That's what I get for believing Wikipedia ("This makes sorting far =20
simpler"):

http://en.wikipedia.org/wiki/UTF-8#Mac_OS_X

Cheers,
Wincent
