From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 4/5] Git.pm: add interface for git credential command
Date: Thu, 07 Feb 2013 19:46:48 +0100
Message-ID: <vpq38x8m06f.fsf@grenoble-inp.fr>
References: <cover.1360242782.git.mina86@mina86.com>
	<cover.1360242782.git.mina86@mina86.com>
	<78516627e893e54d5aafe0694d1face9a37893de.1360242782.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3WWq-000093-8l
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126Ab3BGSsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 13:48:30 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54287 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161002Ab3BGSs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:48:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r17Ikkm2011002
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Feb 2013 19:46:47 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U3WUi-0005nP-UC; Thu, 07 Feb 2013 19:46:48 +0100
In-Reply-To: <78516627e893e54d5aafe0694d1face9a37893de.1360242782.git.mina86@mina86.com>
	(Michal Nazarewicz's message of "Thu, 7 Feb 2013 15:01:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Feb 2013 19:46:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r17Ikkm2011002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360867610.96425@eZAySfm2sSNngUHTs6vgyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215711>

Michal Nazarewicz <mpn@google.com> writes:

> From: Michal Nazarewicz <mina86@mina86.com>
>
> Add a credential() function which is an interface to the git
> credential command.  The code is heavily based on credential_*
> functions in <contrib/mw-to-git/git-remote-mediawiki>.

I'm no perl expert, so I cannot comment much on style (there are many
small changes compared to the mediawiki code that look like improvement
though), but:

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
