From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Doing a git add '' will add more files then expected
Date: Mon, 17 Nov 2014 19:42:12 +0100
Message-ID: <vpqa93p8y9n.fsf@anie.imag.fr>
References: <CAMDzUtyhNKdzHQK2zLEutJRcRUibhO-U6Zh0yJhrx-YxBqP5cQ@mail.gmail.com>
	<87lhn91ynu.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guilherme <guibufolo@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 19:42:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqRFq-00018I-8q
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 19:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbaKQSmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 13:42:22 -0500
Received: from mx1.imag.fr ([129.88.30.5]:50117 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaKQSmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 13:42:21 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id sAHIgAKx011235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Nov 2014 19:42:10 +0100
Received: from anie.imag.fr (ensi-vpn-232.imag.fr [129.88.57.232])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id sAHIgCOJ003868;
	Mon, 17 Nov 2014 19:42:12 +0100
In-Reply-To: <87lhn91ynu.fsf@igel.home> (Andreas Schwab's message of "Mon, 17
	Nov 2014 19:15:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Nov 2014 19:42:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: sAHIgAKx011235
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1416854532.44928@lzUw5/h/uz6+1mVlGInZ6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> The argument to git add is a pathspec, and the empty pathspec matches
> all files.

Err, why does the empty pathspec match all files? Isn't that a bug?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
