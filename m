From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Add 'git credential' plumbing command
Date: Tue, 12 Jun 2012 16:31:33 +0200
Message-ID: <vpq3960r48q.fsf@bauges.imag.fr>
References: <1339511044-29977-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Jeff King <peff@peff.net>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 12 16:31:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeS8M-00040g-K2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab2FLObp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:31:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42946 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2FLObo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:31:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5CEMcw4027476
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 16:22:38 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeS86-0006mF-V6; Tue, 12 Jun 2012 16:31:35 +0200
In-Reply-To: <1339511044-29977-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	(Javier Roucher-Iglesias's message of "Tue, 12 Jun 2012 16:24:04
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 16:22:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CEMcw4027476
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340115760.0606@Cq9qPymjZK85znsgdblV+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199791>

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> +git credential <fill|approve|reject>

You didn't take Jeff's suggestions into account:

http://thread.gmane.org/gmane.comp.version-control.git/199552/focus=199591

It's clearly too late to implement the whole suggested API, but I do
like the suggestion of allowing either a URL as argument or individual
fields on stdin, or both combined, by using the --stdin argument.

To allow further patches to implement this without breaking backward
compatibility, your implementation could require the use of --stdin on
the command-line.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
