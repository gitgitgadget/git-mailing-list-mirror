From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 22:10:45 +0200
Message-ID: <vpq7fmryhiy.fsf@grenoble-inp.fr>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561B69AE.8050403@gmail.com>
	<xmqq37xgnkh0.fsf@gitster.mtv.corp.google.com>
	<B85D5671-9F8C-452E-87B9-EB4DE3C85955@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:11:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZljR1-0003wY-Pl
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 22:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbJLULA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 16:11:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56627 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbbJLUK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 16:10:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9CKAhKg016446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 12 Oct 2015 22:10:43 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9CKAj8P019567;
	Mon, 12 Oct 2015 22:10:45 +0200
In-Reply-To: <B85D5671-9F8C-452E-87B9-EB4DE3C85955@gmail.com> (Lars
	Schneider's message of "Mon, 12 Oct 2015 12:40:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 12 Oct 2015 22:10:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9CKAhKg016446
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445285446.80485@S+3Cfj2wxn5AvsB79Uw6Uw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279414>

Lars Schneider <larsxschneider@gmail.com> writes:

> {Linux | OSX} * {gcc | clang} * {Default, NO_PTHREAD, NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL}

Another option would be to have a single "NO_*" build, that would
activate all NO_PTHREAD, NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL
at the same time. We'd miss issues with perl but no pthread or so, but
this should catch most issues.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
