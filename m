From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v2] Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
Date: Tue, 30 Sep 2014 00:17:48 +0400
Message-ID: <8738ba5ggj.fsf@osv.gnss.ru>
References: <87r3z72wiu.fsf@osv.gnss.ru> <87k34mn0ht.fsf@osv.gnss.ru>
	<xmqq7g0m75qk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 22:18:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYhOO-0007xS-36
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 22:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbaI2URw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 16:17:52 -0400
Received: from mail.javad.com ([54.86.164.124]:40269 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbaI2URv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 16:17:51 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 6E2DA61861;
	Mon, 29 Sep 2014 20:17:50 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XYhOG-0005yO-IP; Tue, 30 Sep 2014 00:17:48 +0400
In-Reply-To: <xmqq7g0m75qk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 29 Sep 2014 09:26:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257637>

Junio C Hamano <gitster@pobox.com> writes:
> Sergey Organov <sorganov@gmail.com> writes:
>

[...]

>> As asked by Junio C Hamano <gitster@pobox.com>, the newly introduced
>> 'fork_point' term has been described.
>>
>
> I suspect "will be used as a fallback" might be easier to understand
> what is going on instead of "will be used instead", but other than
> that, the new explanation of what fork-point is is a very welcome
> update, I think.

Yeah, sure. Wasn't satisfied with the wording myself.

[...]

> The patch failed to apply

Sorry about it.

> Applying: Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
> fatal: corrupt patch at line 38

I rather get:

$ git apply x.patch
x.patch:38: trailing whitespace.
	introduced by <branch>. 
warning: 1 line adds whitespace errors.

I've used 'git format-patch' to prepare the patch. Shouldn't it warn
about such things? Or what should I do to avoid such problems in the
future? 

>
> but the fix-up is trivial, so no need to resend.

Thanks.

-- 
Sergey.
