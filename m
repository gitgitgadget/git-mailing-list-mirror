From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] t7512-status-warnings.sh : better advices for git status
Date: Thu, 24 May 2012 19:31:33 +0200
Message-ID: <vpqpq9t32q2.fsf@bauges.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 24 19:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXbtC-0002hA-UO
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302Ab2EXRbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 13:31:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41151 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab2EXRbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 13:31:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4OHNY0T015111
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2012 19:23:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXbss-0005zR-NM; Thu, 24 May 2012 19:31:34 +0200
In-Reply-To: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Thu, 24 May 2012 11:37:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 24 May 2012 19:23:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4OHNY0T015111
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338485018.27719@TgQvdHN374DPKci6yMapWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198395>

(We met off-list and already did a few fixes, but here are a few more)

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +test_expect_success 'status when conflicts unresolved' '
> +	git init --shared --bare conflict_test.git &&
> +	git clone conflict_test.git test1 &&
> +	git clone conflict_test.git test2 &&

You don't need to clone to get conflicts. Just create local branches and
use "git merge".

> +test_expect_success 'status when conflicts resolved before commit' '
> +	echo toto > main.txt &&

"toto" would usually be "foo" in english ;-).

We usually write >main, not > main.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
