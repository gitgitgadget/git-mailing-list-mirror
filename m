From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 09:55:59 +0100
Message-ID: <vpqy65gs6hs.fsf@bauges.imag.fr>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102151606.21040.johan@herland.net>
	<7vipwlp3yv.fsf@alter.siamese.dyndns.org>
	<201102160154.24744.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 09:56:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpdBv-0001el-O3
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 09:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724Ab1BPI4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 03:56:47 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44533 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab1BPI4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 03:56:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p1G8txj1029446
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Feb 2011 09:55:59 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PpdB2-0003PZ-IO; Wed, 16 Feb 2011 09:56:00 +0100
In-Reply-To: <201102160154.24744.johan@herland.net> (Johan Herland's message of "Wed\, 16 Feb 2011 01\:54\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Feb 2011 09:56:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1G8txj1029446
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1298451362.23524@vHh3uv1jMLA9IpcCIKSKJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166933>

Johan Herland <johan@herland.net> writes:

> In order to make this more understandable to the user, we rename the
> push.default == 'tracking' option to push.default == 'upstream'.

While we're there, shouldn't we also rename 'branch.<remote>.merge' to
'branch.<remote>.upstream'?

It has a bit more consequences, since external porcelains/scripts are
likely to call "git config branch.foo.merge", and would be broken by
such change. But maybe 1.8.0 is the time for this kind of things.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
