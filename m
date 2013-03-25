From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] t7800: run --dir-diff tests with and without
 symlinks
Date: Mon, 25 Mar 2013 14:50:38 -0700
Message-ID: <7vobe7w3m9.fsf@alter.siamese.dyndns.org>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk>
 <514FFC3C.3010203@viscovery.net> <20130325103516.GC2286@serenity.lan>
 <51502E00.7070904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:51:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFIM-0006oa-KR
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330Ab3CYVum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:50:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933283Ab3CYVul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:50:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1F49AEF4;
	Mon, 25 Mar 2013 17:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RSOBjQfAQXL199jlFyYFGO+NzkM=; b=kbkjgK
	c0TNGznjDcPRb5EBc9U4dADBy0fcUf8b0yhsBUijccrlLtiBnRGVnOTzX+UUblvs
	U1IU2Ei3ebv6i4Tx4ot5w/p4AVDyF/zyQrTrh1LzJ5xjn5EP1hgTDvCkT1Pr7nyR
	XvPeJwfcg9cOM3nbt79cZqMxBiJYMYR5Dn1fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G++iPKPFI+/BviC5iFfwpeQ2F4XfFDep
	0R/MSXYUgGULW7yIrpt80UJBxztszPWa2acLOi/6wdSQSrK0cKMAap4wSc3CVldy
	/viumLkTpo+gz1ZgQT3XivdTHhFoQfN5mMiK+eXv4DrafycPInc2dc7rbPxGkIQk
	flHt+CAgzFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4751AEF3;
	Mon, 25 Mar 2013 17:50:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 531F7AEF2; Mon, 25 Mar 2013
 17:50:40 -0400 (EDT)
In-Reply-To: <51502E00.7070904@viscovery.net> (Johannes Sixt's message of
 "Mon, 25 Mar 2013 11:59:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 090C236C-9596-11E2-BB70-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219102>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/25/2013 11:35, schrieb John Keeping:
>> On Mon, Mar 25, 2013 at 08:26:52AM +0100, Johannes Sixt wrote:
>>> The series looks good, but I can't test it because it does not apply
>>> anywhere here.
>> 
>> It's built on top of da/difftool-fixes, is there some problem that stops
>> it applying cleanly on top of that?
>
> Thanks. I had only tried trees that were "contaminated" by
> jk/difftool-dir-diff-edit-fix, which is in conflict with da/difftool-fixes.

Yes, the conflict was unpleasant to deal with.  John, I think what
is queued on 'pu' is OK, but please double check after I push it out
in a few hours.
