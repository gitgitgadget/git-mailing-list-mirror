From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3 2/2] t7512-status-warnings.sh: better advices for git status
Date: Mon, 28 May 2012 22:36:11 +0200
Message-ID: <vpqzk8s82mc.fsf@bauges.imag.fr>
References: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338226598-16056-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon May 28 22:36:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ6fu-0003f5-Tl
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 22:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab2E1UgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 16:36:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56927 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755061Ab2E1UgR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 16:36:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4SKRxfk030080
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2012 22:27:59 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZ6fk-0007Y7-2y; Mon, 28 May 2012 22:36:12 +0200
In-Reply-To: <1338226598-16056-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Mon, 28 May 2012 19:36:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 May 2012 22:28:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4SKRxfk030080
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338841680.86941@/f4asXBxuQrvbzw2V8HEGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198721>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +	# You are currently rebasing: fix conflicts and then run "git rebase -- continue".
> +	# If you would prefer to skip this patch, instead run "git rebase --skip".
> +	# To check out  the original branch and stop rebasing run "git rebase --abort".

You can use a small indentation to mark the fact that the next lines are
related to the first, like done in the other messages of status:

> +	# Unmerged paths:
> +	#   (use "git reset HEAD <file>..." to unstage)
> +	#   (use "git add/rm <file>..." as appropriate to mark resolution)

I'd have written it like this:

+	# You are currently rebasing: fix conflicts and then run "git rebase -- continue".
+	#   If you would prefer to skip this patch, instead run "git rebase --skip".
+	#   To check out  the original branch and stop rebasing run "git rebase --abort".

Same for other messages.

> +	# You are currently rebasing: fix conflicts and then run "git rebase -- continue".

Extra space between -- and continue.

You could refine the advice depending on whether conflicts are (still)
present or not (like you did for merge).

> +test_expect_success 'status in am progress : patch corrupted/wrong format' '

No space before :.

> +	# One of the patches is empty or corrupted !

No space before ! (I think I mentionned it for the C code, not sure).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
