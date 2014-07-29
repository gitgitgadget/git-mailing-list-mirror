From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] use a hashmap to make remotes faster
Date: Tue, 29 Jul 2014 09:57:45 +0200
Message-ID: <vpqoaw8ha12.fsf@anie.imag.fr>
References: <305063.319715799-sendEmail@debian>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "patrick.reynolds\@github.com" <patrick.reynolds@github.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 09:57:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC2IH-0007QH-L9
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 09:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbaG2H5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 03:57:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59696 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbaG2H5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 03:57:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6T7viHj009450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2014 09:57:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6T7vjM5025949;
	Tue, 29 Jul 2014 09:57:45 +0200
In-Reply-To: <305063.319715799-sendEmail@debian> (patrick's message of "Tue,
	29 Jul 2014 03:53:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Jul 2014 09:57:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6T7viHj009450
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407225467.08256@QfXVLZqqlMJf/X7BS9M6Uw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254402>

"patrick.reynolds@github.com" <patrick.reynolds@github.com> writes:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It seems you mixed your name and email address in your config file. I
guess your name is "Patrick Reynolds", not
"patrick.reynolds@github.com".

> Remotes are stored as an array, so looking one up or adding one without
> duplication is an O(n) operation.  Reading an entire config file full of
> remotes is O(n^2) in the number of remotes.  For a repository with tens of
> thousands of remotes, the running time can hit multiple minutes.

Just being curious: in which senario do you have tens of thousands of
remotes?

(not an objection, it's a good thing anyway)

> +static inline void init_remotes_hash()

static inline void init_remotes_hash(void)

Not a detailed review, but the patch sounds good other than that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
