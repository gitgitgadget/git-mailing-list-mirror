From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] git-merge: mutually match SYNOPSIS and "usage".
Date: Wed, 08 Oct 2014 00:32:35 +0400
Message-ID: <87bnpnsjrw.fsf@osv.gnss.ru>
References: <87wq8cnla9.fsf@osv.gnss.ru>
	<xmqq4mvfg24e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 22:32:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbbR4-00043a-EW
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 22:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbaJGUci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 16:32:38 -0400
Received: from mail.javad.com ([54.86.164.124]:44803 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbaJGUch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 16:32:37 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 29F4E61878;
	Tue,  7 Oct 2014 20:32:37 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XbbQx-0005kn-Ee; Wed, 08 Oct 2014 00:32:35 +0400
In-Reply-To: <xmqq4mvfg24e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Oct 2014 11:34:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257958>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> SYNOPSIS section of the git-merge manual page had outdated explicit
>> list of options.
>>
>> "usage" returned by 'git merge -h' didn't have "-m <msg>" that is one
>> of essential distinctions between obsolete invocation form and the
>> recent one.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>
> Please do not do two unrelated things in a single change.

Well, I thought they are related, sorry.

> It may be a clear and very welcome improvement to change from
> "explicitly list only often used options" to "just say [options] and
> have the list of options and their descriptions".

OK, noticed.

> I am not sure about the other change to single out "-m <msg>",
> especially marking it as optional by enclosing it inside "[-m
> <msg>]", makes much sense, as that is still not very easily
> distinguishable from "git merge [options] [<commit>...]".

I was looking at the merge.c code, and that's how it seems to work. You
can get new semantics without -m, and you can't get old semantics with
-m, isn't it? It looks like the set of descriptions I produced is
formally correct.

> In other words, I agree with your motivation to call for attention
> that the command behaves differently with and without "-m", but I do
> not think that part of the change in this patch achieves it well.

Any particular suggestion?

Thanks.

-- 
Sergey.
