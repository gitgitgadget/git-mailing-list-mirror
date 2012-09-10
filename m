From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 20:36:43 +0200
Message-ID: <504E333B.2010602@kdbg.org>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com> <1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com> <vpqk3w1j15v.fsf@bauges.imag.fr> <CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com> <20120910165457.GB14201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 20:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB8qr-0002O9-RC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 20:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab2IJSgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 14:36:46 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:4169 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751535Ab2IJSgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 14:36:45 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ED96C2C4011;
	Mon, 10 Sep 2012 20:36:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 96EF319F346;
	Mon, 10 Sep 2012 20:36:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <20120910165457.GB14201@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205160>

Am 10.09.2012 18:54, schrieb Jeff King:
> On Mon, Sep 10, 2012 at 12:46:45PM -0400, Andrew Wong wrote:
> 
>>> Just "edit" may be a bit misleading, as we already have the "edit"
>>> action inside the todolist. I'd call this --edit-list to avoid
>>> ambiguity.
>>
>> I thought that might be a bit confusing too. "--edit-list" doesn't
>> seem informative about what "list" we're editing though. What about
>> "--edit-todo"? Any suggestions are welcomed.
> 
> Does it ever make sense to edit and then _not_ immediately continue?

Yes. For example, while you are resolving a conflict, you might notice
that it would make sense to do something different in the remaining
rebase sequence. You don't want to continue if some conflicts remain.
And you don't want to wait editing the todo list until you are done with
the conflicts because you might have forgotten that you wanted to do
something different.

> You can't affect the current commit anyway (it has already been pulled
> from the todo list), so the next thing you'd want to do it actually act
> on whatever you put into the todo list[1].

Oh, you said it here:

> [1] It does preclude using "--edit" to make a note about a later commit
>     while you are in the middle of resolving a conflict or something.
>     You'd have to do it at the end. I don't know if anybody actually
>     cares about that.

Yes, I do care. At times I tend to have a very short attention span. Or
it is Windows's slowness that expires my short-term memory more often
than not. ;)

-- Hannes
