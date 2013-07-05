From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
Date: Fri, 05 Jul 2013 01:11:49 -0700
Message-ID: <7vwqp58lyy.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
	<cover.1372939482.git.Alex.Crezoff@gmail.com>
	<38cdab6c314e858ec580b1d0fbf87098c2d92cb0.1372939482.git.Alex.Crezoff@gmail.com>
	<7vy59la4gn.fsf@alter.siamese.dyndns.org>
	<20130705080011.GB32072@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:12:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv17Z-0004Kx-8j
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177Ab3GEIL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:11:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162Ab3GEILy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:11:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 159CA28238;
	Fri,  5 Jul 2013 08:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iE5qeTEKbR89Jf1pOypOAAYVPP0=; b=wIK57H
	MWWyhVW0gIVC0gIp4vyFgwcE80uNyAosGXCKApbbigofjB3JtC33t4Fs7K4r2t6y
	JHbBCpeTh0HbuSPv+KO8qaQngiWcgdyZw7G3z40QsSgj9GivHrr+iq4X5lQ2MLmk
	BPMZrbQ32MHsxkSSxwvcyzwyk0B2Y2GuQh+c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UdBdpxHDUUxh6piJ8gUmNEO/4E1qM7fQ
	YYnfLkD2ovRecfHyAuMsvFUUBFY29kSpg1iaM9P7iMX+TZoTR9cC8nKV1nw8vf8c
	e/v9f7RJyJxoql7Cc1mssd3zf1/zpdL3gpWmREFNkc8JoDT5fvM4T2EFiChFwGrR
	0SzgFKQgmfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E7428237;
	Fri,  5 Jul 2013 08:11:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0CE628231;
	Fri,  5 Jul 2013 08:11:51 +0000 (UTC)
In-Reply-To: <20130705080011.GB32072@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Fri, 5 Jul 2013 12:00:11 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C8B1546-E54A-11E2-AD07-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229635>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>> 	Both "iso8859-1" and "iso-8859-1" are understood as latin-1
>> 	by modern platforms, but the latter is not understood by
>> 	older platforms;update tests to use the former.
>> 
>>         This is in line with 3994e8a9 (t4201: use ISO8859-1 rather
>> 	than ISO-8859-1, 2009-12-03), which did the same.
> Yep, it whould be better, I thought to do like this but I didn't )
>> 
>> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
>> > Reviewed-by: Johannes Sixt <j.sixt@viscovery.net>
>> 
>> I do not recall this exact patch reviewed by J6t, but perhaps I
>> missed a message on the list?
> I've reread 'SubmittingPatches' doc, and I can say I used "Reviewed-by"
> incorrectly. Sorry for this. It must be "Suggested-by" there, I guess.

OK, then I'll queue this patch (but not 2-4/5 yet) with log message
amended.

Thanks.
