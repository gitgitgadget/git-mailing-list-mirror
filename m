From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Opera release Git-splitter, a sub-modularizing tool for Git
Date: Fri, 21 Dec 2012 16:49:21 +0100
Message-ID: <vpqhanf2yny.fsf@grenoble-inp.fr>
References: <op.wpiovoj5qrq7tp@acorna.invalid.invalid>
	<50D454D2.5030403@drmicha.warpmail.net>
	<op.wpn2xz07vqd7e2@damia.oslo.osa>
	<50D468E6.2090900@drmicha.warpmail.net>
	<op.wpn9d6xuvqd7e2@damia.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Yngve Nysaeter Pettersen" <yngve@opera.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 16:50:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm4rL-0000LF-GH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 16:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab2LUPtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 10:49:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54054 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab2LUPtg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 10:49:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qBLFdvx5009967
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Dec 2012 16:39:57 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Tm4qg-0004Tr-6x; Fri, 21 Dec 2012 16:49:22 +0100
In-Reply-To: <op.wpn9d6xuvqd7e2@damia.oslo.osa> (Yngve Nysaeter Pettersen's
	message of "Fri, 21 Dec 2012 16:02:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 21 Dec 2012 16:39:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qBLFdvx5009967
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1356709199.43193@LFY9mTRZIYk4/gLNXuz49g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211977>

"Yngve Nysaeter Pettersen" <yngve@opera.com> writes:

> The split command will create a new repository for all files foo in a
> folder (path/foo) and their commit history.
>
> The replant command reverses that process, re-adding the path prefix
> for each file. It may be possible to extend that process into one that
> automatically reintegrates the new commits in the original history,
> but I never had time to complete that work.
>
> I did originally add the "replant" functionality into my version of
> the git-subtree script, but given the number of commits in the
> original repository, git-subtree turned out to be inefficient, due to
> the use of temporary files (tens of thousands of files IIRC).
>
> Those problems led to my development of git-splitter in Python
> (bypassing the problem of temporary files), but just including the
> functionality I needed, join was not one of those functions.

That still doesn't answer the question: why did you need to write a new
tool instead of extending git-subtree?

If one doesn't use "replant", is your tool different from git-subtree?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
