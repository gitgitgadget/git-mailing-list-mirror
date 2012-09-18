From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: fix misleading error message after 'exec no-such' instruction
Date: Tue, 18 Sep 2012 13:20:21 +0200
Message-ID: <vpq7grrlgqy.fsf@grenoble-inp.fr>
References: <505857CE.3050909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:20:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDvr3-0001OB-DA
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 13:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122Ab2IRLU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 07:20:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35013 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757156Ab2IRLU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 07:20:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8IBFaTo004185
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2012 13:15:37 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TDvqn-0003Fa-WF; Tue, 18 Sep 2012 13:20:22 +0200
In-Reply-To: <505857CE.3050909@viscovery.net> (Johannes Sixt's message of
	"Tue, 18 Sep 2012 13:15:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Sep 2012 13:15:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8IBFaTo004185
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348571741.48361@h2o1dxHKRbsKNnx8SHp4YA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205819>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> When the todo sheet of interactive rebase instructs to run a non-existing
> command, the operation stops with the following error:
>
>   Execution failed: no-such
>   You can fix the problem, and then run
>
>           git rebase --continue
>
>   fatal: 'rebase' appears to be a git command, but we were not
>   able to execute it. Maybe git-rebase is broken?

While you're there, maybe you want to turn the first line into

Execution failed: no-such (command not found)

In any case, the patch sounds good, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
