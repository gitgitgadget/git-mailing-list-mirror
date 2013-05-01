From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Wed, 01 May 2013 16:06:10 +0200
Message-ID: <vpqmwsen6b1.fsf@grenoble-inp.fr>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
	<1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
	<CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vikrant Varma <vikrant.varma94@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 16:06:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXXft-0008KY-9v
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 16:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab3EAOGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 10:06:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55069 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754916Ab3EAOGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 10:06:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r41E69ua025997
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 May 2013 16:06:09 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UXXff-0003wE-3n; Wed, 01 May 2013 16:06:11 +0200
In-Reply-To: <CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 1 May 2013 17:53:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 May 2013 16:06:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r41E69ua025997
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368021972.37617@44q76WoT6SxLOD9ShlQrUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223090>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> You say advice, but you're not invoking advise() or guarding the
> advice with an advice.* -- the advice is undoubtedly helpful, but not
> everyone wants to see it.

Quite franckly, I don't see why anybody would need to disable it.
advice.* is very nice to disable messages that are shown in normal Git
usage (e.g. running "git status" or attempting a non-fast forward push),
but this is clearly a user-error, that an advanced user is not supposed
to see anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
