From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 2/2] t9001: adding --quote-mail option test
Date: Mon, 23 May 2016 22:05:55 +0200
Message-ID: <vpqshx8a6ak.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-3-git-send-email-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, samuel.groot@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon May 23 22:06:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4w7j-0008NX-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 22:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbcEWUGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 16:06:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58797 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072AbcEWUGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 16:06:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4NK5qdw016423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 23 May 2016 22:05:52 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4NK5t3o002456;
	Mon, 23 May 2016 22:05:55 +0200
In-Reply-To: <1464031829-6107-3-git-send-email-tom.russello@grenoble-inp.org>
	(Tom Russello's message of "Mon, 23 May 2016 21:30:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 23 May 2016 22:05:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4NK5qdw016423
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464638755.7813@3tXN1pSK1b/h9tWDCTMCKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295387>

> Subject: [RFC-PATCH 2/2] t9001: adding --quote-mail option test

We write messages at imperative tone, hence s/adding/add/

Tom Russello <tom.russello@grenoble-inp.org> writes:

> From: Tom Russello <tom.russello@ensimag.grenoble-inp.fr>

Please use the same identity for email and commit to avoid this line.

> ---
>
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh

No diffstat again?

Splitting a patch series as "code first; tests after" is not a good idea
IMHO. When questionning the behavior of To: Vs Cc: in the previous
patch, I would have appreciated having tests in the same message, to
check that the tested behavior was indeed the one I was reading in the
code.

OTOH, having one patch to introduce "--quote-email populates To: and Cc:
headers", and then another one for "--quote-email quotes the message
body" would make the review much easier.

Oh, BTW, this obviously lacks documentation
(Documentation/git-send-email.txt).

And that's one reason why the diffstat is useful: one can reply "this
lacks tests and doc" before even reviewing the patch.

Regards,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
