From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 17:00:54 -0700
Message-ID: <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 02:01:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiBln-0007Ov-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 02:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaEHAA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 20:00:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59796 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbaEHAA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 20:00:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A127C1693E;
	Wed,  7 May 2014 20:00:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WG6M9DXRLFM/1HFCY8DrrgDbiA8=; b=iYuMTODhtZXfLhvu00am
	3hzn/2Qh/UUcLgYOhOmcg6q5p60YmL4HK2DbVAD2u5cIyJfyStaqau/2TO07mmlt
	XNGZl5u4pp4NyWSJkdqyz34GJq2MyjUfv/q7xJx9zPUHtCUusajwjffaiJFMl8+W
	8RVsYO5NC3Lt0KypF9jNPjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=n0oWUqmSmZUV7HduwHzwbrKozRO/KU2DIq7rKDeEUI73Hl
	q8bsw/NdmBRu6GTlAJdFF8pKRb3Ut+1r3Xc4KRUmA8rNkCVQPMzy9FxcrDAAeNbK
	frkXJ7Nmuv5V/5+iFO8TS1lY2PZeBgKwfJD/q65bWunF296Y7BHkmUmDE86cw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96FD61693D;
	Wed,  7 May 2014 20:00:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 484F216938;
	Wed,  7 May 2014 20:00:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D43B5FBE-D643-11E3-9653-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248392>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Here's a bunch of tests more, and a fixes for Mercurial v3.0.
>
> I think the discussion with John Keeping hints that we shouldn't be
> rushing fc/remote-helpers-hg-bzr-graduation and this does not appear
> to assume the presense of that series, which is good in order to
> make these fixes jump over them.

When merged to a place somewhere early between the next and the pu
branches (aka "the jch branch", which is the version I usually use
myself), this seemed to break t5810, so I did today's integration
cycle one more time by excluding this topic and then instead queuing
it near the tip of the pu branch (read: today's 'pu' does not pass
the test suite for me).

There may be some other changes that this series depends on that I
may have missed that caused this breakage.  Can you take a look?

Thanks.
