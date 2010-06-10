From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-email: Ask for in-reply message ID even if from and to is already known
Date: Fri, 11 Jun 2010 00:28:58 +0200
Message-ID: <vpqpqzyzfmd.fsf@bauges.imag.fr>
References: <vpqtypmn4bm.fsf@bauges.imag.fr>
	<1275415730-15360-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
X-From: git-owner@vger.kernel.org Fri Jun 11 00:29:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMqFP-0001ra-6x
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 00:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759857Ab0FJW3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 18:29:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53704 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759849Ab0FJW3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 18:29:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5AML9WZ009066
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 11 Jun 2010 00:21:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OMqF8-0000ii-Gq; Fri, 11 Jun 2010 00:28:58 +0200
In-Reply-To: <1275415730-15360-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de> (Alexander Stein's message of "Tue\,  1 Jun 2010 20\:08\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Jun 2010 00:21:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5AML9WZ009066
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1276813269.97372@A0x5KgTZ4pLS2lYlxSMgOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148919>

Alexander Stein <alexander.stein@informatik.tu-chemnitz.de> writes:

> This patch removes the prompting variable so git send-email always asks
> for a in-reply message ID (unless specified on command line) even when
> sendemail.from and sendemail.to is set in ~/.gitconfig or .git/config

Does this mean there's no way to run send-email non-interactively
without a reply-to?

I do want to get the prompt even though I want to set the sender field
in my ~/.gitconfig, but I wouldn't want the prompt to appear in the
cron job I run every nights to send me new patches in some repo for
example (a change in git-send-email already broke it in the past,
that's a rather anoying failure).

You probably want an option to enable/disable prompting. I'm not sure
whether it should be opt-in or opt-out.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
