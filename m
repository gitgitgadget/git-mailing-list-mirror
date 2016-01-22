From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: be prepared for not-yet-started interactive rebase
Date: Fri, 22 Jan 2016 17:45:38 +0100
Message-ID: <vpqlh7h5zrh.fsf@anie.imag.fr>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:46:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMeqX-0004dW-0g
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 17:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbcAVQp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 11:45:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33610 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbcAVQp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 11:45:56 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u0MGjbrA014545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 22 Jan 2016 17:45:37 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0MGjcMe008234;
	Fri, 22 Jan 2016 17:45:38 +0100
In-Reply-To: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 22 Jan 2016 17:28:40 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 Jan 2016 17:45:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0MGjbrA014545
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1454085941.34187@aeCU9Ju14Nrxa7UfgjiGqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284560>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  wt-status.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Looks good to me. You may want to add a test by overriding $EDITOR to a
script doing "git status >actual" if you want to have fun with testing.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
