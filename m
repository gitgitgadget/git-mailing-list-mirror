From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Fri, 11 Apr 2014 23:49:43 -0700
Message-ID: <7v61mfm48o.fsf@alter.siamese.dyndns.org>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
	<53487a78f38bf_3b596b93106e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 08:48:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYrk7-0008S8-SW
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 08:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbaDLGsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 02:48:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbaDLGsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 02:48:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B1F69D76;
	Sat, 12 Apr 2014 02:48:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U+oCumUFcoetaw0EtFQoR4cYQ/4=; b=AHHMrR
	oWcAKLq9YiFRdj+NgL5m04Db6TklnQZf2UvwZfXVysswLT4OXr87S1b/O9Y5zGY5
	2BwP0UdIRr0iwvhEXAKztIyt20I+nyPjFV/JAXJhuj4gMOV8ePkMW4NcUT9sXMfv
	motvR8aHjL8zAIpr7rTE/zWBgvFS1XZBYohog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q/vso7Ve0WzI0FDmOu58steU6JP3MUlP
	98ch6bBQOY5BM8rywmwCxDbPlZI22QB2YrlHemxuB1A6UMMeyUPdUxinE+BqgNvI
	8OOcwA7rCuIl32spW/bmO/n38O30hXDI4/k4Qt2ReBYNFR/RQ/3WfSYYnp3hr2KT
	LRxWRdaF/xw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8713F69D75;
	Sat, 12 Apr 2014 02:48:11 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3278269D71;
	Sat, 12 Apr 2014 02:48:10 -0400 (EDT)
In-Reply-To: <53487a78f38bf_3b596b93106e@nysa.notmuch> (Felipe Contreras's
	message of "Fri, 11 Apr 2014 18:27:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 693E3C98-C20E-11E3-B0CC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246163>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> * fc/complete-aliased-push (2014-04-09) 1 commit
>>  - completion: fix completing args of aliased "push", "fetch", etc.
>> 
>>  Will merge to 'next'.
>> 
>> 
>> * fc/remote-helper-fixes (2014-04-09) 4 commits
>>  - remote-bzr: include authors field in pushed commits
>
> Before you do, you might want to pick the unrelated fix I just sent[1],
> otherwise this test might fail on some machines.

Will pick up $gmane/246157 (or at least will try to remember ;-).
Thanks.

>>  - remote-bzr: add support for older versions
>>  - remote-hg: always normalize paths
>>  - remote-helpers: allow all tests running from any dir
>> 
>>  Will merge to 'next'.
>
>> * fc/publish-vs-upstream (2014-04-11) 8 commits
>>  - sha1_name: add support for @{publish} marks
>>  - sha1_name: simplify track finding
>>  - sha1_name: cleanup interpret_branch_name()
>>  - branch: display publish branch
>>  - push: add --set-publish option
>>  - branch: add --set-publish-to option
>>  - Add concept of 'publish' branch
>>  - t5516 (fetch-push): fix test restoration
>> 
>>  Add branch@{publish}; this round v3 hasn't yet seen much reviews
>>  yet.
>> 
>>  Seems to have some interactions to break tests when merged to 'pu'.
>
> That was v2, wasn't it?

The tip d95807a0e1b7 (sha1_name: add support for @{publish} marks,
2014-04-11) is with timestamp "Fri Apr 11 12:59:11 2014 -0500",
which matches $gmane/246122, so I am reasonably sure that I applied
the v3 on the same base as the base I queued the v2 on, compared
them and then updated the branch.  Also I can tell by seeing some
patches lost the retitle I did for the previous round.
