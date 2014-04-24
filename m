From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-rebase: fix probable reflog typo
Date: Thu, 24 Apr 2014 10:40:38 +0200
Message-ID: <vpqiopzyvax.fsf@anie.imag.fr>
References: <1398212084-16304-1-git-send-email-felipe.contreras@gmail.com>
	<vpqy4ywxoos.fsf@anie.imag.fr>
	<53582f33385bc_24448772ec57@nysa.notmuch>
	<vpqzjjb1c4m.fsf@anie.imag.fr>
	<5358bb9ea7d42_1f7b143d310c6@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 10:40:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdFDB-00088s-7C
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 10:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbaDXIks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 04:40:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46874 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbaDXIkn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 04:40:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3O8ebhM009536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Apr 2014 10:40:37 +0200
Received: from anie.imag.fr (ensi-vpn-248.imag.fr [129.88.57.248])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3O8ecsa008339;
	Thu, 24 Apr 2014 10:40:38 +0200
In-Reply-To: <5358bb9ea7d42_1f7b143d310c6@nysa.notmuch> (Felipe Contreras's
	message of "Thu, 24 Apr 2014 02:22:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Apr 2014 10:40:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3O8ebhM009536
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398933640.25318@D5FDuWtFWL9COZZIPCl3GQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246949>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Recently some code was changed to do 'test_must_fail env VAR=VAL command', why
> can't we do the same?

I guess we can.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
