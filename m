From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Mon, 16 May 2011 18:37:20 +0200
Message-ID: <vpq4o4uwqin.fsf@bauges.imag.fr>
References: <20110516162611.GA6960@mrq1.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Hermann Gausterer <git-mailinglist@mrq1.org>
X-From: git-owner@vger.kernel.org Mon May 16 18:37:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM0nq-0003hv-Mj
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 18:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963Ab1EPQhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 12:37:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52024 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab1EPQhs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 12:37:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4GGbIu8020373
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 May 2011 18:37:18 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QM0nI-0002X9-Lk; Mon, 16 May 2011 18:37:20 +0200
In-Reply-To: <20110516162611.GA6960@mrq1.org> (Hermann Gausterer's message of
	"Mon, 16 May 2011 18:26:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 May 2011 18:37:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4GGbIu8020373
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1306168642.76172@8YVPtlBoS8uXQDkWYPJU0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173747>

Hermann Gausterer <git-mailinglist@mrq1.org> writes:

> this combines the two commands "y"+"q" to one.
> i use this if i know that this is the last hunk to add.

(please capitalize the "I", and actually, avoid saying "I" in a commit
message)

I'm not convinced this is useful enough to deserve a new command. The
help message already starts being scary ...

> +       Q - quit; stage this hunk but none of the remaining ones

The explanation shouldn't start with "quit" I think. I'd say basically
"stage this hunk and quit" or "stage this hunk but none of the remaining
ones".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
