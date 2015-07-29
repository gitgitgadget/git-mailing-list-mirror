From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Log messages beginning # and git rebase -i
Date: Wed, 29 Jul 2015 12:17:56 +0200
Message-ID: <vpqk2tjl12j.fsf@anie.imag.fr>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
	<xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
	<vpq3808p40o.fsf@anie.imag.fr>
	<xmqqtwsodsw0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 12:18:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKOR8-0000Ug-6F
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 12:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbbG2KSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 06:18:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49841 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbbG2KSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 06:18:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6TAHtVO020992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 12:17:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TAHuU7015240;
	Wed, 29 Jul 2015 12:17:56 +0200
In-Reply-To: <xmqqtwsodsw0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jul 2015 11:44:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Jul 2015 12:17:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TAHtVO020992
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438769877.87394@C0zUsBgCsPEELa9Wl04TuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274888>

Junio C Hamano <gitster@pobox.com> writes:

> OK.  So the proposal on the table is that a backslash at the
> beginning of a line is stripped.

Yes.

> Stripping part should look like this.

Thanks.

> To make it work for things like "git commit --amend", you would need
> to prefix any line that comes from the payload that begins with the
> core.commentchar or a backslash with a backslash.

That's it, probably the hardest part. No Git time budget for now, but
I'm adding this here in case I get time or a student to work on it:
http://git.wiki.kernel.org/index.php/SmallProjectsIdeas

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
