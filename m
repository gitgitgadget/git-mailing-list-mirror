From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 001/144] check-builtins.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 09:35:06 +0100
Message-ID: <vpqa9ce7k1x.fsf@anie.imag.fr>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
	<1395735989-3396-2-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 09:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMpS-0008MO-4k
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbaCYIfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 04:35:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57949 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbaCYIfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:35:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8Z6Jr009205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2014 09:35:06 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8Z6QB022217;
	Tue, 25 Mar 2014 09:35:06 +0100
In-Reply-To: <1395735989-3396-2-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 25 Mar 2014 01:24:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Mar 2014 09:35:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2P8Z6Jr009205
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396341309.37599@7cNpSDfygTF3rT9Fao7x6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244990>

Elia Pinto <gitter.spiros@gmail.com> writes:

> and is supported by POSIX. However,all but the simplest uses become

Missing space after comma.

> complicated quickly. In particular,embedded command substitutions

Ditto.

(neither should block merging, but they would be worth fixing if you
need a reroll)

Did you do these 144 patches by hand, or did you use a script (e.g. perl
substitution or so) to do it? If the later, then you should include
explanations in your commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
