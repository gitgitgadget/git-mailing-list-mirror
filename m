From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Mon, 5 May 2014 22:10:54 +0200 (CEST)
Message-ID: <110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com> <1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr> <20140505184441.GS9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Kastrup <dak@gnu.org>, d9ba@mailtor.net, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:35:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi8Y-0006KZ-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbaEEUMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 16:12:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51874 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbaEEUMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 16:12:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s45KApIp027454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2014 22:10:52 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s45KAs7X015670;
	Mon, 5 May 2014 22:10:54 +0200
In-Reply-To: <20140505184441.GS9218@google.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF27 (Linux)/8.0.6_GA_5922)
Thread-Topic: pager: remove 'S' from $LESS by default
Thread-Index: asfZdPVbdN4CVPOHHPTCC76rPngWDA==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 May 2014 22:10:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s45KApIp027454
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1399925456.72185@tIkRZN6n2xAKD4/3m816Jw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248142>

----- Original Message -----
> Hi,
> 
> Matthieu Moy wrote:
> 
> > By default, Git used to set $LESS to -FRSX if $LESS was not set by the
> > user. The FRX flags actually make sense for Git (F and X because Git
> > sometimes pipes short output to less, and R because Git pipes colored
> > output). The S flag (chop long lines), on the other hand, is not related
> > to Git and is a matter of user preference. Git should not decide for the
> > user to change LESS's default.
> 
> Thanks!  Sounds like a very good change.
> 
> (Nit: instead of "because Git sometimes pipes short output to less",
> it would be clearer to say something like "when Git pipes short output
> to less it is nice to exit and let the user type their next command".)

It's actually a bit more than this: X to avoid initializing the terminal
and F for the exit behavior you describe.

But since the change is actually not about F and X, I prefered keeping
the text about them as short as possible, so I prefer my version actually.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
