From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] add: respect add.updateroot config option
Date: Thu, 14 Mar 2013 13:39:25 +0100
Message-ID: <vpqwqta2m0y.fsf@grenoble-inp.fr>
References: <20130313040845.GA5057@sigill.intra.peff.net>
	<20130313041037.GB5378@sigill.intra.peff.net>
	<vpqr4jjd5wp.fsf@grenoble-inp.fr>
	<20130313092754.GA12658@sigill.intra.peff.net>
	<7vmwu747tf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 13:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG7SB-00031H-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 13:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757635Ab3CNMjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 08:39:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58811 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627Ab3CNMji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 08:39:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2ECdOC5014471
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Mar 2013 13:39:24 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UG7RN-0000j0-Bf; Thu, 14 Mar 2013 13:39:25 +0100
In-Reply-To: <7vmwu747tf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 13 Mar 2013 08:51:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Mar 2013 13:39:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2ECdOC5014471
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363869565.35785@E3kRy9mebjMFoy6q1J212A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218131>

Junio C Hamano <gitster@pobox.com> writes:

> It still has the same "the user saw
> it mentioned on stackoverflow and sets it without understanding that
> the behaviour is getting changed" effect.

I'm not so worried about this point, as the mechanism is temporary, and
it will take time before answers on stackoverflow reach the mass. The
initial state is that the option is not discoverable without reading the
documentation, and Jeff's documentation is very clear that this is
temporary. People reading the doc are usually not the kind of people
giving dumb answers on the web.

And even if some people set the option without understanding the
consequences, it's not that terrible. They'll just get the transition
period shortened.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
