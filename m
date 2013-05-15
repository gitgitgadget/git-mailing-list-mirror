From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Default for color.ui (was Re: is this a bug of git-diff?)
Date: Wed, 15 May 2013 12:03:06 +0200
Message-ID: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
References: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
	<CALWbr2z338CJgavC9sVGffHSoqr0Sb9nCsr4LKURDYpkOog2TQ@mail.gmail.com>
	<CABwUO_Wyq34S=CwbLeAqmzaFLxORkvGEvrjUzMXjkJdE1jnbhA@mail.gmail.com>
	<CALWbr2z2jB53=2UsEneqymU2peiL4OW9Tyace_8BN3=1gA9jNg@mail.gmail.com>
	<vpqhai4y4b2.fsf@grenoble-inp.fr> <20130515095025.GV2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Pelisse <apelisse@gmail.com>,
	eric liou <accwuya@gmail.com>, git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 15 12:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcYkj-00088m-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 12:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855Ab3EOKQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 06:16:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34241 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748Ab3EOKQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 06:16:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4FAFmCo013545
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 12:15:49 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UcYY6-0006xj-IT; Wed, 15 May 2013 12:03:06 +0200
In-Reply-To: <20130515095025.GV2299@serenity.lan> (John Keeping's message of
	"Wed, 15 May 2013 10:50:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 15 May 2013 12:15:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FAFmCo013545
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369217750.71525@s2UcTY6Gnvz2rPel74i2Kw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224394>

John Keeping <john@keeping.me.uk> writes:

> I wonder if that should be the default.  I've advised a lot of people to
> turn it on and it seems to me that a user is much more likely to go
> looking for a "turn color off" option than realise that color is an
> option at all.

I'd love to see this by default, yes. Maybe a 2.0 change?

If people agree that this is a good change, would we need a transition
plan? I'd say no, as there is no real backward incompatibility involved.
People who dislike colors can already set color.ui=false, and seeing
colors can hardly harm them, just temporarily reduce the comfort for
them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
