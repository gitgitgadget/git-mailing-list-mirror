From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 15:19:33 +0100
Message-ID: <vpqboekqwei.fsf@grenoble-inp.fr>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin> <vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	<vpqehjgscv3.fsf@grenoble-inp.fr>
	<CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
	<vpqhaocqx4k.fsf@grenoble-inp.fr>
	<CAO1Khk9Y_SC8q4iHnv848Z+dXMaeUOWxzW76yPSj_as317_u5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Igor Lautar <igor.lautar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 15:20:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TczXc-0002Mk-FU
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 15:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab2KZOTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 09:19:53 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49494 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab2KZOTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 09:19:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qAQEAAQ1005777
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2012 15:10:10 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TczX3-0006n3-Ph; Mon, 26 Nov 2012 15:19:33 +0100
In-Reply-To: <CAO1Khk9Y_SC8q4iHnv848Z+dXMaeUOWxzW76yPSj_as317_u5g@mail.gmail.com>
	(Igor Lautar's message of "Mon, 26 Nov 2012 15:15:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Nov 2012 15:10:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAQEAAQ1005777
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354543814.40934@Wec35Q4bhGXNx4iOfjlnzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210452>

Igor Lautar <igor.lautar@gmail.com> writes:

> git annotate <file> <merge commit>^2
>  - shows line as being modified by a commit done after file was added
> - ie., state I would expect after a merge

What about "git annotate <file> <merge-commit>^1"?

Was the merge completely automatic, or were there any conflict?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
