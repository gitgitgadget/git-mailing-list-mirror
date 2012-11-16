From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: add advice on how to push/pull to tracking branch
Date: Fri, 16 Nov 2012 10:27:03 +0100
Message-ID: <vpqy5i1c2zc.fsf@grenoble-inp.fr>
References: <1352976300-20159-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vr4nu92hm.fsf@alter.siamese.dyndns.org>
	<vpqmwyid59i.fsf@grenoble-inp.fr>
	<7vmwyi8rjt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 10:27:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZICu-0005S2-3i
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 10:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217Ab2KPJ1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 04:27:13 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47815 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2KPJ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 04:27:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qAG9JOri003511
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Nov 2012 10:19:24 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TZICW-0007vw-BW; Fri, 16 Nov 2012 10:27:04 +0100
In-Reply-To: <7vmwyi8rjt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Nov 2012 13:49:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Nov 2012 10:19:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAG9JOri003511
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1353662367.22108@qTD84PLwj7w0uXJdjOd39Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209867>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I don't understand what you mean by "non-current". If you mean a local
>> branch not pointed to by HEAD, then I don't understand the remark, as
>> the message is shown by "git status" (looking more closely, it is also
>> shown by "git checkout", but after switching branch so also showing a
>> message about the current branch) and precisely talks about the current
>> branch.
>
> Ah, Ok, I somehow thought that "branch -v" would also use this
> information, and/or during my absense this function from remote.c
> got linked into "git remote show" ;-)

OK.

> So it is not an issue right now, but we will have to worry about the
> messaging when we start using this to describe a branch that is not
> currently checked out.

(Anyway, we'd have to reword it a bit: saying "Your branch ..." would be
wrong in this case)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
