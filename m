From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 16:16:12 +0100
Message-ID: <vpqy5fmva6b.fsf@grenoble-inp.fr>
References: <1217961884.4232967.1358780423428.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 16:16:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxJ75-00083O-PW
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 16:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab3AUPQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 10:16:22 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37741 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037Ab3AUPQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 10:16:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0LFGBLP006798
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 16:16:13 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TxJ6b-0000Sr-40; Mon, 21 Jan 2013 16:16:13 +0100
In-Reply-To: <1217961884.4232967.1358780423428.JavaMail.root@dewire.com>
	(Robin Rosenberg's message of "Mon, 21 Jan 2013 16:00:23 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jan 2013 16:16:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0LFGBLP006798
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359386174.60132@ISRXCXA4B3VNhpJEviPc8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214123>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> git add -u without filepattern is, I believe very common, so no noisy
> output there please.

What are you exactly suggesting? That we keep the inconsistant semantics
of "git add -u" or "git add -A"? Or another migration plan?

> git diff
> #looks good
> git add -u

That's indeed the kind of mistake I'd like to avoid. In your example,
"git diff" is tree-wide, and "git add -u" is limited to ., so in general
"git add -u" won't stage the same thing as "git diff" just showed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
