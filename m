From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: Hide '-r' option in default usage
Date: Wed, 13 Apr 2011 11:09:56 -0700
Message-ID: <7vhba2m39n.fsf@alter.siamese.dyndns.org>
References: <1302449954-15353-1-git-send-email-artagnon@gmail.com>
 <7vhba4v6p8.fsf@alter.siamese.dyndns.org> <20110413132146.GB26760@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:10:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA4W8-0008Pq-Oo
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 20:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab1DMSKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 14:10:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1DMSKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 14:10:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 739F14153;
	Wed, 13 Apr 2011 14:12:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQu/nND/JejcupO4+osX4QI7ZPk=; b=H00Dls
	uaIyxyQwNnuXZbUO5MdaNy/uHsSvIToiYKh4lqOL24FOorII/JQ6i3R72tlqv/j8
	zZJkel84plJBlK/yQv7+OyLlXcjcXQ+rzqg2xfAt6jU3LyRCsWWacbZsIZU/Pc0P
	75HsrZQC84sIFM0E7V+exO3i+wZlh69Ny2DR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rprk/R5lLgpRUr3ZBDyjq715vEwK6wPK
	17gv3EHGDbiXWung92DGKuLR4ziZfzq94ygKdBXsRyIZ6O1aCT9YQknfkZW/riHw
	jG1npGrG+AtKNUuzQdRYbmymWQMrcOkChRakR1KOm/FvfPZCE09BhWQMIwf+LSPN
	WS8CAUoyyvU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E65D4152;
	Wed, 13 Apr 2011 14:12:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 55EA14151; Wed, 13 Apr 2011
 14:11:58 -0400 (EDT)
In-Reply-To: <20110413132146.GB26760@kytes> (Ramkumar Ramachandra's message
 of "Wed, 13 Apr 2011 18:51:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 874BE9F2-65F9-11E0-BB0F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171467>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Junio,
>
> Junio C Hamano writes:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> 
>> > Since the '-r' command-line option is a no-op provided only for
>> > backward compatiblity, don't advertise it in the default usage.
>> >
>> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> > ---
>> 
>> Thanks.
>> 
>> It would have saved me a lot of time if you wrote that this option has
>> been a no-op since abd6970 (cherry-pick: make -r the default, 2006-10-05),
>> but the commit didn't remove it from the usage string, and it somehow
>> survived 9509af6 (Make git-revert & git-cherry-pick a builtin, 2007-03-01)
>> and later f810379 (Make builtin-revert.c use parse_options, 2007-10-07),
>> and it is about time to stop advertising it.
>
> Thanks.  I didn't realize there was so much history to write about.

Not necessarily in the final commit message; before "---" would have been
sufficient.

> Has you queued this somewhere?

Sorry, after spending time to dig the history to see when we made this a
no-op to ensure that it was sufficiently long time ago and wrote my
finding in the message to you, I forgot to apply the patch.  Will queue.

Thanks.
