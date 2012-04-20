From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] push: introduce new push.default mode "simple"
Date: Fri, 20 Apr 2012 16:52:05 +0200
Message-ID: <vpqfwbye9re.fsf@bauges.imag.fr>
References: <vpqaa27bgon.fsf@bauges.imag.fr>
	<1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334876234-20077-2-git-send-email-Matthieu.Moy@imag.fr>
	<20120419234609.GA6020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 16:53:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLFCl-0002gq-DI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 16:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892Ab2DTOwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 10:52:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37567 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756519Ab2DTOwy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 10:52:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3KEjnvU001586
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 16:45:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SLFBu-0008Cp-R6; Fri, 20 Apr 2012 16:52:06 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Apr 2012 16:45:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3KEjnvU001586
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335537956.98183@X5vw/8YKvgR60JyAXHGc1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195996>

Jeff King <peff@peff.net> writes:

> Eh, what's this? This wasn't part of my patch. It was part of Junio's
> patch which mine was based on (and it provokes a "defined but not used"
> warning when your patch is applied on top of master).

Oops, it seems I did some weird conflict resolution applying and
rebasing your patch, plus I sent the serie late in the evening ;-).

> 135dade creates a new t5528 for testing push.default settings, so tests
> could go there.

Excellent. Next re-roll will be based on next to use it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
