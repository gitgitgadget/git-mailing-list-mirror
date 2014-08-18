From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Mon, 18 Aug 2014 12:53:45 +0400
Message-ID: <87ha1advqe.fsf@osv.gnss.ru>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
	<87d2c22cnx.fsf@osv.gnss.ru>
	<xmqq38cx1w0e.fsf@gitster.dls.corp.google.com>
	<87ioltik7g.fsf@osv.gnss.ru>
	<xmqqioltza8z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 10:54:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJIhZ-0008Oh-R8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 10:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaHRIxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 04:53:49 -0400
Received: from mail.javad.com ([54.86.164.124]:39396 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbaHRIxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 04:53:48 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 53BF660BF3;
	Mon, 18 Aug 2014 08:53:47 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XJIhF-0000Q0-LD; Mon, 18 Aug 2014 12:53:45 +0400
In-Reply-To: <xmqqioltza8z.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Aug 2014 14:57:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255382>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> A sentence "--force has no effect under --preserve-merges mode" does
>>> not tell the readers very much, either and leaves them wondering if
>>> it means "--preserve-merges mode always rebases every time it is
>>> asked, never noticing 'ah, the history is already in a good shape
>>> and there is no need to do anything further'" or "--preserve-merges
>>> mode ignores --force and refuses to recreate the history if the
>>> history is in the shape the mode deems is already desirable."
>>
>> In fact there is no way to force rebase when --preserve-merges is given.
>> Neither --force nor --no-ff has any effect.
>>
>> Maybe some clarification could be given in --preserve-merges
>> description, provided it's not clear that "has no effect" for --force
>> means that one can't force the rebase in this case.
>
> I am not sure if that is an intended behaviour or simply a bug

I think nobody actually ever needed to make it work, even though
fundamentally it could have the same usage as in the case of flattening
rebase. Once again, it seems that most uses of rebase handle already
flat history and thus are served by vanilla invocation.

> (I rarely use preserve-merges myself, so I offhand do not know for
> certain).

I wonder, don't you yourself use preserve-merges because you don't care
and just use the default, or because you actually use vanilla
history-flattening feature?

-- 
Sergey.
