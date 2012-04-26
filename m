From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t5541: warning message is given even with --quiet
Date: Thu, 26 Apr 2012 08:31:11 +0200
Message-ID: <vpqpqavf1hs.fsf@bauges.imag.fr>
References: <vpqaa27bgon.fsf@bauges.imag.fr>
	<1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334876234-20077-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqpqav9hdl.fsf_-_@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 08:31:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNIEn-0001xr-Hi
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 08:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab2DZGb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 02:31:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34515 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750Ab2DZGb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 02:31:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3Q6Oiav014809
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Apr 2012 08:24:44 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SNIES-0005R8-Eq; Thu, 26 Apr 2012 08:31:12 +0200
In-Reply-To: <xmqqpqav9hdl.fsf_-_@junio.mtv.corp.google.com> (Junio C.
	Hamano's message of "Wed, 25 Apr 2012 22:44:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Apr 2012 08:24:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3Q6Oiav014809
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336026289.16325@WS9yPIsr5N7FGUxy+zlHkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196355>

Junio C Hamano <gitster@pobox.com> writes:

> On one hand, --quiet is a request to be "quiet", but on the other hand,
> this warning is meant to be shown in the face in large flashing red
> letters no matter what the user says, so...

I'd say it's OK to show the warning with --quiet. Users will normally
set the config option in ~/.gitconfig and forget about it, both in
interactive use and in scripts.

So,

> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
