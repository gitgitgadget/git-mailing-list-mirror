From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Correcting forgetting to make a new branch
Date: Fri, 11 Mar 2011 16:50:50 +0100
Message-ID: <vpqk4g57j1h.fsf@bauges.imag.fr>
References: <AANLkTi=fp=-pwi7Mj9TptP22mtP51bzq5UwTLRx9LnNB@mail.gmail.com>
	<op.vr6rgcqs56e9f9@xman.eng.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Alexey Feldgendler" <alexeyf@opera.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4cU-0007aZ-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab1CKPvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:51:08 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39366 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755834Ab1CKPvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:51:00 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p2BFomlM029332
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 11 Mar 2011 16:50:48 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Py4c6-0008NQ-6u; Fri, 11 Mar 2011 16:50:50 +0100
In-Reply-To: <op.vr6rgcqs56e9f9@xman.eng.oslo.osa> (Alexey Feldgendler's
	message of "Fri, 11 Mar 2011 16:46:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Mar 2011 16:50:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p2BFomlM029332
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1300463449.54315@u9DeQjJw1kytNge8MfwUSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168913>

"Alexey Feldgendler" <alexeyf@opera.com> writes:

> However, the branch that was active before when you should have
> branched will have been unintentionally updated. To fix that, you'll
> need to move the old branch a few commits back:
>
> git branch -f <old-branch> <where-it-was-before>

This is correct, but for completeness: don't do that if you've already
pushed your changes. If you pushed them and people already pulled them,
you can hardly do better than appologize to your co-workers that you
shouldn't have done that, and possibly create a new commit on top of the
branch reverting what you did.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
