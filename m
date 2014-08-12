From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] mailsplit.c: remove dead code
Date: Tue, 12 Aug 2014 23:37:26 +0200
Message-ID: <vpqy4utz8x5.fsf@anie.imag.fr>
References: <53EA430E.8050905@web.de>
	<1407878487-23530-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: l.s.r@web.de, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHJlF-0002Ps-AE
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 23:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbaHLVhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 17:37:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40665 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbaHLVhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 17:37:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7CLbObD031924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Aug 2014 23:37:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7CLbQL8017215;
	Tue, 12 Aug 2014 23:37:26 +0200
In-Reply-To: <1407878487-23530-1-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Tue, 12 Aug 2014 23:21:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Aug 2014 23:37:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7CLbObD031924
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408484247.88816@Xhvv/CPTtci+RYBO7SPAhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255167>

Stefan Beller <stefanbeller@gmail.com> writes:

> +	if (is_bare && !allow_bare) {
> +		unlink(name);
> +		fprintf(stderr, "corrupt mailbox\n");
> +		exit(1);
> +	}

Not directly related to your patch, but shouldn't this be using

die(_("corrupt mailbox"));

instead?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
