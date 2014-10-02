From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2014, #09; Tue, 30)
Date: Thu, 02 Oct 2014 10:46:55 -0700
Message-ID: <xmqqvbo2nz3k.fsf@gitster.dls.corp.google.com>
References: <xmqq38b8svrd.fsf@gitster.dls.corp.google.com>
	<20141001040124.GA32748@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 19:48:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZkU4-0007oE-PT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 19:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbaJBRsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 13:48:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64770 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbaJBRsC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 13:48:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F38C33E134;
	Thu,  2 Oct 2014 13:48:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Yg6TRiJlDN5Ok5tq+7buoAuHAU=; b=NWGhKM
	To1VI0Acp4l5Wy5mVMF4sFYU0xPGHE58mRxokUeSLvLX6mv7OxwvDIQhyBNSF98i
	SF6zfN8FuTpV4BtKm1M7dFOUv+qn20vhq66fwLJYT6dfpHWafj5zw5lVsjFuB/qN
	theFeNU7HJ094zubtKQrMVTvMRsv8s/9Rj3CU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XWP61F5zH6NWLhQTQrc9xtSH+CLOY07Q
	PNE88dNBrz3sxyyaUIsED73rq3J9aUkxFORF0XGyyNBZVMFQqDBk0yPypTgpIOqr
	BFZhaDZMv7AtqMVVcW7KJcfDk433o673rURV21eLLgziyWX4H3mQBoFZ/FzJeS62
	j9YsbD+gGek=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 911BA3E133;
	Thu,  2 Oct 2014 13:48:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 319033E08F;
	Thu,  2 Oct 2014 13:46:57 -0400 (EDT)
In-Reply-To: <20141001040124.GA32748@gmail.com> (David Aguilar's message of
	"Tue, 30 Sep 2014 21:01:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AA05662-4A5C-11E4-9401-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257814>

David Aguilar <davvid@gmail.com> writes:

> On Tue, Sep 30, 2014 at 01:23:18PM -0700, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>> 
>> * da/include-compat-util-first-in-c (2014-09-15) 4 commits
>>  - SQUASH???
>>  - check-headers: add header usage checks for .c files
>>  - Makefile: add check-headers target
>>  - cleanups: ensure that git-compat-util.h is included first
>> 
>>  So... what is happening to this topic?  I think the bottom one is a
>>  reasonable clean-up without too much churn, but I am not sure about
>>  the rest.
>
> Agreed. The SQUASH??? commit could be squashed in, but it might
> just be better to take the bottom commit and drop the rest since
> they aren't really that helpful.

OK, let's do that.
