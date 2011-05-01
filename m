From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sun, 01 May 2011 11:04:22 +0200
Message-ID: <vpqoc3mg5bd.fsf@bauges.imag.fr>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
	<7vfwp1yqnq.fsf@alter.siamese.dyndns.org>
	<1304238652.9638.1446946253@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 01 11:04:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGSaH-0005hr-Pm
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 11:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab1EAJEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 05:04:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55136 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab1EAJEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 05:04:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4194MFr028364
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 1 May 2011 11:04:22 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QGSZj-0000aD-3Q; Sun, 01 May 2011 11:04:23 +0200
In-Reply-To: <1304238652.9638.1446946253@webmail.messagingengine.com> (Michael
	J. Gruber's message of "Sun, 01 May 2011 10:30:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 01 May 2011 11:04:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4194MFr028364
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1304845463.86549@Jben+BUgmx5mqh6unnKfjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172535>

"Michael J Gruber" <git@drmicha.warpmail.net> writes:

> On Fri, 29 Apr 2011 09:21 -0700, "Junio C Hamano" <gitster@pobox.com>
> wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>> > HEAD~n is often used for rebase invocations etc.
>> 
>> I thought rebase invocations these days use @{u}.
>> 
>
> I meant "rebase -i", sorry. And in fact I mostly mean those cases where
> I want to "amend" a commit which is not the top most one.
>
> Michael

... and Junio is right that

  git rebase -i @{u}

usually does the right thing: let you amend any of the unpushed commits.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
