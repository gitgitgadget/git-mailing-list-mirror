From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/10] check_bindir: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 18:21:23 +0200
Message-ID: <vpqr43v3tdo.fsf@anie.imag.fr>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyPS-0000CZ-E7
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbaEOQV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:21:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35349 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbaEOQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:21:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s4FGLL6m031714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 May 2014 18:21:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4FGLNHI027565;
	Thu, 15 May 2014 18:21:23 +0200
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 15 May 2014 07:21:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 May 2014 18:21:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4FGLL6m031714
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400775681.34299@MhBR+lkVPcOU8g2Tmk2qTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249107>

Elia Pinto <gitter.spiros@gmail.com> writes:

>    $ test -z "$x" -a a = b
>    bash: test: too many arguments
>
> because it groups "test -n = -a" and is left with "a = b".

I guess you meant -z, not -n.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
