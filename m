From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] In configure.ac, try -lpthread in $LIBS instead of $CFLAGS to make picky linkers happy
Date: Fri, 06 Nov 2015 09:25:20 +0100
Message-ID: <vpqbnb7edqn.fsf@anie.imag.fr>
References: <201511060111.tA61BbFX084361@tezro.nonet>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Rainer M. Canavan" <git@canavan.de>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:25:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZucLI-0007AN-En
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 09:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032744AbbKFIZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 03:25:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:32969 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757240AbbKFIZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 03:25:36 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tA68PMxh008217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 6 Nov 2015 09:25:22 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tA68PKZf017382;
	Fri, 6 Nov 2015 09:25:20 +0100
In-Reply-To: <201511060111.tA61BbFX084361@tezro.nonet> (Rainer M. Canavan's
	message of "Fri, 6 Nov 2015 02:11:37 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Nov 2015 09:25:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tA68PMxh008217
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1447403126.75756@emVKPcUUuTPulChbrcK9aw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280962>

"Rainer M. Canavan" <git@canavan.de> writes:

> Subject: Re: [PATCH] In configure.ac, try -lpthread in $LIBS instead of $CFLAGS to make picky linkers happy

The patch looks good, but the subject should be improved. We normally
try to stick to 50 characters (to let "git log --oneline" fit in a 80
columns terminal). 50 is a bit strict and not always followed, but yours
is definitely too long.

Also, the convention is "subsystem: what you did". I'd suggest this:

configure.ac: try -lpthread in $LIBS instead of $CFLAGS

The "to make picky linkers happy" is important, but redundant with the
body of the message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
