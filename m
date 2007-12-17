From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 13:08:45 +0100
Message-ID: <57245FA1-361B-4333-B490-A2CC99ED4F9C@wincent.com>
References: <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net> <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net> <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com> <Pine.LNX.4.64.0712171038130.9446@racer.site> <36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com> <Pine.LNX.4.64.0712171151490.9446@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Emt-0007lh-EI
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839AbXLQMJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 07:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbXLQMJN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:09:13 -0500
Received: from wincent.com ([72.3.236.74]:58086 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbXLQMJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 07:09:12 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBHC8kSY020709;
	Mon, 17 Dec 2007 06:08:47 -0600
In-Reply-To: <Pine.LNX.4.64.0712171151490.9446@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68551>

El 17/12/2007, a las 12:57, Johannes Schindelin escribi=F3:

> Hmm.  There is some chicken-and-egg problem here (I read the thread, =
=20
> but
> did not really see a problem, as I assumed that _other_ tests would =20
> assure
> that "git diff --no-index" works as expected).
>
> But as at least one released version of GNU diff has a pretty =20
> serious bug,
> I would rather not rely too much on diff.  (BTW this was the reason I
> wanted --no-index so badly.)
>
> So yeah, the second "diff" cannot be "git diff".  Maybe "cmp", but no=
t
> "git diff".

Well cmp would be fine as well, seeing all we want is a boolean "is =20
this the same or not" answer. (I'm not familiar with the GNU diff bug =20
you speak of, but was it so bad that it couldn't even get *that* =20
answer right?)

Cheers,
Wincent
