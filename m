From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2 v2] rebase -i: clarify in-editor documentation of "exec"
Date: Fri, 21 Jan 2011 07:59:14 +0100
Message-ID: <vpqr5c6zqrh.fsf@bauges.imag.fr>
References: <vpq62ziv788.fsf@bauges.imag.fr>
	<1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
	<20110116015941.GA28137@burratino> <20110116020132.GB28137@burratino>
	<vpq39otrvmk.fsf@bauges.imag.fr> <20110120200949.GB11702@burratino>
	<7vy66fqoji.fsf@alter.siamese.dyndns.org>
	<20110121003624.GB23139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 07:59:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgAyO-0004Tj-SH
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 07:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab1AUG7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 01:59:48 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46097 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab1AUG7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 01:59:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p0L6xEgk017561
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Jan 2011 07:59:16 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PgAxm-0001pF-I0; Fri, 21 Jan 2011 07:59:14 +0100
In-Reply-To: <20110121003624.GB23139@burratino> (Jonathan Nieder's message of "Thu\, 20 Jan 2011 18\:36\:24 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 21 Jan 2011 07:59:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0L6xEgk017561
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1296197961.04342@zLOomaMgCHcqqkqmGzKXcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165355>

Jonathan Nieder <jrnieder@gmail.com> writes:

> -#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
> +#  x, exec = run command specified on the rest of the line

I don't think dropping "shell" is a good idea. In this context,
"command" could mean "one of pick/fixup/squash/...", a Git command,
and at last, an arbitrary line of shell.

I agree that my "shell command" wording was confusing too, but maybe
just adding "using the shell" at the end of line would do it.
Otherwise, I prefered the "see below + 2 lines explanation" proposal
above.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
