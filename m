From: Michael Heerdegen <michael_heerdegen@web.de>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Thu, 19 May 2016 17:41:39 +0200
Message-ID: <878tz6m4wc.fsf@web.de>
References: <87vb2d37ea.fsf@web.de> <8760ucoaus.fsf@web.de>
	<20160518004008.GA20007@sigill.intra.peff.net>
	<20160518005824.GA7120@sigill.intra.peff.net>
	<xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
	<20160518174919.GA5796@sigill.intra.peff.net> <87r3cz55mv.fsf@web.de>
	<20160519015455.GB24225@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 17:41:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Q5B-0007kN-QL
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 17:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbcESPlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 11:41:49 -0400
Received: from mout.web.de ([212.227.15.4]:63494 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbcESPls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 11:41:48 -0400
Received: from drachen.dragon ([94.217.122.112]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M89jd-1bpJpc2r0D-00vgYw; Thu, 19 May 2016 17:41:41
 +0200
In-Reply-To: <20160519015455.GB24225@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 May 2016 21:54:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.94 (gnu/linux)
X-Provags-ID: V03:K0:B5DX6eic1fYZFvbTsdAGtdELDUdqSXDZC+r1leLFCyozGmEmtgI
 yy9JV0UFi0m2ylP92KvKoAUlQg6tDmQEiKDdnnV/lVxYeVYi46t6/GmnoN1avuorokd2v0w
 XHLTJz9tUdB3/JygCpqFmSQtS0atoZQf+ZPlUh6V4IFhLnVj4fEwdKcoWwNNW4mFIMxsZFe
 Xwq6ONbgQyVWuTtAW34eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SXqsFrt3qho=:JXg3dOJB547mc82xU1UZBk
 vERZncc3yn0jEtPuDT1jOddkK+V7ht8mABwNDeWCQeSnfWn4msQtBz1wbwMxT1m23EQ0j9PV6
 5ORyF6tHpY0DnCnKydRZZPn2fNUkncUYnzkuiU7fhV1YVVz8IhwKRvG4sZDTTB3nF/g9lnX7D
 Fu0LxdeIm7pM1T7Ic/OGi6sKcdsro906EJ7uB92bb1L1Mh1fgV02HS0dbNh6AEC7ZzkXL8zsT
 ADiYyTiWm4grpSQU7QHjqrFGxNXS5Gun8ud3fw7vopCuZTmjYwpZgAYoUkzW7+NKIetrV6mdn
 NiRsdhGSSBm8hKunxWlJ0BjhVUU8u1kpVCeFUvJCW9iKXXZKZy9zwOp7uuZ3ba+kPxIeWXaPN
 xnmAs1twYHIg7YxCUouQR70z5hiPI4XJTQPFHnxNt79k0bpSCw9X4XGEaAX2VEA7K5QA9ljFk
 KewvR8SIoMBMQgWa3VDTP2DVu8FE18LkagA7ToWRCUFzq88NZXzgFUL3kBm5nct9Hz1qqAhcx
 iGiFal2gloSiYjUNRZ+irRLjF0Vx8J0od582iptJtBWLL1ErHTanIQKvdeEUuHgrntJ+k9O8L
 oaRt34VVh5j+/v59xRDtACWQ4BI3YjMjDS+djyr7T45D80a5NGuGGf2ddDL7zbmVlQy36vBgG
 cbCVycxelnkiR4Gc3HeXaqvWuzYMlURYxeHotbHexmMvXvJxxxyMy+cCbVMieZxCQpqGpzbNn
 ntEgZ5ud8iY3tb7Ri0j+ofrBw373Hej2TTewnRCn6RKMRw4yBvRMHojSPkqJz3kN1DOW22Gh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295070>

Jeff King <peff@peff.net> writes:

> Oh, I agree that unix times are handy. I just think that "use %at in the
> pretty-format, instead of %ad and then %s in the date-format" is not
> such a bad workaround.

I had missed %at (and %ct).  Yes, works perfectly - thanks for the hint.


Regards,

Michael.
