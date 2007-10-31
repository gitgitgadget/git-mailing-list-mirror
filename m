From: Wincent Colaiuta <win@wincent.com>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 09:16:01 +0100
Message-ID: <1D1C13E6-EC4C-4C2E-BDA1-F04CAA23A3CC@wincent.com>
References: <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org> <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org> <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> <20071030235823.GA22747@coredump.intra.peff.net> <85pryvzt1h.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pascal Obry <pascal@obry.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 09:17:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In8lE-0000p8-TV
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 09:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbXJaIQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 04:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbXJaIQ4
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 04:16:56 -0400
Received: from wincent.com ([72.3.236.74]:59166 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbXJaIQy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 04:16:54 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9V8G2fY020870;
	Wed, 31 Oct 2007 03:16:03 -0500
In-Reply-To: <85pryvzt1h.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

El 31/10/2007, a las 7:39, David Kastrup escribi=F3:

> Jeff King <peff@peff.net> writes:
>
>> I didn't ask for RFC quoting, but a nice side effect of URL syntax i=
s
>> that they are machine parseable. If you wanted to write a tool to =20
>> pick
>> the URLs out of this email and clone them as git repos, then how do =
=20
>> you
>> find the end of:
>>
>>  http://host/git repo with spaces in the path
>>
>> compared to:
>>
>>  http://host/git+repo+with+spaces+in+the+path
>
> You just write <URL:http://host/git repo with spaces in the path> and
> have a good chance it will work.

As a data point, my email client correctly highlights only this one as =
=20
a URL:

http://host/git+repo+with+spaces+in+the+path

Both of these are incorrectly highlighted:

http://host/git repo with spaces in the path
<URL:http://host/git repo with spaces in the path>

And this one too:

<http://host/git repo with spaces in the path>

So what does this mean in practice? I can right-click on the first one =
=20
and choose "Copy". All the other ones I have to left-click and drag, =20
being careful to limit the selection to the appropriate left and right =
=20
boundaries.

Whether or not this is a big enough deal to actually care about is =20
open to debate (obviously). Personally, I don't care too much seeing =20
as I never use paths with spaces in them for this kind of thing.

Cheers,
Wincent
