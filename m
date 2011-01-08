From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] commit: suggest --amend --reset-author to fix commiter identity
Date: Sat, 08 Jan 2011 11:56:00 +0100
Message-ID: <vpq1v4nirzz.fsf@bauges.imag.fr>
References: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vsjx45w7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 11:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbWTG-0003oj-8w
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 11:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab1AHK4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 05:56:11 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51949 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab1AHK4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 05:56:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p08Au0xW018663
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Jan 2011 11:56:00 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PbWSm-0002J6-LW; Sat, 08 Jan 2011 11:56:00 +0100
In-Reply-To: <7vsjx45w7g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 07 Jan 2011 11\:51\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 08 Jan 2011 11:56:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p08Au0xW018663
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1295088961.78911@4Lb+YSRmY1vSBwHK/Rd6Lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164814>

Junio C Hamano <gitster@pobox.com> writes:

> I don't think making the "cheat-sheet" insn longer by offering more
> choices is a good idea.  These are messages for lazy and busy
> people.

The reason I kept both forms was that the message is designed to be
seen once (or once for each new machine one works on), and the most
scary it is, the most efficient ;-). 

> Wouldn't it work better to just get rid of the longer form and say
> something like:
>
>     ... here is how to tell your name to git (existing message) ...
>
>     After doing the above, run
>
>     	git commit --amend --reset-author
>
>     to fix the identity used for this commit.

I'm fine with that proposal too. I'll resend with that if no one
objects. Probalby rewording it to

After doing this, you can fix the identity used for this commit with:

  git commit --amend --reset-author


would make it even concisier (no break of the sentence with a
command).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
