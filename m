From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Understanding and improving --word-diff
Date: Mon, 08 Nov 2010 16:41:05 +0100
Message-ID: <vpqlj53zuum.fsf@bauges.imag.fr>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 16:41:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFTqp-0001tL-LF
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 16:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab0KHPlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 10:41:21 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39741 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab0KHPlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 10:41:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA8FPmao031998
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 8 Nov 2010 16:25:48 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PFTqD-0000nJ-I8; Mon, 08 Nov 2010 16:41:05 +0100
In-Reply-To: <20101108151601.GF22067@login.drsnuggles.stderr.nl> (Matthijs Kooijman's message of "Mon\, 8 Nov 2010 16\:16\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Nov 2010 16:25:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA8FPmao031998
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289834752.1932@Fc0XPz5BYewBN1tbAWK2/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160944>

Matthijs Kooijman <matthijs@stdin.nl> writes:

> Lastly, the "porcelain" word-diff format seems a bit weird to me. Is
> the format specified somewhere, or are there any programs that use it
> currently? I couldn't find any users inside the git.git tree itself?

There's a pending patch for "gitk --color-words". Actually, the
porcelain format was precisely implemented to allow this patch to
exist IIRC.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
