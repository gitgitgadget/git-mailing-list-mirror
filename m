From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge: inconsistent manual page.
Date: Tue, 30 Oct 2007 17:05:31 -0700
Message-ID: <7v4pg8jghg.fsf@gitster.siamese.dyndns.org>
References: <fg7b6o$k1f$1@ger.gmane.org>
	<7vsl3sla5q.fsf@gitster.siamese.dyndns.org>
	<7vk5p4l9gs.fsf@gitster.siamese.dyndns.org>
	<87wst44cvb.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In15i-0008K2-IQ
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbXJaAFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbXJaAFi
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:05:38 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:36047 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbXJaAFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:05:37 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A2C36310;
	Tue, 30 Oct 2007 20:05:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EFB090779;
	Tue, 30 Oct 2007 20:05:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62765>

Sergei Organov <osv@javad.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Subject: git-merge: document but discourage the historical syntax
>>
>> Historically "git merge" took its command line arguments in a
>> rather strange order.  Document the historical syntax, and also
>> document clearly that it is not encouraged in new scripts.
>>
>> There is no reason to deprecate the historical syntax, as the
>> current code can sanely tell which syntax the caller is using,
>> and existing scripts by people do use the historical syntax.
>
> OK, your patch is better than what I've suggested. The only thing that
> your patch seems to be missing is prepending -m to <msg>:: in the
> OPTIONS section. Yeah, it could be more strict to just describe <msg>,
> ...

Nah, you are absolutely right.  We describe "-s <strategy>"
under the headline with the leading "-s".

Will fix.
