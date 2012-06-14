From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: lk/more-helpful-status-hints (was Re: What's cooking in git.git (Jun 2012, #03; Wed, 13))
Date: Thu, 14 Jun 2012 10:18:06 +0200
Message-ID: <vpq7gvacnnl.fsf@bauges.imag.fr>
References: <7vk3zag6jg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 10:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf5G4-0000Ep-Nd
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 10:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab2FNISS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 04:18:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47953 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab2FNISQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 04:18:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5E897sK021009
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 10:09:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sf5Fn-0006UG-Km; Thu, 14 Jun 2012 10:18:08 +0200
In-Reply-To: <7vk3zag6jg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 13 Jun 2012 16:01:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Jun 2012 10:09:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E897sK021009
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340266148.73024@AOEHpGZarcPzCO7asvrLrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199976>

Junio C Hamano <gitster@pobox.com> writes:

> * lk/more-helpful-status-hints (2012-06-11) 5 commits
>  - fixup! status: better advices when splitting a commit (during rebase -i)
>  - status: better advices when splitting a commit (during rebase -i)
>  - status: don't suggest "git rm" or "git add" if not appropriate
>  - t7512-status-help.sh: better advices for git status
>  - wt-status.*: better advices for git status added
>
> Almost there, modulo minor details pointed out by Matthieu.

The details I pointed out earlier are already fixed. I went through the
serie again, and suggest two more minor fixups:

fixup! reword message when splitting a commit.
fixup! don't allocate struct wt_status_state dynamically

patches follow.

> * lk/rebase-i-x (2012-06-13) 1 commit
>  - rebase -i: teach "--exec <cmd>"
>
> Adds -x <cmd> to "rebase -i" to insert "exec <cmd>" after each
> commit in the resulting history.
>
> Will merge to next after 1.7.11.

Cool!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
