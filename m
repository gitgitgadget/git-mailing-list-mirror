From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] fixup for patch 2: actually check the return value
Date: Wed, 16 Jul 2014 19:10:47 +0200
Message-ID: <vpqpph5z0tk.fsf@anie.imag.fr>
References: <vpqha2h9tjw.fsf@anie.imag.fr>
	<1405526952-25019-1-git-send-email-Matthieu.Moy@imag.fr>
	<1405526952-25019-2-git-send-email-Matthieu.Moy@imag.fr>
	<53C6AE9F.2030908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, artagnon@gmail.com
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:11:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Sjf-0001cQ-D9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 19:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbaGPRLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 13:11:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43672 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934006AbaGPRLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 13:11:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6GHAj4r011864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2014 19:10:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GHAla1027779;
	Wed, 16 Jul 2014 19:10:47 +0200
In-Reply-To: <53C6AE9F.2030908@gmail.com> (Tanay Abhra's message of "Wed, 16
	Jul 2014 22:25:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Jul 2014 19:10:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6GHAj4r011864
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406135447.70182@lPC6kV9WURUPTNiKjcClkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253678>

Tanay Abhra <tanayabh@gmail.com> writes:

> I think it would be unnecessary for the current iteration.
> Currently git_configset_add_file has only two possible return values
> -1 or 0.

Yes. My point is just to check that statement in tests. (I'm usually
wary of statements like "is obviously true so I don't need to test
it" ;-) )

> I could add specialized error values for ENOENT or ENOTDIR or EACCES,
> but the logs show that we silently ignore the first two. I can add an
> access warn for the third. What do you think?

I think the code is fine as it is.

But anyway, it's not terribly important.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
