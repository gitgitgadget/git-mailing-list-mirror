From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 21:40:51 +0200
Message-ID: <vpqlhg8pk1o.fsf@anie.imag.fr>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
	<1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqiobcy9yt.fsf@anie.imag.fr>
	<xmqqtwuwh8fv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 21:41:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3fs-000317-BT
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbbE1TlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 15:41:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51558 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbbE1Tk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:40:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4SJen3M029117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 21:40:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SJepuF017242;
	Thu, 28 May 2015 21:40:51 +0200
In-Reply-To: <xmqqtwuwh8fv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 May 2015 11:18:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 May 2015 21:40:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SJen3M029117
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433446851.646@mLBpgUrGILdfX4RDEXe+7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270185>

Junio C Hamano <gitster@pobox.com> writes:

> If this topic enhances 'git status' with the in-progress rebase
> information, I'd view it as turning 'git status' from 'a more or
> less useless command during rebase' to 'a useful command'.

For day-to-day operations, what we already have in status already
qualifies as 'useful command' to me:

$ git status
rebase in progress; onto 7f9a792
You are currently rebasing branch 'master' on '7f9a792'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

I like the output of "git status" to be concise. OTOH, there are tons of
information in .git/rebase-merge/ that could be displayed to the user.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
