From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 09:42:20 +0100
Message-ID: <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com>
References: <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net> <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4BZ4-00081t-6f
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbXLQImo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 03:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbXLQImo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:42:44 -0500
Received: from wincent.com ([72.3.236.74]:57591 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbXLQImn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 03:42:43 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBH8gLTD015216;
	Mon, 17 Dec 2007 02:42:22 -0600
In-Reply-To: <20071216222919.GA2260@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68520>

El 16/12/2007, a las 23:29, Jeff King escribi=F3:

> On Sun, Dec 16, 2007 at 02:23:27PM -0800, Junio C Hamano wrote:
>
>> Yeah, I amended it without adding another "re-" to the title ;-)  Th=
e
>> result has been already pushed out.
>
> OK. Too late, but it has my ack. ;)
>
>>> Aren't we using "git diff" for the second diff there nowadays?
>>
>> Some people seem to think that is a good idea, but I generally do no=
t
>> like using "git diff" between expect and actual (both untracked) =20
>> inside
>> tests.  The last "diff" is about validating what git does and using =
=20
>> "git
>> diff" there would make the test meaningless when "git diff" itself i=
s
>> broken.
>
> I think that is a valid concern. But ISTR that were some issues with
> using GNU diff. Commit 5bd74506 mentions getting rid of the dependenc=
y
> in all existing tests, but gives no reason.

I'd say it's safe and sensible to use "git diff" in all tests *except* =
=20
for tests of "git diff" itself.

Wincent
