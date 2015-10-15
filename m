From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] strbuf: make stripspace() part of strbuf
Date: Thu, 15 Oct 2015 18:42:23 +0200
Message-ID: <vpqio6813tc.fsf@grenoble-inp.fr>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-2-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 15 18:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmlc1-0001vx-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 18:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbJOQmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 12:42:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38121 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbbJOQmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 12:42:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9FGgLZP013805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 18:42:21 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9FGgNMB023233;
	Thu, 15 Oct 2015 18:42:23 +0200
In-Reply-To: <1444911524-14504-2-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 15 Oct 2015 14:18:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 15 Oct 2015 18:42:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9FGgLZP013805
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445532142.37657@ZOlW1RL0Ru1v9PmVCOsFbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279671>

Tobias Klauser <tklauser@distanz.ch> writes:

> Also switch all current users of stripspace() to the new function name
> and  keep a temporary wrapper inline function for topic branches still
> using stripspace().

Since you have this temporary wrapper, it would have made sense to split
the patch into 1) move and rename the function, and 2) change the
callsites to strbuf_stripspace. This way 2) would be absolutely trivial
to review.

OTOH, this patch is already easy to review, so you may consider it's OK
like this.

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
