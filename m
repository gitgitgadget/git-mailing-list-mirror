From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Make help behaviour more consistent
Date: Mon, 11 Mar 2013 09:13:27 +0100
Message-ID: <vpq620yfj6g.fsf@grenoble-inp.fr>
References: <1362937729-9050-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 11 09:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UExrr-0002dK-29
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 09:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab3CKINb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 04:13:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55775 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3CKINa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 04:13:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2B8DRbh008213
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 09:13:27 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UExrL-0005BL-Uk; Mon, 11 Mar 2013 09:13:27 +0100
In-Reply-To: <1362937729-9050-1-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Sun, 10 Mar 2013 19:48:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Mar 2013 09:13:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2B8DRbh008213
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363594407.68688@4+4mnhgwnJZHFfAOtDPamQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217861>

Kevin Bracey <kevin@bracey.fi> writes:

> Two significant usability flaws here:
>  - If using man, "man git" to side-step "git help" is obvious. But if
>    trying to use help.format=web, how to get the root html page? My
>    technique was "git help XXX" and click the "git(1) suite" link at the
>    bottom. "git help git" is non-obvious and apparently undocumented
>    (it's not mentioned by "git", "git help", or "git help help"...).

Can't this be solved by adding something like

  See 'git help git' for general help about Git.

to the output of "git help"? I think the fact that "git help" provides a
small amount of output (typically: fits on one screen) is a nice feature
that avoids scaring people too early with the actual doc.

That said, I'm no longer a user of the short command list, so maybe I'm
not a good judge ;-).

> Option list shown in command-line usage re-ordered to match the manual
> page, and git and git-help manual pages edited to reflect the new help
> behaviour.

This is typically better submitted as a separate patch. Putting
uncontroversial changes in their own patches help the discussion to
focus on important changes, and avoids distracting the review.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
