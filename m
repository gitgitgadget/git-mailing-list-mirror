From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Sun, 27 Feb 2011 12:43:00 +0100
Message-ID: <vpqoc5x4saj.fsf@bauges.imag.fr>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
	<7vei6t4uwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 12:46:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptf5I-0005jM-0K
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 12:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab1B0Lqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 06:46:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:34734 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab1B0Lqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 06:46:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p1RBh0l2025571
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 27 Feb 2011 12:43:00 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ptf1g-0007up-M0; Sun, 27 Feb 2011 12:43:00 +0100
In-Reply-To: <7vei6t4uwa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 27 Feb 2011 02:46:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 27 Feb 2011 12:43:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168029>

Junio C Hamano <gitster@pobox.com> writes:

> Step 2, two cycles (i.e. 6-8 months) before 1.8.0, provided if the
> previous step is proven positive:
>
>  * When "git add -u" is run without any pathspec, and when the user does
>    not have the configuration variable, warn loudly that the default
>    behaviour will change in 1.8.0,

I'd even say "error out", since the old behavior is still easily
available with "git add -u ." (which should be mentionned in the
warning/error message).

>> PS. What about -A?
>
> I personally think it should change exactly the same way as "-u" for
> consistency,

Same here. I care less since I use "add -A" less, but both commands
should really behave the same since they're very similar.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
